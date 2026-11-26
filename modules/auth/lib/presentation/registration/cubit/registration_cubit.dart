import 'package:util/util.dart';
import 'package:core/domain.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:auth/domain/domain.dart';
import 'package:auth/presentation/registration/cubit/cubit.dart';

/// Cubit флоу регистрации.
///
/// Владеет флагами состояния экрана (таб, согласие, отправка, роль, приют) и
/// бизнес-логикой регистрации через [AuthSessionApi]. UI-контроллеры
/// ([TabController]/[TextEditingController]/[GlobalKey]) остаются во
/// [StatefulWidget] экрана.
class RegistrationCubit extends Cubit<RegistrationState> {
  RegistrationCubit({required AuthSessionApi authService})
    : _authService = authService,
      super(const RegistrationState());

  final AuthSessionApi _authService;

  /// Сменить активный таб (сбрасывает согласие на перс. данные).
  void onTabChanged(int index) {
    if (state.tabIndex == index) return;
    safeEmit(state.copyWith(tabIndex: index, agreedToPolicy: false));
  }

  /// Переключить согласие на обработку персональных данных.
  void togglePersonData() {
    safeEmit(state.copyWith(agreedToPolicy: !state.agreedToPolicy));
  }

  /// Сменить роль кастомера.
  void onCustomerRoleChanged(CustomerRole? role) {
    if (role == null || state.role == role) return;
    safeEmit(state.copyWith(role: role));
  }

  /// Сохранить выбранный пользователем приют.
  void setShelter(Shelter shelter) {
    safeEmit(state.copyWith(shelter: shelter));
  }

  /// Зарегистрировать администратора приюта. `null` — отправка уже идёт, вызов проигнорирован.
  Future<Result<Failure, void>?> submitAdmin(AdminRegistrationInput admin) =>
      _submit('submitAdmin', admin.email, () => _authService.registrationAdmin(admin));

  /// Зарегистрировать кастомера. `null` — отправка уже идёт, вызов проигнорирован.
  Future<Result<Failure, void>?> submitCustomer(WorkerRegistrationInput customer) =>
      _submit('submitCustomer', customer.email, () => _authService.registrationCustomer(customer));

  Future<Result<Failure, void>?> _submit(
    String action,
    String email,
    Future<Result<Failure, void>> Function() request,
  ) async {
    if (state.submitting) return null;
    Log.debug('RegistrationCubit.$action email=$email');
    safeEmit(state.copyWith(submitting: true));
    final result = await request();
    result.fold(
      (failure) => Log.error('RegistrationCubit.$action failed: $failure'),
      (_) => Log.info('RegistrationCubit.$action ok: email=$email'),
    );
    safeEmit(state.copyWith(submitting: false));
    return result;
  }
}
