import 'package:acits_flutter/export.dart';
import 'package:flutter/material.dart';

class CuratorListItem extends StatelessWidget {
  const CuratorListItem({required this.curator, super.key});

  final Curator curator;

  static Widget builder(Curator curator) => CuratorListItem(curator: curator);

  @override
  Widget build(BuildContext context) {
    return ListTile(title: Text(curator.fullName ?? ''));
  }
}
