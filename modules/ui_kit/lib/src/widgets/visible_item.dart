import 'package:material_ui/material_ui.dart';

// @immutable
class VisibleItem extends StatelessWidget {
  const VisibleItem({required this.isVisible, required this.child, super.key});

  final bool isVisible;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return AnimatedCrossFade(
      duration: kThemeAnimationDuration,
      crossFadeState: isVisible ? CrossFadeState.showSecond : CrossFadeState.showFirst,
      firstChild: const SizedBox(),
      secondChild: child,
    );
  }
}
