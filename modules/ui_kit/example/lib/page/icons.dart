import 'package:flutter/material.dart';
import 'package:ui_kit/ui_kit.dart';

/// Иконки дизайн-системы: (1) шрифт icomoon [IconRes], (2) package-scoped SVG
/// [Assets.icon]. SVG перебираются через сгенерированный `Assets.icon.values`,
/// поэтому новые файлы в `assets/icon/` появляются здесь автоматически после
/// регенерации.
class IconsPage extends StatelessWidget {
  const IconsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme.primary;

    // icomoon-глифы: у IconRes нет `.values`, перечисляем явно.
    final fontIcons = <(String, IconData)>[
      ('animalFace', IconRes.animalFace),
      ('applicant', IconRes.applicant),
      ('curator', IconRes.curator),
      ('prescription', IconRes.prescription),
      ('calendar', IconRes.calendar),
      ('close', IconRes.close),
      ('comment', IconRes.comment),
      ('drugs', IconRes.drugs),
      ('paw', IconRes.paw),
      ('today', IconRes.today),
      ('visible', IconRes.visible),
      ('visibleOff', IconRes.visibleOff),
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('Icons')),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          Text('IconRes — icomoon (font)', style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: 12.0),
          Wrap(
            spacing: 12.0,
            runSpacing: 12.0,
            children: [
              for (final (name, icon) in fontIcons)
                _Tile(
                  label: name,
                  child: Icon(icon, size: 32.0, color: color),
                ),
            ],
          ),
          const Divider(height: 40.0),
          Text(
            'Assets.icon — SVG (${Assets.icon.values.length})',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 12.0),
          Wrap(
            spacing: 12.0,
            runSpacing: 12.0,
            children: [
              for (final svg in Assets.icon.values)
                _Tile(label: svg.path.split('/').last, child: svg.svg(width: 32.0, height: 32.0)),
            ],
          ),
        ],
      ),
    );
  }
}

class _Tile extends StatelessWidget {
  const _Tile({required this.label, required this.child});

  final String label;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 96.0,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(height: 40.0, child: Center(child: child)),
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
