import 'package:flutter/material.dart';

import 'package:acits_flutter/export.dart';
import 'package:intl/intl.dart';

/// Виджет карточки назначения животного в детальном представлении
class AnimalPrescriptionCard extends StatefulWidget {
  const AnimalPrescriptionCard({
    required this.prescription,
    Key? key,
  }) : super(key: key);

  final Prescription prescription;

  @override
  _AnimalPrescriptionCardState createState() => _AnimalPrescriptionCardState();
}

class _AnimalPrescriptionCardState extends State<AnimalPrescriptionCard> {
  final _formatter = DateFormat('dd.MM.yyyy');

  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          color: ColorRes.foreground,
          borderRadius: BorderRadius.all(Radius.circular(8.0))),
      margin: const EdgeInsets.symmetric(
        horizontal: 16.0,
        vertical: 8.0,
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: 12.0,
        vertical: 16.0,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            _formatter.format(widget.prescription.executions!.first.executeAt!),
            style: StyleRes.mainContent,
          ),
          const SizedBox(height: 4.0),
          if (widget.prescription.myType != null)
            Text(
              widget.prescription.myType!.typeString ?? '',
              style: StyleRes.title,
            ),
          const SizedBox(height: 4.0),
          Row(
            children: [
              Expanded(
                child: Text(
                  widget.prescription.createdBy ?? '',
                  style: StyleRes.content.copyWith(color: ColorRes.textPrimary),
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              _buildExpandButton(),
            ],
          ),
          if (_isExpanded) ...[
            const Divider(),
            Text(
              StringRes.current.animalPrescriptions,
              style: StyleRes.caption,
            ),
            const SizedBox(height: 4.0),
            if (widget.prescription.drugs != null)
              ...widget.prescription.drugs!.map<Widget>(
                (drug) => Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                          text: (drug.drugName ?? ''),
                          style: StyleRes.mainContent),
                      const TextSpan(text: (', '), style: StyleRes.mainContent),
                      if (drug.drugDosage != null)
                        TextSpan(
                            text: (drug.drugDosage.toString()),
                            style: StyleRes.mainContent),
                      if (drug.formOfDrug != null)
                        TextSpan(
                            text: (drug.formOfDrug),
                            style: StyleRes.mainContent),
                    ],
                  ),
                  maxLines: 3,
                ),
              ),
          ]
        ],
      ),
    );
  }

  Widget _buildExpandButton() {
    return InkWell(
      onTap: () => setState(() => _isExpanded = !_isExpanded),
      child: Icon(
        _isExpanded ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
        color: ColorRes.accent,
      ),
    );
  }
}
