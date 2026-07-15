import 'package:acits_flutter/export.dart';
import 'package:flutter/material.dart';

class AnimalListItem extends StatelessWidget {
  const AnimalListItem({required this.animal, super.key});

  final AnimalRead animal;

  static Widget builder(AnimalRead animal) => AnimalListItem(animal: animal);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text.rich(
        TextSpan(
          children: [
            TextSpan(text: animal.name ?? '', style: Theme.of(context).textTheme.titleMedium),
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
