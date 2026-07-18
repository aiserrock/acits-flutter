import 'dart:math';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

/// Дефолтная lottie-анимация загрузки. Путь резолвится из бандла приложения
/// (`rootBundle`), поэтому ui_kit не обязан владеть самим ассетом.
const _kDefaultLoadingAsset = 'assets/lottie/loading.json';

const _sizePart = .75;

class LoaderHolderWidget extends StatelessWidget {
  const LoaderHolderWidget({this.assetPath, super.key});

  final String? assetPath;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (_, cons) {
        final size = min(cons.maxHeight, cons.maxWidth) * _sizePart;
        return Center(
          child: Lottie.asset(assetPath ?? _kDefaultLoadingAsset, height: size, width: size),
        );
      },
    );
  }
}
