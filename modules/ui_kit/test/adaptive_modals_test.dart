import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';
import 'package:ui_kit/ui_kit.dart';

void main() {
  Future<void> openAt(WidgetTester tester, double width, Future<void> Function(BuildContext) open) async {
    tester.view
      ..physicalSize = Size(width, 900)
      ..devicePixelRatio = 1;
    addTearDown(tester.view.reset);
    await tester.pumpWidget(
      MaterialApp(
        theme: AppTheme.light,
        home: Builder(
          builder: (context) => Scaffold(
            body: TextButton(onPressed: () => open(context), child: const Text('open')),
          ),
        ),
      ),
    );
    await tester.tap(find.text('open'));
    await tester.pumpAndSettle();
  }

  Future<void> sheet(BuildContext context) => showModalBottomSheet<void>(
    context: context,
    builder: (_) => const SizedBox(width: double.infinity, height: 200, key: Key('body')),
  );

  Future<void> dialog(BuildContext context) => showDialog<void>(
    context: context,
    builder: (_) => const AlertDialog(content: SizedBox(width: 2000, height: 100, key: Key('body'))),
  );

  testWidgets('a bottom sheet spans a phone but stays a column on a desktop window', (tester) async {
    await openAt(tester, 390, sheet);
    expect(tester.getSize(find.byKey(const Key('body'))).width, 390);

    Navigator.of(tester.element(find.byKey(const Key('body')))).pop();
    await tester.pumpAndSettle();

    await openAt(tester, 1600, sheet);
    expect(tester.getSize(find.byKey(const Key('body'))).width, ContentWidth.reading);
  });

  testWidgets('a dialog never grows wider than a form column', (tester) async {
    await openAt(tester, 1600, dialog);
    // The Material surface of the dialog, not the full-window route around it.
    final surface = find.descendant(of: find.byType(AlertDialog), matching: find.byType(Material)).first;
    expect(tester.getSize(surface).width, lessThanOrEqualTo(ContentWidth.form));
  });

  test('the dark theme carries the same limits', () {
    expect(AppTheme.dark.bottomSheetTheme.constraints?.maxWidth, ContentWidth.reading);
    expect(AppTheme.dark.dialogTheme.constraints?.maxWidth, ContentWidth.form);
  });
}
