import 'package:flutter/material.dart';

// @immutable
class VisibleItem extends StatelessWidget {
  const VisibleItem({
    required this.isVisible,
    required this.child,
    Key? key,
  }) : super(key: key);

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
