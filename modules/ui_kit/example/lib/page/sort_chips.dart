import 'package:flutter/material.dart';
import 'package:ui_kit/ui_kit.dart';

/// [SortChipsBar] — горизонтальная лента взаимоисключающих пресетов сортировки.
///
/// NB: подписи резолвятся через easy_localization `.tr()`. Без бандла переводов
/// `.tr()` возвращает сам ключ, поэтому здесь ключи заданы читаемым текстом.
class SortChipsPage extends StatefulWidget {
  const SortChipsPage({super.key});

  @override
  State<SortChipsPage> createState() => _SortChipsPageState();
}

class _SortChipsPageState extends State<SortChipsPage> {
  static const _presets = <SortPreset>[
    SortPreset(id: 'name', labelKey: 'По имени', ordering: 'name'),
    SortPreset(id: 'name_desc', labelKey: 'По имени ↓', ordering: '-name'),
    SortPreset(id: 'new', labelKey: 'Сначала новые', ordering: '-created'),
    SortPreset(id: 'old', labelKey: 'Сначала старые', ordering: 'created'),
    SortPreset(id: 'age', labelKey: 'По возрасту', ordering: 'age'),
  ];

  String _activeId = 'name';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('SortChipsBar')),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 16.0),
          SortChipsBar(
            presets: _presets,
            activeId: _activeId,
            labelKey: 'Сортировка',
            onSelected: (preset) => setState(() => _activeId = preset.id),
          ),
          const SizedBox(height: 24.0),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              'Активный ordering: ${_presets.firstWhere((p) => p.id == _activeId).ordering}',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
        ],
      ),
    );
  }
}
