import 'package:flutter/material.dart';
import 'package:ui_kit/ui_kit.dart';

/// [UiChip] — фильтр-чип (selected / unselected). Интерактивный: тап меняет
/// состояние выбора.
class ChipPage extends StatefulWidget {
  const ChipPage({super.key});

  @override
  State<ChipPage> createState() => _ChipPageState();
}

class _ChipPageState extends State<ChipPage> {
  final _labels = const ['Все', 'Кошки', 'Собаки', 'Птицы', 'Грызуны'];
  final _selected = <int>{0};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Chip')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Мультивыбор', style: Theme.of(context).textTheme.titleSmall),
            const SizedBox(height: 12.0),
            Wrap(
              spacing: 8.0,
              runSpacing: 8.0,
              children: [
                for (var i = 0; i < _labels.length; i++)
                  UiChip(
                    label: _labels[i],
                    selected: _selected.contains(i),
                    onSelected: (value) =>
                        setState(() => value ? _selected.add(i) : _selected.remove(i)),
                  ),
              ],
            ),
            const SizedBox(height: 24.0),
            Text('Статика', style: Theme.of(context).textTheme.titleSmall),
            const SizedBox(height: 12.0),
            const Wrap(
              spacing: 8.0,
              children: [
                UiChip(label: 'Selected', selected: true),
                UiChip(label: 'Unselected', selected: false),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
