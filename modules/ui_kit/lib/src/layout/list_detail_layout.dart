import 'package:flutter/widgets.dart';
import 'package:material_ui/material_ui.dart' show VerticalDivider;

import 'breakpoints.dart';

/// List and detail side by side on wide windows, the detail alone on narrow ones.
///
/// [detail] is normally the navigator of the section: on a narrow window it shows
/// the list page and pushes the detail page over it; on a wide window its root
/// page is a placeholder ("pick an item") and the detail replaces it in place,
/// while [list] stays mounted on the left and keeps its scroll and search.
class ListDetailLayout extends StatelessWidget {
  const ListDetailLayout({required this.list, required this.detail, this.listWidth = defaultListWidth, super.key});

  /// Width of the list pane: one column of cards.
  static const double defaultListWidth = 400;

  final Widget list;
  final Widget detail;
  final double listWidth;

  /// Whether the window is wide enough for two panes. Screens inside [detail]
  /// use it to decide what their root page shows.
  static bool isSplit(BuildContext context) => MediaQuery.sizeOf(context).width >= Breakpoints.expanded;

  @override
  Widget build(BuildContext context) {
    if (!isSplit(context)) return detail;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SizedBox(width: listWidth, child: list),
        const VerticalDivider(width: 1, thickness: 1),
        Expanded(child: detail),
      ],
    );
  }
}
