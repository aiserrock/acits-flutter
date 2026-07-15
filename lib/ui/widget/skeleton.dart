import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import 'package:acits_flutter/res/theme.dart';

/// Типовой лоадер
class Skeleton extends StatelessWidget {
  const Skeleton({
    this.isLoading = true,
    super.key,
    this.child,
    this.height,
    this.width = double.infinity,
    this.radius = 8.0,
  }) : assert(child != null || height != null);

  final bool isLoading;
  final Widget? child;
  final double? height;
  final double? width;
  final double? radius;

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      enabled: isLoading,
      baseColor: context.appColors.inactiveIcon.withValues(alpha: .3),
      highlightColor: Theme.of(context).colorScheme.surface,
      child:
          child ??
          Container(
            height: height,
            width: width,
            decoration: BoxDecoration(
              color: context.appColors.textSecondary,
              borderRadius: radius != null ? BorderRadius.all(Radius.circular(radius!)) : null,
            ),
          ),
    );
  }
}
