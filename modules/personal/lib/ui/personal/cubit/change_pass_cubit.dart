import 'package:acits_core/acits_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/personal_service.dart';
import '../../../util/bloc_ext.dart';
import '../../../util/log.dart';

/// Cubit смены пароля пользователя.
///
/// Держит только состояние отправки запроса ([DataState]). UI-контроллеры
/// (поля ввода) остаются во виджете. Начальное состояние — [DataState.content].
class ChangePassCubit extends Cubit<DataState<void>> {
  ChangePassCubit(this._personalService) : super(const DataState.content(null));

  final PersonalService _personalService;

  /// Отправить новый пароль. Возвращает `true` при успехе, `false` при ошибке.
  ///
  /// В случае ошибки пробрасывает её через состояние [DataState.error], чтобы
  /// виджет мог показать сообщение и вернуть форму в редактируемый вид.
  Future<bool> submit(String oldPass, String newPass) async {
    Log.debug('ChangePassCubit.submit change password attempt');
    safeEmit(const DataState.loading());
    try {
      await _personalService.changePass(oldPass, newPass);
      Log.info('ChangePassCubit.submit ok: change password success');
      safeEmit(const DataState.content(null));
      return true;
    } catch (e, s) {
      Log.error('ChangePassCubit.submit change password failed', e, s);
      safeEmit(DataState.error(e));
      return false;
    }
  }
}
