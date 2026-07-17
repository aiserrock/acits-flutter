import 'package:acits_core/acits_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/{{entity.snakeCase()}}.dart';
import '../bloc/{{name.snakeCase()}}_cubit.dart';
import '../bloc/{{name.snakeCase()}}_state.dart';
import '../widgets/{{name.snakeCase()}}_body.dart';

/// {{name.pascalCase()}} screen. The cubit is raised by [{{name.pascalCase()}}Page].
class {{name.pascalCase()}}View extends StatelessWidget {
  const {{name.pascalCase()}}View({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('{{name.titleCase()}}')),
      body: BlocBuilder<{{name.pascalCase()}}Cubit, {{name.pascalCase()}}State>(
        buildWhen: (a, b) => a.data != b.data,
        builder: (context, state) {
          return DataStateBuilder<{{entity.pascalCase()}}>(
            state: state.data,
            loader: (_) => const Center(child: CircularProgressIndicator()),
            errorBuilder: (_, __) => const Center(child: Text('Error')),
            builder: (context, item) => {{name.pascalCase()}}Body(item: item),
          );
        },
      ),
    );
  }
}
