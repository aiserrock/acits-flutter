import 'package:acits_domain/acits_domain.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:auth/domain/domain.dart';
import 'package:auth/presentation/registration/cubit/cubit.dart';
import 'package:auth/util/util.dart';

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

  /// Зарегистрировать администратора приюта.
  ///
  /// Возвращает `true` при успехе, `false` — при ошибке (виджет показывает
  /// snackbar). Бросает исключение наружу для показа сообщения.
  Future<bool> submitAdmin(AdminRegistrationInput admin) async {
    if (state.submitting) return false;
    Log.debug('RegistrationCubit.submitAdmin email=${admin.email}');
    safeEmit(state.copyWith(submitting: true));
    try {
      final result = await _authService.registrationAdmin(admin);
      Log.info('RegistrationCubit.submitAdmin ok: email=${admin.email}');
      return result;
    } catch (e, s) {
      Log.error('RegistrationCubit.submitAdmin failed', e, s);
      rethrow;
    } finally {
      safeEmit(state.copyWith(submitting: false));
    }
  }

  /// Зарегистрировать кастомера.
  ///
  /// Возвращает `true` при успехе, `false` — при ошибке (виджет показывает
  /// snackbar). Бросает исключение наружу для показа сообщения.
  Future<bool> submitCustomer(WorkerRegistrationInput customer) async {
    if (state.submitting) return false;
    Log.debug('RegistrationCubit.submitCustomer email=${customer.email}');
    safeEmit(state.copyWith(submitting: true));
    try {
      final result = await _authService.registrationCustomer(customer);
      Log.info('RegistrationCubit.submitCustomer ok: email=${customer.email}');
      return result;
    } catch (e, s) {
      Log.error('RegistrationCubit.submitCustomer failed', e, s);
      rethrow;
    } finally {
      safeEmit(state.copyWith(submitting: false));
    }
  }
}
