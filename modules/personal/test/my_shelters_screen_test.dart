import 'dart:ui' show Tristate;

import 'package:core/domain.dart' show Shelter;
import 'package:material_ui/material_ui.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:localization/localization.dart';
import 'package:personal/personal.dart';
import 'package:ui_kit/ui_kit.dart' show ErrorHolderWidget, PrimaryButton;
import 'package:util/util.dart';

class _FakeSource implements MySheltersSource {
  _FakeSource(this._results);

  final List<Result<Failure, List<Shelter>>> _results;
  int loads = 0;

  @override
  final int? currentShelterId = 1;

  @override
  Future<Result<Failure, List<Shelter>>> load() async =>
      _results[loads++ < _results.length ? loads - 1 : _results.length - 1];
}

const _a = Shelter(id: 1, name: 'Alpha');
const _b = Shelter(id: 2, name: 'Beta');

Future<void> _pump(WidgetTester tester, MySheltersSource source, ValueChanged<Shelter> onSwitch) async {
  await tester.pumpWidget(
    MaterialApp(
      home: MySheltersScreen(source: source, onSwitch: onSwitch),
    ),
  );
  await tester.pump();
  await tester.pump();
}

void main() {
  testWidgets('marks the current shelter and reports a tap on another one', (tester) async {
    final semantics = tester.ensureSemantics();
    final switched = <Shelter>[];
    await _pump(
      tester,
      _FakeSource([
        const Ok([_a, _b]),
      ]),
      switched.add,
    );

    expect(find.text('Alpha'), findsOneWidget);
    expect(find.text('Beta'), findsOneWidget);

    // Exactly one check icon, in the current row, labelled for screen readers.
    expect(find.byIcon(Icons.check), findsOneWidget);
    expect(
      find.descendant(of: find.widgetWithText(ListTile, 'Alpha'), matching: find.byIcon(Icons.check)),
      findsOneWidget,
    );
    // The row merges its children: the current one announces the label and is selected.
    final current = tester.getSemantics(find.widgetWithText(ListTile, 'Alpha'));
    final other = tester.getSemantics(find.widgetWithText(ListTile, 'Beta'));
    expect(current.label, contains(LocaleKeys.personMySheltersCurrent));
    expect(current.flagsCollection.isSelected, Tristate.isTrue);
    expect(other.flagsCollection.isSelected, isNot(Tristate.isTrue));
    expect(other.label, isNot(contains(LocaleKeys.personMySheltersCurrent)));
    expect(tester.widget<ListTile>(find.widgetWithText(ListTile, 'Alpha')).selected, isTrue);
    expect(tester.widget<ListTile>(find.widgetWithText(ListTile, 'Beta')).selected, isFalse);

    // Tapping the current shelter does nothing.
    await tester.tap(find.text('Alpha'));
    expect(switched, isEmpty);

    await tester.tap(find.text('Beta'));
    expect(switched, [_b]);
    semantics.dispose();
  });

  testWidgets('shows the empty message for an empty list', (tester) async {
    await _pump(tester, _FakeSource([const Ok(<Shelter>[])]), (_) {});

    expect(find.text(LocaleKeys.personMySheltersEmpty), findsOneWidget);
    expect(find.byType(ListTile), findsNothing);
  });

  testWidgets('pull-to-refresh reloads the list', (tester) async {
    final source = _FakeSource([
      const Ok([_a]),
      const Ok([_a, _b]),
    ]);
    await _pump(tester, source, (_) {});
    expect(find.text('Beta'), findsNothing);

    await tester.drag(find.text('Alpha'), const Offset(0, 400));
    await tester.pumpAndSettle();

    expect(source.loads, 2);
    expect(find.text('Beta'), findsOneWidget);
  });

  testWidgets('shows the error state and retries', (tester) async {
    // The error stub sizes its illustration off the viewport; give it a phone-sized screen.
    tester.view.physicalSize = const Size(1080, 2400);
    tester.view.devicePixelRatio = 3.0;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    final source = _FakeSource([
      const Err(NoInternet()),
      const Ok([_a]),
    ]);
    await _pump(tester, source, (_) {});

    expect(find.byType(ErrorHolderWidget), findsOneWidget);
    expect(find.text('Alpha'), findsNothing);

    await tester.tap(find.byType(PrimaryButton));
    await tester.pump();
    await tester.pump();

    expect(source.loads, 2);
    expect(find.byType(ErrorHolderWidget), findsNothing);
    expect(find.text('Alpha'), findsOneWidget);
  });
}
