import 'package:easy_localization/easy_localization.dart';
import 'package:material_ui/material_ui.dart';

import 'package:prescriptions/domain/domain.dart';

/// Компактная read-only карточка исполнения в списке выбранного дня: время,
/// тип назначения, животное и препараты. Без меню действий — у исполнений в
/// календаре нет статуса «выполнено».
class CalendarExecutionCard extends StatelessWidget {
  const CalendarExecutionCard({required this.execution, super.key});

  final PrescriptionExecutionToday execution;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final prescription = execution.prescription;
    final type = prescription.type == PrescriptionType.unknown ? null : prescription.typeString;
    final animal = _animalLabel(prescription.animal);
    final description = prescription.description?.trim();
    final time = DateFormat.Hm(context.locale.toString()).format(execution.executeAt);

    return Card(
      margin: EdgeInsets.zero,
      color: scheme.surfaceContainerLow,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 12.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: 56.0,
              child: Text(time, style: theme.textTheme.titleMedium?.copyWith(color: scheme.primary)),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (type != null && type.isNotEmpty) Text(type, style: theme.textTheme.titleMedium),
                  if (animal.isNotEmpty)
                    Text(animal, style: theme.textTheme.bodyMedium?.copyWith(color: scheme.onSurface)),
                  for (final drug in prescription.drugs)
                    Text(_drugLabel(drug), style: theme.textTheme.bodyMedium, maxLines: 2),
                  if (description != null && description.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.only(top: 4.0),
                      child: Text(description, style: theme.textTheme.bodySmall, maxLines: 3),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  static String _animalLabel(AnimalShort animal) {
    final name = animal.name?.trim() ?? '';
    return name.isEmpty ? '#${animal.id}' : '$name #${animal.id}';
  }

  static String _drugLabel(PrescriptionDrug drug) {
    final dosage = NumberFormat('#.##').format(drug.drugDosage);
    final form = drug.formOfDrug;
    return [drug.drugName, if (form != null && form.isNotEmpty) '$dosage $form' else dosage].join(', ');
  }
}
