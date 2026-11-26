import 'package:ui_kit/ui_kit.dart' as ui_kit;
import 'package:flutter/material.dart';

/// App-обёртка над [ui_kit.ShimmerNetworkImage]: подставляет фирменную заглушку
/// `animalStub` из дизайн-системы (package-scoped [ui_kit.Assets]). Тонкий
/// адаптер — вся логика загрузки/shimmer живёт в ui_kit.
class ShimmerNetworkImage extends StatelessWidget {
  const ShimmerNetworkImage({
    required this.url,
    this.fit = BoxFit.cover,
    this.width,
    this.height,
    this.radius = 0.0,
    this.cacheWidth,
    super.key,
  });

  final String? url;
  final BoxFit fit;
  final double? width;
  final double? height;

  /// Скругление углов плейсхолдера/картинки (для круглых аватаров задать большой).
  final double radius;

  /// Ограничение ширины декодирования (экономия памяти для превью).
  final int? cacheWidth;

  @override
  Widget build(BuildContext context) {
    return ui_kit.ShimmerNetworkImage(
      url: url,
      fit: fit,
      width: width,
      height: height,
      radius: radius,
      cacheWidth: cacheWidth,
      fallback: ui_kit.Assets.image.animalStub.image(fit: fit, width: width, height: height),
    );
  }
}
