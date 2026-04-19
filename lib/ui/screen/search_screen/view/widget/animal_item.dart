import 'package:acits_flutter/export.dart';
import 'package:flutter/material.dart';

class AnimalListItem extends StatelessWidget {
  const AnimalListItem({
    required this.animal,
    super.key,
  });

  final AnimalRead animal;

  static Widget builder(AnimalRead animal) => AnimalListItem(animal: animal);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text.rich(
        TextSpan(
          children: [
            TextSpan(
              text: animal.name ?? '',
              style: StyleRes.subTitle,
            ),
            const TextSpan(
              text: ', ',
              style: StyleRes.subTitle,
            ),
            TextSpan(
              text: animal.id.toString(),
              style: StyleRes.content.copyWith(color: ColorRes.textSecondary),
            ),
          ],
        ),
      ),
    );
  }
}
