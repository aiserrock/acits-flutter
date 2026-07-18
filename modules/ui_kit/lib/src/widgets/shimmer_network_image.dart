import 'package:flutter/material.dart';

import 'skeleton.dart';

/// Сетевая картинка с shimmer-плейсхолдером на время загрузки.
///
/// Пока байты грузятся — показывает [Skeleton] (shimmer), при ошибке/пустом URL —
/// [fallback] (по умолчанию — нейтральный серый бокс). Заменяет «голый»
/// `Image.network`/`NetworkImage`, которые оставляли пустое место до прихода
/// картинки. Заглушку-ассет приложение передаёт через [fallback], чтобы ui_kit
/// не тянул ассеты конкретного приложения.
class ShimmerNetworkImage extends StatelessWidget {
  const ShimmerNetworkImage({
    required this.url,
    this.fit = BoxFit.cover,
    this.width,
    this.height,
    this.radius = 0.0,
    this.cacheWidth,
    this.fallback,
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

  /// Заглушка при пустом URL / ошибке загрузки. Если не задана — серый бокс.
  final Widget? fallback;

  @override
  Widget build(BuildContext context) {
    final borderRadius = BorderRadius.circular(radius);
    if (url == null || url!.isEmpty) {
      return _wrap(borderRadius, _fallback(context));
    }
    return ClipRRect(
      borderRadius: borderRadius,
      child: Image.network(
        url!,
        fit: fit,
        width: width,
        height: height,
        cacheWidth: cacheWidth,
        loadingBuilder: (context, child, progress) {
          if (progress == null) return child; // загрузка завершена
          // Skeleton требует child или height. При height==null (картинка тянется
          // по родителю через fit) отдаём растягивающийся child, иначе ассерт падает.
          return Skeleton(
            width: width,
            height: height,
            radius: radius,
            child: height == null ? const SizedBox.expand() : null,
          );
        },
        errorBuilder: (context, _, _) => _fallback(context),
      ),
    );
  }

  Widget _fallback(BuildContext context) {
    return fallback ??
        Container(width: width, height: height, color: Theme.of(context).colorScheme.surfaceContainerHighest);
  }

  Widget _wrap(BorderRadius borderRadius, Widget child) {
    return ClipRRect(borderRadius: borderRadius, child: child);
  }
}
