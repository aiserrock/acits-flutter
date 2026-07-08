import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:acits_flutter/util/bloc_ext.dart';

import 'package:acits_flutter/di/di_container.dart';
import 'package:acits_flutter/service/personal/personal_service.dart';
import 'package:acits_flutter/util/data_state.dart';

/// Cubit смены пароля пользователя.
///
/// Держит только состояние отправки запроса ([DataState]). UI-контроллеры
/// (поля ввода) остаются во виджете. Начальное состояние — [DataState.content].
class ChangePassCubit extends Cubit<DataState<void>> {
  ChangePassCubit()
    : _personalService = getIt<PersonalService>(),
      super(const DataState.content(null));

  final PersonalService _personalService;

  /// Отправить новый пароль. Возвращает `true` при успехе, `false` при ошибке.
  ///
  /// В случае ошибки пробрасывает её через состояние [DataState.error], чтобы
  /// виджет мог показать сообщение и вернуть форму в редактируемый вид.
  Future<bool> submit(String oldPass, String newPass) async {
    safeEmit(const DataState.loading());
    try {
      await _personalService.changePass(oldPass, newPass);
      safeEmit(const DataState.content(null));
      return true;
    } catch (e) {
      safeEmit(DataState.error(e));
      return false;
    }
  }
}
