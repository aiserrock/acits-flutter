import 'dart:ui' show ImageFilter;

import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

/// Ширина «телефонного» холста на web. ≈ логическая ширина крупного смартфона
/// (iPhone 15 Pro Max — 430pt). На широком экране контент центрируется в колонке
/// этой ширины, а не растягивается на всё окно браузера.
const double _phoneCanvasWidth = 430.0;

/// Сила размытия матового фона по бокам.
const double _backdropBlur = 70.0;

/// Ограничивает ширину всего приложения шириной смартфона на web-десктопе.
///
/// Оборачивается в `MaterialApp.builder`, поэтому действует на все экраны и
/// push-роуты разом. На мобильных платформах и на узких окнах (ширина ≤
/// [_phoneCanvasWidth]) — прозрачная обёртка (passthrough): интерфейс занимает
/// весь экран, как и раньше.
///
/// Важно: под рамкой [MediaQuery] переопределяется на урезанную ширину, чтобы
/// вся внутренняя вёрстка (в т.ч. `MediaQuery.sizeOf` и проверки «узкий экран»)
/// считала, что работает на телефоне, а не на широком мониторе.
class PhoneFrame extends StatelessWidget {
  const PhoneFrame({required this.child, super.key});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    // Ограничиваем только web: на native окно и так по размеру устройства.
    if (!kIsWeb) return child;

    final mq = MediaQuery.of(context);
    final screenWidth = mq.size.width;

    // Узкое окно (телефон/сложенный браузер) — ничего не ограничиваем.
    if (screenWidth <= _phoneCanvasWidth) return child;

    // Матовый фон и пятна берут тон из темы: на светлой — светлее, на тёмной —
    // темнее. Базу тянем из surfaceContainerHigh (глубокий фон), акцент — из
    // primary, чтобы рамка гармонировала с текущей темой.
    final scheme = Theme.of(context).colorScheme;
    final matteColor = scheme.surfaceContainerHigh;
    final accent = scheme.primary;

    // Внутри рамки экран «шириной с телефон»: отрезаем правый viewPadding/inset
    // (боковые safe-area десктопу не нужны) и подменяем ширину.
    final framedMedia = mq.copyWith(size: Size(_phoneCanvasWidth, mq.size.height));

    return Stack(
      children: [
        // Фон-«матовое стекло» на всё окно: цветные пятна (акцент приложения)
        // на тёмной базе + сильный блюр поверх них. Именно текстура под
        // BackdropFilter делает блюр видимым — на однородном градиенте эффекта
        // не было бы. Контент приложения не дублируется (его нельзя вставить в
        // дерево дважды), размывается только этот декоративный задник.
        Positioned.fill(
          child: DecoratedBox(
            decoration: BoxDecoration(color: matteColor),
            child: Stack(
              children: [
                // Пятна расставлены по углам/краям — после блюра сливаются в
                // мягкие цветные переливы вокруг «телефона».
                _Blob(alignment: const Alignment(-0.9, -0.8), color: accent, size: 460),
                _Blob(alignment: const Alignment(0.95, -0.6), color: accent.withValues(alpha: 0.5), size: 380),
                _Blob(alignment: const Alignment(-0.8, 0.9), color: accent.withValues(alpha: 0.6), size: 520),
                _Blob(alignment: const Alignment(0.9, 0.95), color: accent.withValues(alpha: 0.35), size: 440),
                // Сильный блюр превращает пятна в матовое стекло.
                Positioned.fill(
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: _backdropBlur, sigmaY: _backdropBlur),
                    child: const ColoredBox(color: Color(0x14000000)),
                  ),
                ),
              ],
            ),
          ),
        ),
        // Чёткий «телефон» по центру, с лёгкой тенью для читаемого края.
        Center(
          child: DecoratedBox(
            decoration: const BoxDecoration(
              boxShadow: [BoxShadow(color: Color(0x33000000), blurRadius: 32.0, spreadRadius: 4.0)],
            ),
            child: SizedBox(
              width: _phoneCanvasWidth,
              child: MediaQuery(data: framedMedia, child: child),
            ),
          ),
        ),
      ],
    );
  }
}

/// Мягкое цветное пятно-градиент — «сырьё» для блюр-фона. Радиальный градиент от
/// цвета к прозрачному, спозиционированный через [alignment].
class _Blob extends StatelessWidget {
  const _Blob({required this.alignment, required this.color, required this.size});

  final Alignment alignment;
  final Color color;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: alignment,
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: RadialGradient(colors: [color, color.withValues(alpha: 0.0)]),
        ),
      ),
    );
  }
}
