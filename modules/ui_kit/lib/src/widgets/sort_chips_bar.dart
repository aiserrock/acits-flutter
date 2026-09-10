import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import 'sort_preset.dart';

/// Горизонтальная лента чипсов сортировки.
///
/// Слева — лейбл-иконка «⇅ Сортировка», чтобы пользователь считывал ленту как
/// сортировку, а не фильтры. Чипсы взаимоисключающие (radio): активен ровно один
/// ([activeId]). Выбор прокидывается через [onSelected].
///
/// Активный чипс автоскроллится в видимую зону при первой отрисовке — если он
/// оказался за кадром справа, лента подкручивается к нему.
///
/// [labelKey] и [SortPreset.labelKey] резолвятся через easy_localization `.tr()`
/// из загруженного приложением бандла переводов — сам ui_kit переводами не
/// владеет.
class SortChipsBar extends StatefulWidget {
  const SortChipsBar({
    required this.presets,
    required this.activeId,
    required this.onSelected,
    this.labelKey = 'commonSort',
    super.key,
  });

  final List<SortPreset> presets;
  final String activeId;
  final ValueChanged<SortPreset> onSelected;

  /// Ключ локализации подписи-лейбла слева.
  final String labelKey;

  @override
  State<SortChipsBar> createState() => _SortChipsBarState();
}

class _SortChipsBarState extends State<SortChipsBar> {
  final _scrollController = ScrollController();
  final _activeKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _ensureActiveVisible());
  }

  @override
  void didUpdateWidget(covariant SortChipsBar oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.activeId != widget.activeId) {
      WidgetsBinding.instance.addPostFrameCallback((_) => _ensureActiveVisible());
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  /// Подкрутить ленту так, чтобы активный чипс был виден.
  void _ensureActiveVisible() {
    final ctx = _activeKey.currentContext;
    if (ctx == null || !_scrollController.hasClients) return;
    Scrollable.ensureVisible(ctx, alignment: 0.5, duration: const Duration(milliseconds: 250), curve: Curves.easeOut);
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return SizedBox(
      height: 48.0,
      child: ListView(
        controller: _scrollController,
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        children: [
          _buildLabel(context, scheme),
          const SizedBox(width: 8.0),
          for (final preset in widget.presets) ...[_buildChip(context, scheme, preset), const SizedBox(width: 8.0)],
        ],
      ),
    );
  }

  Widget _buildLabel(BuildContext context, ColorScheme scheme) {
    return Row(
      children: [
        Icon(Icons.swap_vert, size: 18.0, color: scheme.onSurfaceVariant),
        const SizedBox(width: 4.0),
        Text(
          widget.labelKey.tr(),
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: scheme.onSurfaceVariant),
        ),
      ],
    );
  }

  Widget _buildChip(BuildContext context, ColorScheme scheme, SortPreset preset) {
    final isActive = preset.id == widget.activeId;
    return Center(
      child: ChoiceChip(
        key: isActive ? _activeKey : null,
        label: Text(preset.labelKey.tr()),
        selected: isActive,
        showCheckmark: false,
        onSelected: (_) {
          if (!isActive) widget.onSelected(preset);
        },
        labelStyle: Theme.of(
          context,
        ).textTheme.bodyMedium?.copyWith(color: isActive ? scheme.onPrimary : scheme.onSurface),
        backgroundColor: scheme.surfaceContainerLow,
        selectedColor: scheme.primary,
        side: BorderSide(color: isActive ? scheme.primary : scheme.outlineVariant),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      ),
    );
  }
}
