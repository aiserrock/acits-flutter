import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:acits_flutter/export.dart';
import 'package:acits_flutter/di/di_container.dart';
import 'package:acits_flutter/service/personal/personal_service.dart';
import 'package:acits_flutter/ui/screen/personal_screen/cubit/personal_state.dart';

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
    emit(state.copyWith(data: const DataState.loading(), fabVisible: false));
    try {
      final user = await _personalService.fetchPersonal(force: true);
      emit(PersonalState(data: DataState.content(user)));
      return user;
    } catch (e) {
      emit(state.copyWith(data: DataState.error(e)));
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
      emit(state.copyWith(fabVisible: changed));
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
    emit(state.copyWith(data: const DataState.loading(), fabVisible: false));
    final changed = data.copyWith(
      firstName: firstName,
      lastName: lastName,
      fathersName: fathersName,
      phoneNumber: phoneNumber,
      email: email,
    );
    try {
      final user = await _personalService.changePersonal(changed);
      emit(PersonalState(data: DataState.content(user)));
    } catch (e) {
      emit(state.copyWith(data: DataState.error(e)));
    }
  }
}
