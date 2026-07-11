import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import 'package:acits_flutter/res/lottie.dart';

/// Полноэкранная заставка «Применение…» на тёмном фоне с Lottie-лоадером.
///
/// Показывается при смене окружения перед рестартом дерева, чтобы юзер видел,
/// что настройки применяются (по мотивам a large production app «Restarting app…»,
/// адаптировано с тематическим Lottie приюта). Кладётся в Stack внутри
/// [RestartWidget], поэтому не требует внешнего Overlay/Navigator-контекста.
class ApplyingOverlay extends StatelessWidget {
  const ApplyingOverlay({super.key});

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
