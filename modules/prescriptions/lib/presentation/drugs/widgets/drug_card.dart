import 'package:localization/localization.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:material_ui/material_ui.dart';

import 'package:prescriptions/domain/domain.dart';

/// Карточка препарата: название, форма выпуска, остаток и инструкция.
///
/// Нулевой остаток подсвечивается цветом ошибки темы. Инструкция по применению
/// сворачивается до двух строк.
class DrugCard extends StatelessWidget {
  const DrugCard({required this.drug, super.key});

  final Drug drug;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final stock = drug.drugResiduesCount;
    final isOutOfStock = stock != null && stock <= 0;
    final instruction = drug.usageInstruction?.trim();

    return Card(
      margin: EdgeInsets.zero,
      color: scheme.surfaceContainerLow,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(drug.name, style: theme.textTheme.titleMedium?.copyWith(color: scheme.onSurface)),
            if (drug.formOfDrugName.isNotEmpty) ...[
              const SizedBox(height: 4.0),
              Text(drug.formOfDrugName, style: theme.textTheme.bodyMedium?.copyWith(color: scheme.onSurfaceVariant)),
            ],
            if (stock != null) ...[
              const SizedBox(height: 4.0),
              Text(
                LocaleKeys.drugsStock.tr(args: ['$stock']),
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: isOutOfStock ? scheme.error : scheme.onSurface,
                  fontWeight: isOutOfStock ? FontWeight.w600 : null,
                ),
              ),
            ],
            if (instruction != null && instruction.isNotEmpty) ...[
              const SizedBox(height: 8.0),
              Text(
                instruction,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: theme.textTheme.bodySmall?.copyWith(color: scheme.onSurfaceVariant),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
