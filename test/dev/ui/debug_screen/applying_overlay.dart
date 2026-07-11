import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import 'package:acits_flutter/res/lottie.dart';

/// Полноэкранная заставка «Применение…» на тёмном фоне с Lottie-лоадером.
///
/// Показывается при смене окружения перед рестартом дерева, чтобы юзер видел,
/// что настройки применяются (по мотивам hamkormobile «Restarting app…»,
/// адаптировано с тематическим Lottie приюта).
class ApplyingOverlay extends StatelessWidget {
  const ApplyingOverlay({super.key});

  /// Показывает заставку поверх всего через корневой [Overlay] и возвращает
  /// хендл для скрытия. Живёт до рестарта дерева либо ручного [OverlayEntry.remove].
  static OverlayEntry show(BuildContext context) {
    final entry = OverlayEntry(builder: (_) => const ApplyingOverlay());
    Overlay.of(context, rootOverlay: true).insert(entry);
    return entry;
  }

  @override
  Widget build(BuildContext context) {
    return const ColoredBox(
      color: Colors.black87,
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: 140, width: 140, child: _PawLoader()),
            SizedBox(height: 16),
            Text(
              'Применение…',
              style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }
}

class _PawLoader extends StatelessWidget {
  const _PawLoader();

  @override
  Widget build(BuildContext context) {
    return LottieBuilder.asset(
      LottieRes.pawLoading,
      repeat: true,
      // Если ассет не подгрузился — не ломаем заставку, показываем спиннер.
      errorBuilder: (_, _, _) =>
          const Center(child: CircularProgressIndicator(color: Colors.white)),
    );
  }
}
