import 'package:base/base.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:{{module.snakeCase()}}/domain/domain.dart';
import 'package:{{module.snakeCase()}}/presentation/{{name.snakeCase()}}/{{name.snakeCase()}}.dart';

/// Cubit for the {{name.pascalCase()}} screen. Loads a single {{entity.pascalCase()}}
/// by id from the module repository; data arrives as a [Result] (no DTOs).
class {{name.pascalCase()}}Cubit extends Cubit<{{name.pascalCase()}}State> {
  {{name.pascalCase()}}Cubit(this._repository, this._id) : super(const {{name.pascalCase()}}State()) {
    load();
  }

  final {{module.pascalCase()}}Repository _repository;
  final int _id;

  void _safeEmit({{name.pascalCase()}}State state) {
    if (isClosed) return;
    emit(state);
  }

  Future<void> load() async {
    _safeEmit(state.copyWith(data: const DataState.loading()));
    final result = await _repository.getById(_id);
    result.fold(
      (failure) => _safeEmit(state.copyWith(data: DataState.error(failure))),
      (item) => _safeEmit(state.copyWith(data: DataState.content(item))),
    );
  }
}
