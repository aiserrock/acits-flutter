import 'package:base/base.dart';
import 'package:equatable/equatable.dart';

import 'package:{{name.snakeCase()}}/domain/domain.dart';

/// State for the {{screen.pascalCase()}} screen. Holds the list load state as a
/// [DataState] over domain entities (never DTOs).
class {{screen.pascalCase()}}State extends Equatable {
  const {{screen.pascalCase()}}State({this.data = const DataState.loading()});

  final DataState<List<{{name.pascalCase()}}>> data;

  {{screen.pascalCase()}}State copyWith({DataState<List<{{name.pascalCase()}}>>? data}) =>
      {{screen.pascalCase()}}State(data: data ?? this.data);

  @override
  List<Object?> get props => [data];
}
