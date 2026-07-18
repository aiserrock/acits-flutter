import 'package:util/util.dart';
import 'package:equatable/equatable.dart';

import 'package:{{module.snakeCase()}}/domain/domain.dart';

/// State for the {{name.pascalCase()}} screen. Load state as a [DataState] over a
/// domain entity (never a DTO).
class {{name.pascalCase()}}State extends Equatable {
  const {{name.pascalCase()}}State({this.data = const DataState.loading()});

  final DataState<{{entity.pascalCase()}}> data;

  {{name.pascalCase()}}State copyWith({DataState<{{entity.pascalCase()}}>? data}) =>
      {{name.pascalCase()}}State(data: data ?? this.data);

  @override
  List<Object?> get props => [data];
}
