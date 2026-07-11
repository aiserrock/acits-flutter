import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:acits_flutter/export.dart';
import 'package:acits_flutter/di/di_container.dart';
import 'package:acits_flutter/service/personal/personal_service.dart';
import 'package:acits_flutter/ui/screen/personal_screen/cubit/personal_state.dart';
import 'package:acits_flutter/util/logger/log.dart';

/// Cubit экрана личного кабинета. Загружает данные пользователя и сохраняет
/// изменённые поля. UI-контроллеры (TextEditingController) живут в виджете.
class PersonalCubit extends Cubit<PersonalState> {
  PersonalCubit()
    : _personalService = getIt<PersonalService>(),
      super(const PersonalState.loading());

  final PersonalService _personalService;

  /// Загрузить данные пользователя. Возвращает загруженного пользователя,
  /// чтобы виджет мог проинициализировать контроллеры полей.
  Future<UserSerializers?> load() async {
    Log.debug('PersonalCubit.load');
    safeEmit(state.copyWith(data: const DataState.loading(), fabVisible: false));
    try {
      final user = await _personalService.fetchPersonal(force: true);
      Log.info('PersonalCubit.load ok: id=${user.id}');
      safeEmit(PersonalState(data: DataState.content(user)));
      return user;
    } catch (e, s) {
      Log.error('PersonalCubit.load failed', e, s);
      safeEmit(state.copyWith(data: DataState.error(e)));
      return null;
    }
  }

  /// Пересчитать видимость кнопки сохранения по текущим значениям полей.
  void onFieldsChanged({
    required String firstName,
    required String lastName,
    required String fathersName,
    required String phoneNumber,
    required String email,
  }) {
    final data = state.data.valueOrNull;
    if (data == null) return;
    final changed =
        data.copyWith(
          firstName: firstName,
          lastName: lastName,
          fathersName: fathersName,
          phoneNumber: phoneNumber,
          email: email,
        ) !=
        data;
    if (changed != state.fabVisible) {
      safeEmit(state.copyWith(fabVisible: changed));
    }
  }

  /// Сохранить изменённые данные пользователя.
  Future<void> submit({
    required String firstName,
    required String lastName,
    required String fathersName,
    required String phoneNumber,
    required String email,
  }) async {
    final data = state.data.valueOrNull;
    if (data == null) return;
    Log.debug('PersonalCubit.submit');
    safeEmit(state.copyWith(data: const DataState.loading(), fabVisible: false));
    final changed = data.copyWith(
      firstName: firstName,
      lastName: lastName,
      fathersName: fathersName,
      phoneNumber: phoneNumber,
      email: email,
    );
    try {
      final user = await _personalService.changePersonal(changed);
      Log.info('PersonalCubit.submit ok: id=${user.id}');
      safeEmit(PersonalState(data: DataState.content(user)));
    } catch (e, s) {
      Log.error('PersonalCubit.submit failed', e, s);
      safeEmit(state.copyWith(data: DataState.error(e)));
    }
  }
}
