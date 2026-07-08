import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:acits_flutter/di/di_container.dart';
import 'package:acits_flutter/export.dart';
import 'package:acits_flutter/service/personal/personal_service.dart';

/// Загружает данные пользователя для бокового меню [PersonalDrawerWidget].
class PersonalDrawerCubit extends Cubit<DataState<UserSerializers>> {
  PersonalDrawerCubit() : _personalService = getIt<PersonalService>(), super(const DataLoading()) {
    _load();
  }

  final PersonalService _personalService;

  Future<void> _load() async {
    safeEmit(const DataLoading());
    try {
      final user = await _personalService.fetchPersonal();
      safeEmit(DataContent(user));
    } catch (e) {
      safeEmit(DataError(e));
    }
  }
}
