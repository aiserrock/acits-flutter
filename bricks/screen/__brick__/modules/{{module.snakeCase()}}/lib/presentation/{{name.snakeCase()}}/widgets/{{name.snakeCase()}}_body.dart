import 'package:flutter/material.dart';

import 'package:{{module.snakeCase()}}/domain/domain.dart';

/// Body of the {{name.pascalCase()}} screen. Presentational only — renders the
/// loaded [{{entity.pascalCase()}}]; no data access or navigation logic here.
class {{name.pascalCase()}}Body extends StatelessWidget {
  const {{name.pascalCase()}}Body({required this.item, super.key});

  final {{entity.pascalCase()}} item;

  @override
  Widget build(BuildContext context) {
    return Center(child: Text(item.name));
  }
}
