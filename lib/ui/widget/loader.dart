import 'dart:math';

import 'package:acits_flutter/res/lottie.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

const _sizePart = .75;

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({
    this.assetPath,
    Key? key,
  }) : super(key: key);

  final String? assetPath;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (_, cons) {
      final size = min(cons.maxHeight, cons.maxWidth) * _sizePart;
      return Center(
        child: Lottie.asset(
          assetPath ?? LottieRes.loading,
          height: size,
          width: size,
        ),
      );
    });
  }
}
