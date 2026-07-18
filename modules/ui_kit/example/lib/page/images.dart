import 'package:flutter/material.dart';
import 'package:ui_kit/ui_kit.dart';

/// Растровые и иллюстративные ассеты: `image/` (PNG), `gallery/` (PNG-аватары),
/// `onboarding/` (SVG), `common/` (SVG). Все перебираются через `.values`.
class ImagesPage extends StatelessWidget {
  const ImagesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Images')),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          _Section('Assets.image — PNG (${Assets.image.values.length})'),
          Wrap(
            spacing: 12.0,
            runSpacing: 12.0,
            children: [
              for (final img in Assets.image.values)
                _Tile(
                  label: img.path.split('/').last,
                  child: img.image(height: 72.0, fit: BoxFit.contain),
                ),
            ],
          ),
          const Divider(height: 40.0),
          _Section('Assets.gallery — PNG (${Assets.gallery.values.length})'),
          Wrap(
            spacing: 12.0,
            runSpacing: 12.0,
            children: [
              for (final img in Assets.gallery.values)
                _Tile(
                  label: img.path.split('/').last,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(40.0),
                    child: img.image(height: 64.0, width: 64.0, fit: BoxFit.cover),
                  ),
                ),
            ],
          ),
          const Divider(height: 40.0),
          _Section('Assets.onboarding — SVG (${Assets.onboarding.values.length})'),
          Wrap(
            spacing: 12.0,
            runSpacing: 12.0,
            children: [
              for (final svg in Assets.onboarding.values)
                _Tile(label: svg.path.split('/').last, child: svg.svg(height: 96.0)),
            ],
          ),
          const Divider(height: 40.0),
          _Section('Assets.common — SVG (${Assets.common.values.length})'),
          Wrap(
            spacing: 12.0,
            runSpacing: 12.0,
            children: [
              for (final svg in Assets.common.values)
                _Tile(label: svg.path.split('/').last, child: svg.svg(height: 96.0)),
            ],
          ),
        ],
      ),
    );
  }
}

class _Section extends StatelessWidget {
  const _Section(this.title);

  final String title;

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.only(bottom: 12.0),
    child: Text(title, style: Theme.of(context).textTheme.titleMedium),
  );
}

class _Tile extends StatelessWidget {
  const _Tile({required this.label, required this.child});

  final String label;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 120.0,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(height: 100.0, child: Center(child: child)),
          const SizedBox(height: 4.0),
          Text(
            label,
            style: Theme.of(context).textTheme.labelSmall,
            textAlign: TextAlign.center,
            maxLines: 2,
          ),
        ],
      ),
    );
  }
}
