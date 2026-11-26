import 'package:util/util.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:personal/domain/domain.dart';
import 'package:personal/presentation/personal/personal.dart';
import 'package:personal/util/util.dart';

/// Cubit экрана личного кабинета. Загружает данные пользователя и сохраняет
/// изменённые поля. Данные — доменный [UserProfile] из [PersonalRepository]
/// (Result, без DTO). UI-контроллеры (TextEditingController) живут в виджете.
class PersonalCubit extends Cubit<PersonalState> {
  PersonalCubit(this._repository) : super(const PersonalState.loading());

  final PersonalRepository _repository;

  /// Загрузить данные пользователя. Возвращает загруженного пользователя,
  /// чтобы виджет мог проинициализировать контроллеры полей.
  Future<UserProfile?> load() async {
    Log.debug('PersonalCubit.load');
    safeEmit(state.copyWith(data: const DataState.loading(), fabVisible: false));
    final result = await _repository.fetchPersonal(force: true);
    return result.fold(
      (failure) {
        Log.error('PersonalCubit.load failed: $failure');
        safeEmit(state.copyWith(data: DataState.error(failure)));
        return null;
      },
      (user) {
        Log.info('PersonalCubit.load ok: id=${user.id}');
        safeEmit(PersonalState(data: DataState.content(user)));
        return user;
      },
    );
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
    final result = await _repository.changePersonal(changed);
    result.fold(
      (failure) {
        Log.error('PersonalCubit.submit failed: $failure');
        safeEmit(state.copyWith(data: DataState.error(failure)));
      },
      (user) {
        Log.info('PersonalCubit.submit ok: id=${user.id}');
        safeEmit(PersonalState(data: DataState.content(user)));
      },
    );
  }
}
