import 'package:acits_flutter/export.dart';
import 'package:acits_flutter/ui/widget/button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// BS выбора дозировки лекарства
class BsDosage extends StatefulWidget {
  const BsDosage({super.key, required this.drug});

  final ShelterDrug drug;

  @override
  State<BsDosage> createState() => _BsDosageState();
}

class _BsDosageState extends State<BsDosage> {
  /// Контроллер ввода дозировки. Владеет и утилизирует его сам State.
  final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final drug = widget.drug;
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
                controller: _controller,
                autofocus: true,
                decoration: const InputDecoration(labelText: 'Dosage*'),
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                onEditingComplete: () => _onSubmit(context),
              ),
              const SizedBox(height: 24.0),
              PrimaryButton(
                text: LocaleKeys.commonAccept.tr(),
                onPressed: () => _onSubmit(context),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Парсит введённую дозировку и возвращает её через [Navigator.pop].
  void _onSubmit(BuildContext context) {
    final parsed = double.tryParse(_controller.text);
    if (parsed == null) return;
    Navigator.of(context).pop(parsed);
  }
}
