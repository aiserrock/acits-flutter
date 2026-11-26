import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';
import 'package:ui_kit/ui_kit.dart';

void main() {
  late List<String> fired;

  setUp(() => fired = []);

  Future<void> pump(WidgetTester tester, {bool withSearchField = false, bool escape = false}) => tester.pumpWidget(
    MaterialApp(
      home: ListScreenShortcuts(
        onSearch: () => fired.add('search'),
        onCreate: () => fired.add('create'),
        onRefresh: () => fired.add('refresh'),
        onEscape: escape ? () => fired.add('escape') : null,
        child: Scaffold(body: withSearchField ? const TextField(autofocus: true) : const SizedBox()),
      ),
    ),
  );

  Future<void> ctrl(WidgetTester tester, LogicalKeyboardKey key) async {
    await tester.sendKeyDownEvent(LogicalKeyboardKey.controlLeft);
    await tester.sendKeyEvent(key);
    await tester.sendKeyUpEvent(LogicalKeyboardKey.controlLeft);
  }

  testWidgets('slash and Ctrl+F open search, Ctrl+N creates, F5 and Ctrl+R refresh', (tester) async {
    await pump(tester);

    await tester.sendKeyEvent(LogicalKeyboardKey.slash);
    await ctrl(tester, LogicalKeyboardKey.keyF);
    await ctrl(tester, LogicalKeyboardKey.keyN);
    await tester.sendKeyEvent(LogicalKeyboardKey.f5);
    await ctrl(tester, LogicalKeyboardKey.keyR);

    expect(fired, ['search', 'search', 'create', 'refresh', 'refresh']);
  });

  testWidgets('typing in a text field does not trigger the single-key shortcuts', (tester) async {
    await pump(tester, withSearchField: true);
    await tester.pump();

    await tester.sendKeyEvent(LogicalKeyboardKey.slash);
    await tester.sendKeyEvent(LogicalKeyboardKey.f5);

    expect(fired, isEmpty);
  });

  testWidgets('Escape fires only when a handler is given', (tester) async {
    await pump(tester);
    await tester.sendKeyEvent(LogicalKeyboardKey.escape);
    expect(fired, isEmpty);

    await pump(tester, escape: true);
    await tester.sendKeyEvent(LogicalKeyboardKey.escape);
    expect(fired, ['escape']);
  });
}
