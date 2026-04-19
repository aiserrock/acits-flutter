import 'package:acits_flutter/export.dart';
import 'package:acits_flutter/ui/widget/button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// BS выбора дозировки лекарства
class BsDosage extends StatelessWidget {
  BsDosage({super.key, required this.drug});

  final ShelterDrug drug;
  final TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.0),
          color: ColorRes.foreground,
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              const SizedBox(height: 8.0),
              Text('${drug.drug?.name}, ${drug.drug?.formOfDrugName}', style: StyleRes.subTitle),
              const SizedBox(height: 16.0),
              TextField(
                controller: controller,
                autofocus: true,
                decoration: const InputDecoration(labelText: 'Dosage*'),
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                onEditingComplete: () => onSubmit(context),
              ),
              const SizedBox(height: 24.0),
              PrimaryButton(text: 'Принять', onPressed: () => onSubmit(context)),
            ],
          ),
        ),
      ),
    );
  }

  void onSubmit(BuildContext context) {
    final parsed = double.tryParse(controller.text);
    if (parsed == null) {
      return;
    } else {}
    Navigator.of(context).pop(parsed);
  }
}
