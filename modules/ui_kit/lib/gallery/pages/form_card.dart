import 'package:flutter/material.dart';
import 'package:ui_kit/ui_kit.dart';

/// [FormEditCard] — контейнер полей редактирования из списка [EditCardData]
/// (текстовые поля, обязательные, только цифры, тап-строка с content).
class FormCardPage extends StatelessWidget {
  const FormCardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('FormEditCard')),
      body: ListView(
        children: [
          const SizedBox(height: 8.0),
          FormEditCard([
            EditCardData(label: 'Кличка', initValue: 'Барсик'),
            EditCardData(label: 'Возраст (лет)', digitsOnly: true, initValue: '3'),
            EditCardData(label: 'Вес, кг', decimalOnly: true, initValue: '4.2'),
            EditCardData(label: 'Заблокировано', enabled: false, initValue: 'Только чтение'),
          ]),
          FormEditCard([
            EditCardData(
              label: 'Тип животного',
              onPressed: () {},
              content: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Кошка', style: Theme.of(context).textTheme.bodyLarge),
                  const Icon(Icons.chevron_right),
                ],
              ),
            ),
          ]),
        ],
      ),
    );
  }
}
