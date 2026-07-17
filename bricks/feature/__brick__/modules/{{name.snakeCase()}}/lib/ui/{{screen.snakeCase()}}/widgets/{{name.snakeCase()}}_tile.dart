import 'package:flutter/material.dart';

import '../../../domain/{{name.snakeCase()}}.dart';

/// List tile for a [{{name.pascalCase()}}] entity. Presentational only — no data
/// access, no navigation logic (the tap callback is supplied by the view).
class {{name.pascalCase()}}Tile extends StatelessWidget {
  const {{name.pascalCase()}}Tile({required this.item, required this.onTap, super.key});

  final {{name.pascalCase()}} item;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(title: Text(item.name), onTap: onTap);
  }
}
