import 'package:util/util.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:personal/personal.dart' show PersonalService, UserProfile;

import 'package:di/di.dart';
import 'package:app_services/app_services.dart';

/// Загружает данные пользователя для бокового меню [PersonalDrawerWidget].
class PersonalDrawerCubit extends Cubit<DataState<UserProfile>> {
  PersonalDrawerCubit() : _personalService = getIt<PersonalService>(), super(const DataLoading()) {
    _load();
  }

  final PersonalService _personalService;

  Future<void> _load() async {
    Log.debug('PersonalDrawerCubit._load: fetching personal');
    safeEmit(const DataLoading());
    try {
      final user = await _personalService.fetchPersonal();
      Log.info('PersonalDrawerCubit._load ok');
      safeEmit(DataContent(user));
    } catch (e, s) {
      Log.error('PersonalDrawerCubit._load failed', e, s);
      safeEmit(DataError(e));
    }
  }
}
