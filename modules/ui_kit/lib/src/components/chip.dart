import 'package:flutter/material.dart';

/// Токен-ориентированный чип-фильтр. Выбранное состояние красится из
/// `colorScheme.primary`, невыбранное — из `surfaceContainerLow`.
class UiChip extends StatelessWidget {
  const UiChip({required this.label, this.selected = false, this.onSelected, super.key});

  final String label;
  final bool selected;
  final ValueChanged<bool>? onSelected;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return FilterChip(
      label: Text(label),
      selected: selected,
      onSelected: onSelected,
      showCheckmark: false,
      backgroundColor: scheme.surfaceContainerLow,
      selectedColor: scheme.primary,
      labelStyle: TextStyle(color: selected ? scheme.onPrimary : scheme.onSurface),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
      side: BorderSide.none,
    );
  }
}
