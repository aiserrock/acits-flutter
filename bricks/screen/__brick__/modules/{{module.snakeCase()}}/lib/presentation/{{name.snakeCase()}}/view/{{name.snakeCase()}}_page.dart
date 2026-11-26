import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:{{module.snakeCase()}}/domain/domain.dart';
import 'package:{{module.snakeCase()}}/presentation/{{name.snakeCase()}}/{{name.snakeCase()}}.dart';

/// Entry point of the {{name.pascalCase()}} screen. Raises the cubit for a given
/// [id]; dependencies come from the root (DI). Identity comes from the URL, not
/// from a passed object.
class {{name.pascalCase()}}Page extends StatelessWidget {
  const {{name.pascalCase()}}Page({required this.repository, required this.id, super.key});

  final {{module.pascalCase()}}Repository repository;
  final int id;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => {{name.pascalCase()}}Cubit(repository, id),
      child: const {{name.pascalCase()}}View(),
    );
  }
}
