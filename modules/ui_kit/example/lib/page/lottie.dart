import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:ui_kit/ui_kit.dart';

/// Lottie-анимации дизайн-системы. Сырые json перебираются через
/// `Assets.lottie.values` (пути `packages/ui_kit/...`), плюс готовые
/// виджеты-обёртки [LoaderHolderWidget] / [SuccessHolderWidget].
class LottiePage extends StatelessWidget {
  const LottiePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Lottie')),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          Text(
            'Assets.lottie (${Assets.lottie.values.length})',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 12.0),
          Wrap(
            spacing: 16.0,
            runSpacing: 16.0,
            children: [
              for (final path in Assets.lottie.values)
                SizedBox(
                  width: 140.0,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(height: 120.0, child: Lottie.asset(path)),
                      const SizedBox(height: 4.0),
                      Text(
                        path.split('/').last,
                        style: Theme.of(context).textTheme.labelSmall,
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
            ],
          ),
          const Divider(height: 40.0),
          Text('Обёртки', style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: 12.0),
          const SizedBox(width: 160.0, height: 160.0, child: LoaderHolderWidget()),
          const SizedBox(height: 16.0),
          // Holder сайзит Lottie как min(maxH, maxW)*0.75 → ограничиваем ширину
          // и даём высоту с запасом, чтобы внутренняя Column не переполнялась.
          const Center(
            child: SizedBox(
              width: 320.0,
              height: 420.0,
              child: SuccessHolderWidget(title: 'Готово', message: 'Операция выполнена успешно'),
            ),
          ),
        ],
      ),
    );
  }
}
