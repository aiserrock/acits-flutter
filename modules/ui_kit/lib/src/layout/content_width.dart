import 'package:flutter/widgets.dart';

/// Keeps content readable on wide windows: centred and no wider than [maxWidth].
/// On narrow windows it is a pass-through, so phone layouts are unchanged.
class ContentWidth extends StatelessWidget {
  const ContentWidth({required this.child, this.maxWidth = form, this.alignment = Alignment.topCenter, super.key});

  /// A single-column form: sign-in, registration, edit screens.
  static const double form = 560;

  /// Long-form content with wider rows: lists, detail screens.
  static const double reading = 840;

  final Widget child;
  final double maxWidth;
  final AlignmentGeometry alignment;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: alignment,
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: maxWidth),
        child: child,
      ),
    );
  }
}
