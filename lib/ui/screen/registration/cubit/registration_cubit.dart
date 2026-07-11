import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:acits_flutter/util/bloc_ext.dart';

import 'package:acits_flutter/gen/api/openapi.swagger.dart';
import 'package:acits_flutter/di/di_container.dart';
import 'package:acits_flutter/service/auth/auth_service.dart';
import 'package:acits_flutter/ui/screen/registration/cubit/registration_state.dart';
import 'package:acits_flutter/util/logger/log.dart';

/// Cubit флоу регистрации.
///
/// Владеет флагами состояния экрана (таб, согласие, отправка, роль, приют) и
/// бизнес-логикой регистрации через [AuthService]. UI-контроллеры
/// ([TabController]/[TextEditingController]/[GlobalKey]) остаются во
/// [StatefulWidget] экрана.
class RegistrationCubit extends Cubit<RegistrationState> {
  RegistrationCubit() : _authService = getIt<AuthService>(), super(const RegistrationState());

  final AuthService _authService;

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
  void setShelter(ShelterShortSerializers shelter) {
    safeEmit(state.copyWith(shelter: shelter));
  }

  /// Зарегистрировать администратора приюта.
  ///
  /// Возвращает `true` при успехе, `false` — при ошибке (виджет показывает
  /// snackbar). Бросает исключение наружу для показа сообщения.
  Future<bool> submitAdmin(UserShelterAdminSerializers admin) async {
    if (state.submitting) return false;
    Log.debug('RegistrationCubit.submitAdmin email=${admin.email}');
    safeEmit(state.copyWith(submitting: true));
    try {
      final result = await _authService.registrationAdmin(admin);
      Log.info('RegistrationCubit.submitAdmin ok: email=${admin.email}');
      return result is UserShelterAdminSerializers;
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
  Future<bool> submitCustomer(UserShelterWorkerSerializers customer) async {
    if (state.submitting) return false;
    Log.debug('RegistrationCubit.submitCustomer email=${customer.email}');
    safeEmit(state.copyWith(submitting: true));
    try {
      final result = await _authService.registrationCustomer(customer);
      Log.info('RegistrationCubit.submitCustomer ok: email=${customer.email}');
      return result is UserShelterWorkerSerializers;
    } catch (e, s) {
      Log.error('RegistrationCubit.submitCustomer failed', e, s);
      rethrow;
    } finally {
      safeEmit(state.copyWith(submitting: false));
    }
  }
}
