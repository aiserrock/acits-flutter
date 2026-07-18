import 'package:ui_kit/ui_kit.dart' as ui_kit;
import 'package:flutter/material.dart';

/// App-обёртка над [ui_kit.ErrorStubWidget]: подставляет фирменную SVG-заглушку
/// `errorStub` из дизайн-системы (package-scoped [ui_kit.Assets]). Тонкий адаптер.
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
      image: ui_kit.Assets.icon.errorStub.svg(),
    );
  }
}
