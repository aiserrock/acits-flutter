import 'package:ui_kit/ui_kit.dart';
import 'package:animals/animals.dart' show AnimalListItem;
import 'package:flutter/material.dart';

/// Плитка животного в поиске. Рендерит доменную сущность [AnimalListItem]
/// (модуль animals) — поиск животных мигрирован на репозиторий.
class AnimalSearchItem extends StatelessWidget {
  const AnimalSearchItem({required this.animal, super.key});

  final AnimalListItem animal;

  static Widget builder(AnimalListItem animal) => AnimalSearchItem(animal: animal);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text.rich(
        TextSpan(
          children: [
            TextSpan(text: animal.name, style: Theme.of(context).textTheme.titleMedium),
            TextSpan(text: ', ', style: Theme.of(context).textTheme.titleMedium),
            TextSpan(
              text: animal.id.toString(),
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: context.appColors.textSecondary),
            ),
          ],
        ),
      ),
    );
  }
}
