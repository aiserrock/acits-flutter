import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';
import 'package:ui_kit/ui_kit.dart';

void main() {
  Future<void> pump(WidgetTester tester, double width) => tester.pumpWidget(
    MediaQuery(
      data: MediaQueryData(size: Size(width, 900)),
      child: const MaterialApp(
        home: ListDetailLayout(
          list: ColoredBox(key: Key('list'), color: Colors.red),
          detail: ColoredBox(key: Key('detail'), color: Colors.blue),
        ),
      ),
    ),
  );

  testWidgets('a narrow window shows only the detail navigator', (tester) async {
    await pump(tester, 390);

    expect(find.byKey(const Key('list')), findsNothing);
    expect(find.byKey(const Key('detail')), findsOneWidget);
  });

  testWidgets('a wide window puts the list on the left at its fixed width', (tester) async {
    await tester.binding.setSurfaceSize(const Size(1300, 900));
    addTearDown(() => tester.binding.setSurfaceSize(null));
    await pump(tester, 1300);

    expect(tester.getSize(find.byKey(const Key('list'))).width, ListDetailLayout.defaultListWidth);
    expect(tester.getTopLeft(find.byKey(const Key('list'))).dx, 0);
    expect(tester.getSize(find.byKey(const Key('detail'))).width, 1300 - ListDetailLayout.defaultListWidth - 1);
  });

  testWidgets('the split starts at the expanded breakpoint', (tester) async {
    late bool below;
    late bool at;
    Widget probe(double width, void Function(bool) out) => MediaQuery(
      data: MediaQueryData(size: Size(width, 900)),
      child: Builder(
        builder: (context) {
          out(ListDetailLayout.isSplit(context));
          return const SizedBox();
        },
      ),
    );

    await tester.pumpWidget(probe(Breakpoints.expanded - 1, (v) => below = v));
    await tester.pumpWidget(probe(Breakpoints.expanded, (v) => at = v));

    expect(below, isFalse);
    expect(at, isTrue);
  });
}
