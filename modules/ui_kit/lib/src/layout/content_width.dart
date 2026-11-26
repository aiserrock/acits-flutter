import 'package:flutter/widgets.dart';

/// Keeps content readable on wide windows: centred and no wider than [maxWidth].
///
/// The child always gets a tight box — the full window on narrow screens, a
/// column of [maxWidth] on wide ones — so a layout written for a phone behaves
/// the same inside it.
class ContentWidth extends StatelessWidget {
  const ContentWidth({required this.child, this.maxWidth = form, this.alignment = Alignment.topCenter, super.key});

  /// A single-column form: sign-in, registration, edit screens.
  static const double form = 560;

  /// Long-form content with wider rows: lists, detail screens.
  static const double reading = 840;

  final Widget child;
  final double maxWidth;

  /// Where the column sits when the window is wider than [maxWidth].
  final AlignmentGeometry alignment;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth < maxWidth ? constraints.maxWidth : maxWidth;
        return Align(
          alignment: alignment,
          child: SizedBox(
            width: width,
            height: constraints.hasBoundedHeight ? constraints.maxHeight : null,
            child: child,
          ),
        );
      },
    );
  }
}
