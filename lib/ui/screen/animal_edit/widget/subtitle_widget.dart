import 'package:acits_flutter/res/style.dart';
import 'package:flutter/material.dart';

class SubtitleWidget extends StatelessWidget {
  const SubtitleWidget({
    required this.title,
    this.actions,
    Key? key,
  }) : super(key: key);

  final String title;
  final List<Widget>? actions;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 8.0,
        left: 16.0,
        bottom: 8.0,
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              title,
              style: StyleRes.title.copyWith(fontSize: 22.0),
            ),
          ),
          if (actions != null && actions!.isNotEmpty) const SizedBox(width: 16.0),
          ...?actions,
        ],
      ),
    );
  }
}
