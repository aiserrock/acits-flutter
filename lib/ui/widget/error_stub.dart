import 'package:ui_kit/ui_kit.dart' as ui_kit;
import 'package:flutter/material.dart';

import 'package:acits_flutter/gen/assets.gen.dart';

/// App-обёртка над [ui_kit.ErrorStubWidget]: подставляет фирменную SVG-заглушку
/// `errorStub` (ui_kit не владеет ассетами приложения). Тонкий адаптер.
class ErrorStubWidget extends StatelessWidget {
  const ErrorStubWidget({required this.onPressed, this.showImage = true, this.height, super.key});

  final double? height;
  final VoidCallback onPressed;
  final bool showImage;

  @override
  Widget build(BuildContext context) {
    return ui_kit.ErrorStubWidget(
      onPressed: onPressed,
      showImage: showImage,
      height: height,
      image: Assets.image.errorStub.svg(),
    );
  }
}
