import 'package:acits_core/acits_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:{{name.snakeCase()}}/domain/domain.dart';
import 'package:{{name.snakeCase()}}/presentation/{{screen.snakeCase()}}/{{screen.snakeCase()}}.dart';

/// {{screen.pascalCase()}} screen. The cubit is raised by [{{screen.pascalCase()}}Page].
class {{screen.pascalCase()}}View extends StatelessWidget {
  const {{screen.pascalCase()}}View({required this.router, super.key});

  final {{name.pascalCase()}}RouterService router;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('{{name.pascalCase()}}')),
      body: BlocBuilder<{{screen.pascalCase()}}Cubit, {{screen.pascalCase()}}State>(
        buildWhen: (a, b) => a.data != b.data,
        builder: (context, state) {
          return DataStateBuilder<List<{{name.pascalCase()}}>>(
            state: state.data,
            loader: (_) => const Center(child: CircularProgressIndicator()),
            errorBuilder: (_, __) => const Center(child: Text('Error')),
            builder: (context, items) => ListView.builder(
              itemCount: items.length,
              itemBuilder: (context, i) => {{name.pascalCase()}}Tile(
                item: items[i],
                onTap: () => router.openDetail(items[i].id),
              ),
            ),
          );
        },
      ),
    );
  }
}
