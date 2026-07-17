import 'package:acits_flutter/export.dart';
import 'package:flutter/material.dart';

class DrugListItem extends StatelessWidget {
  const DrugListItem({required this.drug, super.key});

  final Drug drug;

  static Widget builder(Drug drug) => DrugListItem(drug: drug);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text.rich(
        TextSpan(
          children: [
            TextSpan(text: drug.name, style: Theme.of(context).textTheme.titleMedium),
            TextSpan(text: ', ', style: Theme.of(context).textTheme.titleMedium),
            TextSpan(
              text: drug.formOfDrugName,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: context.appColors.textSecondary),
            ),
          ],
        ),
      ),
    );
  }
}
