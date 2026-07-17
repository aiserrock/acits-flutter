import 'package:acits_core/acits_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/{{name.snakeCase()}}_repository.dart';
import '{{screen.snakeCase()}}_state.dart';

/// Cubit for the {{screen.pascalCase()}} screen. Owns the list [DataState]; data
/// comes from [{{name.pascalCase()}}Repository] as a [Result] (no DTOs).
class {{screen.pascalCase()}}Cubit extends Cubit<{{screen.pascalCase()}}State> {
  {{screen.pascalCase()}}Cubit(this._repository) : super(const {{screen.pascalCase()}}State()) {
    load();
  }

  final {{name.pascalCase()}}Repository _repository;

  void _safeEmit({{screen.pascalCase()}}State state) {
    if (isClosed) return;
    emit(state);
  }

  Future<void> load() async {
    _safeEmit(state.copyWith(data: const DataState.loading()));
    final result = await _repository.list();
    result.fold(
      (failure) => _safeEmit(state.copyWith(data: DataState.error(failure))),
      (items) => _safeEmit(state.copyWith(data: DataState.content(items))),
    );
  }
}
