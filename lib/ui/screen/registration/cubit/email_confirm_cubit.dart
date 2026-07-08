import 'package:acits_flutter/di/di_container.dart';
import 'package:acits_flutter/service/auth/auth_service.dart';
import 'package:acits_flutter/util/data_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:acits_flutter/util/bloc_ext.dart';

/// Cubit экрана подтверждения электронной почты при регистрации.
///
/// Владеет состоянием [DataState]: [DataState.loading] во время запроса,
/// [DataState.content] при успешном подтверждении и [DataState.error] при
/// ошибке. Повторная попытка [retry] заново вызывает подтверждение.
class EmailConfirmCubit extends Cubit<DataState<void>> {
  EmailConfirmCubit({required this.confirmLink})
    : _authService = getIt<AuthService>(),
      super(const DataState.loading()) {
    _confirmEmail();
  }

  final AuthService _authService;
  final String confirmLink;

  /// Повторить подтверждение почты.
  Future<void> retry() => _confirmEmail();

  /// Подтвердить электронную почту по ссылке [confirmLink].
  Future<void> _confirmEmail() async {
    safeEmit(const DataState.loading());
    try {
      await _authService.confirmEmail(confirmLink);
      safeEmit(const DataState.content(null));
    } catch (e) {
      safeEmit(DataState.error(e));
    }
  }
}
