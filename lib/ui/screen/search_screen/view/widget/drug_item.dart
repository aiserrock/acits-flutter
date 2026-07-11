import 'package:acits_flutter/export.dart';
import 'package:flutter/material.dart';

class DrugListItem extends StatelessWidget {
  const DrugListItem({required this.drug, super.key});

  final ShelterDrug drug;

  static Widget builder(ShelterDrug drug) => DrugListItem(drug: drug);

  @override
  Widget build(BuildContext context) {
    final drugForm = drug.drug.formOfDrugName;
    return ListTile(
      title: Text.rich(
        TextSpan(
          children: [
            TextSpan(text: drug.drug.name, style: StyleRes.subTitle),
            if (drugForm != null) const TextSpan(text: ', ', style: StyleRes.subTitle),
            if (drugForm != null)
              TextSpan(
                text: drugForm,
                style: StyleRes.content.copyWith(color: ColorRes.textSecondary),
              ),
          ],
        ),
      ),
    );
  }
}
