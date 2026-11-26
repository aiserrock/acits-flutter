import 'package:flutter/material.dart';
import 'package:ui_kit/ui_kit.dart';

/// Лоадеры и плейсхолдеры: [Skeleton], [ScreenLoader], [LoaderHolderWidget],
/// [ShimmerNetworkImage].
class LoadersPage extends StatelessWidget {
  const LoadersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Loaders')),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          _label(context, 'Skeleton'),
          const Skeleton(height: 20.0, width: 120.0),
          const SizedBox(height: 8.0),
          const Skeleton(height: 20.0),
          const SizedBox(height: 8.0),
          const Skeleton(height: 64.0, width: 64.0, radius: 32.0),
          const SizedBox(height: 24.0),
          _label(context, 'ShimmerNetworkImage'),
          Row(
            children: [
              const ShimmerNetworkImage(url: 'https://picsum.photos/200', width: 96.0, height: 96.0, radius: 8.0),
              const SizedBox(width: 16.0),
              // Пустой URL → fallback (серый бокс по умолчанию).
              const ShimmerNetworkImage(url: '', width: 96.0, height: 96.0, radius: 8.0),
            ],
          ),
          const SizedBox(height: 24.0),
          _label(context, 'LoaderHolderWidget'),
          const SizedBox(height: 140.0, child: LoaderHolderWidget()),
          const SizedBox(height: 24.0),
          _label(context, 'ScreenLoader (skeleton-карточки)'),
          const SizedBox(height: 320.0, child: ScreenLoader()),
        ],
      ),
    );
  }

  Widget _label(BuildContext context, String text) => Padding(
    padding: const EdgeInsets.only(bottom: 8.0),
    child: Text(text, style: Theme.of(context).textTheme.titleSmall),
  );
}
