import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:{{name.snakeCase()}}/domain/domain.dart';
import 'package:{{name.snakeCase()}}/presentation/{{screen.snakeCase()}}/{{screen.snakeCase()}}.dart';

/// Entry point of the {{screen.pascalCase()}} screen. Raises the cubit
/// (repository) and hands the router contract to the view. Dependencies come
/// from the root (DI).
class {{screen.pascalCase()}}Page extends StatelessWidget {
  const {{screen.pascalCase()}}Page({required this.repository, required this.router, super.key});

  final {{name.pascalCase()}}Repository repository;
  final {{name.pascalCase()}}RouterService router;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => {{screen.pascalCase()}}Cubit(repository),
      child: {{screen.pascalCase()}}View(router: router),
    );
  }
}
