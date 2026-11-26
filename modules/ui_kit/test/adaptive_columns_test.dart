import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ui_kit/ui_kit.dart';

void main() {
  test('column count follows the content width and is capped', () {
    expect(AdaptiveColumns.forWidth(320), 1);
    expect(AdaptiveColumns.forWidth(719), 1);
    expect(AdaptiveColumns.forWidth(720), 2);
    expect(AdaptiveColumns.forWidth(1080), 3);
    expect(AdaptiveColumns.forWidth(2400), AdaptiveColumns.maxColumns);
  });

  test('row count covers every item', () {
    expect(AdaptiveColumns.rowCount(0, 3), 0);
    expect(AdaptiveColumns.rowCount(1, 3), 1);
    expect(AdaptiveColumns.rowCount(3, 3), 1);
    expect(AdaptiveColumns.rowCount(4, 3), 2);
    expect(AdaptiveColumns.rowCount(7, 1), 7);
  });

  Widget host(Widget child) => Directionality(
    textDirection: TextDirection.ltr,
    child: Align(
      alignment: Alignment.topLeft,
      child: SizedBox(width: 632, child: child),
    ),
  );

  testWidgets('one column returns the card itself', (tester) async {
    await tester.pumpWidget(host(const AdaptiveCardRow(columns: 1, children: [SizedBox(height: 40, key: Key('a'))])));

    expect(find.byType(Row), findsNothing);
    expect(tester.getSize(find.byKey(const Key('a'))).width, 632);
  });

  testWidgets('cards share the row equally and keep their own height', (tester) async {
    await tester.pumpWidget(
      host(
        const AdaptiveCardRow(
          columns: 2,
          children: [
            SizedBox(height: 40, key: Key('a')),
            SizedBox(height: 90, key: Key('b')),
          ],
        ),
      ),
    );

    expect(tester.getSize(find.byKey(const Key('a'))), const Size(308, 40));
    expect(tester.getSize(find.byKey(const Key('b'))), const Size(308, 90));
    expect(tester.getTopLeft(find.byKey(const Key('b'))).dx, 324);
  });

  testWidgets('an incomplete last row keeps the column width', (tester) async {
    await tester.pumpWidget(host(const AdaptiveCardRow(columns: 2, children: [SizedBox(height: 40, key: Key('a'))])));

    expect(tester.getSize(find.byKey(const Key('a'))).width, 308);
  });
}
