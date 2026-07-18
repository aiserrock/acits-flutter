import 'package:core/domain.dart' show Shelter;
import 'package:ui_kit/ui_kit.dart';
import 'package:flutter/material.dart';

class ShelterListItem extends StatelessWidget {
  const ShelterListItem({required this.shelter, super.key});

  final Shelter shelter;

  static Widget builder(Shelter shelter) => ShelterListItem(shelter: shelter);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text.rich(
        TextSpan(
          children: [
            TextSpan(text: shelter.name, style: Theme.of(context).textTheme.titleMedium),
            TextSpan(text: ', ', style: Theme.of(context).textTheme.titleMedium),
            TextSpan(
              text: shelter.id.toString(),
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: context.appColors.textSecondary),
            ),
          ],
        ),
      ),
    );
  }
}
