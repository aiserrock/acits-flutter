import 'package:util/util.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:personal/domain/domain.dart';
import 'package:personal/util/util.dart';

/// Cubit смены пароля пользователя.
///
/// Держит только состояние отправки запроса ([DataState]). UI-контроллеры
/// (поля ввода) остаются во виджете. Начальное состояние — [DataState.content].
class ChangePassCubit extends Cubit<DataState<void>> {
  ChangePassCubit(this._repository) : super(const DataState.content(null));

  final PersonalRepository _repository;

  /// Отправить новый пароль. Возвращает `true` при успехе, `false` при ошибке.
  ///
  /// В случае ошибки кладёт [Failure] в состояние [DataState.error], чтобы
  /// виджет мог показать сообщение и вернуть форму в редактируемый вид.
  Future<bool> submit(String oldPass, String newPass) async {
    Log.debug('ChangePassCubit.submit change password attempt');
    safeEmit(const DataState.loading());
    final result = await _repository.changePass(oldPass, newPass);
    return result.fold(
      (failure) {
        Log.error('ChangePassCubit.submit change password failed: $failure');
        safeEmit(DataState.error(failure));
        return false;
      },
      (_) {
        Log.info('ChangePassCubit.submit ok: change password success');
        safeEmit(const DataState.content(null));
        return true;
      },
    );
  }
}
