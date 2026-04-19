import 'package:acits_flutter/export.dart';
import 'package:flutter/material.dart';

class ShelterListItem extends StatelessWidget {
  const ShelterListItem({
    required this.shelter,
    super.key,
  });

  final ShelterShortSerializers shelter;

  static Widget builder(ShelterShortSerializers shelter) => ShelterListItem(shelter: shelter);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text.rich(
        TextSpan(
          children: [
            TextSpan(
              text: shelter.name ?? '',
              style: StyleRes.subTitle,
            ),
            const TextSpan(
              text: ', ',
              style: StyleRes.subTitle,
            ),
            TextSpan(
              text: shelter.id.toString(),
              style: StyleRes.content.copyWith(color: ColorRes.textSecondary),
            ),
          ],
        ),
      ),
    );
  }
}
