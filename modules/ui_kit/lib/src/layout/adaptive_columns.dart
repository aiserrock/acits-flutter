import 'package:flutter/widgets.dart';

/// How many columns of cards fit a content area.
abstract final class AdaptiveColumns {
  /// Narrowest width at which a card still reads well.
  static const double minColumnWidth = 360;

  /// More columns than this make rows too long to scan.
  static const int maxColumns = 3;

  /// Columns for a content area of [width]: one on phones, up to [maxColumns] on wide windows.
  static int forWidth(double width) => (width / minColumnWidth).floor().clamp(1, maxColumns);

  /// Rows needed to show [itemCount] cards in [columns] columns.
  static int rowCount(int itemCount, int columns) => (itemCount / columns).ceil();
}

/// One row of a card list laid out in [columns] equal columns.
///
/// Cards keep their own height, so a row is as tall as its tallest card. A last
/// row with fewer cards keeps the column width of the rows above. With one
/// column the card is returned as is, so a phone layout is unchanged.
class AdaptiveCardRow extends StatelessWidget {
  const AdaptiveCardRow({required this.columns, required this.children, this.spacing = 16, super.key})
    : assert(columns > 0);

  final int columns;
  final List<Widget> children;
  final double spacing;

  @override
  Widget build(BuildContext context) {
    assert(children.isNotEmpty && children.length <= columns, 'a row holds between 1 and $columns cards');
    if (columns == 1) return children.single;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (var i = 0; i < columns; i++) ...[
          if (i > 0) SizedBox(width: spacing),
          Expanded(child: i < children.length ? children[i] : const SizedBox.shrink()),
        ],
      ],
    );
  }
}
