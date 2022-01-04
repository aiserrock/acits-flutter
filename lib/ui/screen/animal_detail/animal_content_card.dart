import 'package:acits_flutter/export.dart';
import 'package:flutter/material.dart';

class AnimalContentCard extends StatelessWidget {
  const AnimalContentCard(
    this.data, {
    this.valueStyle,
    Key? key,
  }) : super(key: key);

  final List<CardData> data;

  final TextStyle? valueStyle;

  @override
  Widget build(BuildContext context) {
    final rows = data
        .map<Widget>(
          (item) => Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  Text(
                    item.firstCaption ?? '',
                    style: StyleRes.content,
                  ),
                  const Spacer(),
                  Text(
                    item.secondCaption ?? '',
                    style: StyleRes.content,
                  ),
                ],
              ),
              const SizedBox(height: 4.0),
              Row(
                children: [
                  Text(
                    item.firstValue ?? '',
                    style: valueStyle ?? StyleRes.mainContent,
                  ),
                  const Spacer(),
                  Text(
                    item.secondValue ?? '',
                    style: valueStyle ?? StyleRes.mainContent,
                  ),
                ],
              ),
              if (item != data.last) const Divider(),
            ],
          ),
        )
        .toList();
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 16.0,
        horizontal: 8.0,
      ),
      margin: const EdgeInsets.symmetric(
        horizontal: 16.0,
        vertical: 8.0,
      ),
      decoration: BoxDecoration(
          color: ColorRes.foreground, borderRadius: BorderRadius.circular(8.0)),
      child: Column(children: rows),
    );
  }
}

class CardData {
  CardData({
    this.firstCaption,
    this.secondCaption,
    this.firstValue,
    this.secondValue,
  });

  final String? firstCaption;
  final String? secondCaption;
  final String? firstValue;
  final String? secondValue;
}
