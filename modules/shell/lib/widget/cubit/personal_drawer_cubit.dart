import 'package:util/util.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:personal/personal.dart' show PersonalRepository, UserProfile;

import 'package:di/di.dart';
import 'package:app_services/app_services.dart';

/// Загружает данные пользователя для бокового меню [PersonalDrawerWidget].
class PersonalDrawerCubit extends Cubit<DataState<UserProfile>> {
  PersonalDrawerCubit() : _repository = getIt<PersonalRepository>(), super(const DataLoading()) {
    _load();
  }

  final PersonalRepository _repository;

  Future<void> _load() async {
    Log.debug('PersonalDrawerCubit._load: fetching personal');
    safeEmit(const DataLoading());
    final result = await _repository.fetchPersonal();
    result.fold(
      (failure) {
        Log.error('PersonalDrawerCubit._load failed: $failure');
        safeEmit(DataError(failure));
      },
      (user) {
        Log.info('PersonalDrawerCubit._load ok');
        safeEmit(DataContent(user));
      },
    );
  }
}
