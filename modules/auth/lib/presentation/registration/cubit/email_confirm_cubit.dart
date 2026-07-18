import 'package:base/base.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:auth/domain/domain.dart';
import 'package:auth/util/util.dart';

/// Cubit экрана подтверждения электронной почты при регистрации.
///
/// Владеет состоянием [DataState]: [DataState.loading] во время запроса,
/// [DataState.content] при успешном подтверждении и [DataState.error] при
/// ошибке. Повторная попытка [retry] заново вызывает подтверждение.
class EmailConfirmCubit extends Cubit<DataState<void>> {
  EmailConfirmCubit({required AuthSessionApi authService, required this.confirmLink})
    : _authService = authService,
      super(const DataState.loading()) {
    _confirmEmail();
  }

  final AuthSessionApi _authService;
  final String confirmLink;

  /// Повторить подтверждение почты.
  Future<void> retry() => _confirmEmail();

  /// Подтвердить электронную почту по ссылке [confirmLink].
  Future<void> _confirmEmail() async {
    Log.debug('EmailConfirmCubit.confirmEmail');
    safeEmit(const DataState.loading());
    try {
      await _authService.confirmEmail(confirmLink);
      Log.info('EmailConfirmCubit.confirmEmail ok');
      safeEmit(const DataState.content(null));
    } catch (e, s) {
      Log.error('EmailConfirmCubit.confirmEmail failed', e, s);
      safeEmit(DataState.error(e));
    }
  }
}
