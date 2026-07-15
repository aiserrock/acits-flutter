import 'package:flutter/material.dart';

import 'package:acits_flutter/export.dart';
import 'package:acits_flutter/domain/prescription_model.dart';

/// Виджет карточки назначения животного в детальном представлении
class AnimalPrescriptionCard extends StatefulWidget {
  const AnimalPrescriptionCard({required this.prescription, super.key});

  final PrescriptionModel prescription;

  @override
  State<AnimalPrescriptionCard> createState() => _AnimalPrescriptionCardState();
}

class _AnimalPrescriptionCardState extends State<AnimalPrescriptionCard> {
  final _formatter = DateFormat('dd.MM.yyyy');

  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainerLow,
        borderRadius: const BorderRadius.all(Radius.circular(8.0)),
      ),
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (widget.prescription.executions.isNotEmpty)
            Text(
              _formatter.format(widget.prescription.executions.first.executeAt),
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          const SizedBox(height: 4.0),
          Text(
            widget.prescription.myType.typeString ?? '',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 4.0),
          Row(
            children: [
              Expanded(
                child: Text(
                  widget.prescription.createdBy ?? '',
                  style: Theme.of(
                    context,
                  ).textTheme.bodyMedium?.copyWith(color: Theme.of(context).colorScheme.onSurface),
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              _buildExpandButton(),
            ],
          ),
          if (_isExpanded) ...[
            const Divider(),
            Text(LocaleKeys.animalPrescriptions.tr(), style: Theme.of(context).textTheme.bodySmall),
            const SizedBox(height: 4.0),
            ...widget.prescription.drugs.map<Widget>(
              (drug) => Text.rich(
                TextSpan(
                  children: [
                    TextSpan(text: drug.drugName, style: Theme.of(context).textTheme.bodyLarge),
                    TextSpan(text: ', ', style: Theme.of(context).textTheme.bodyLarge),
                    TextSpan(
                      text: drug.drugDosage.toString(),
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    if (drug.formOfDrug != null)
                      TextSpan(text: drug.formOfDrug, style: Theme.of(context).textTheme.bodyLarge),
                  ],
                ),
                maxLines: 3,
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildExpandButton() {
    return InkWell(
      onTap: () => setState(() => _isExpanded = !_isExpanded),
      child: Icon(
        _isExpanded ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
        color: Theme.of(context).colorScheme.primary,
      ),
    );
  }
}
