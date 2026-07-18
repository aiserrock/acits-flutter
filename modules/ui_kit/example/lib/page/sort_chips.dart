import 'package:flutter/material.dart';
import 'package:ui_kit/ui_kit.dart';

/// [SortChipsBar] — горизонтальная лента взаимоисключающих пресетов сортировки.
///
/// `labelKey` резолвится через easy_localization `.tr()`, поэтому здесь заданы
/// ключи переводов (`sort*`), а не готовый текст — их значения лежат в
/// `assets/translations/`.
class SortChipsPage extends StatefulWidget {
  const SortChipsPage({super.key});

  @override
  State<SortChipsPage> createState() => _SortChipsPageState();
}

class _SortChipsPageState extends State<SortChipsPage> {
  static const _presets = <SortPreset>[
    SortPreset(id: 'name', labelKey: 'sortByName', ordering: 'name'),
    SortPreset(id: 'name_desc', labelKey: 'sortByNameDesc', ordering: '-name'),
    SortPreset(id: 'new', labelKey: 'sortNewest', ordering: '-created'),
    SortPreset(id: 'old', labelKey: 'sortOldest', ordering: 'created'),
    SortPreset(id: 'age', labelKey: 'sortByAge', ordering: 'age'),
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
            labelKey: 'commonSort',
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
