import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:acits_flutter/api/openapi.swagger.dart';
import 'package:acits_flutter/di/di_container.dart';
import 'package:acits_flutter/service/auth/auth_service.dart';
import 'package:acits_flutter/ui/screen/registration/cubit/registration_state.dart';

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
    emit(state.copyWith(tabIndex: index, agreedToPolicy: false));
  }

  /// Переключить согласие на обработку персональных данных.
  void togglePersonData() {
    emit(state.copyWith(agreedToPolicy: !state.agreedToPolicy));
  }

  /// Сменить роль кастомера.
  void onCustomerRoleChanged(CustomerRole? role) {
    if (role == null || state.role == role) return;
    emit(state.copyWith(role: role));
  }

  /// Сохранить выбранный пользователем приют.
  void setShelter(ShelterShortSerializers shelter) {
    emit(state.copyWith(shelter: shelter));
  }

  /// Зарегистрировать администратора приюта.
  ///
  /// Возвращает `true` при успехе, `false` — при ошибке (виджет показывает
  /// snackbar). Бросает исключение наружу для показа сообщения.
  Future<bool> submitAdmin(UserShelterAdminSerializers admin) async {
    if (state.submitting) return false;
    emit(state.copyWith(submitting: true));
    try {
      final result = await _authService.registrationAdmin(admin);
      return result is UserShelterAdminSerializers;
    } finally {
      emit(state.copyWith(submitting: false));
    }
  }

  /// Зарегистрировать кастомера.
  ///
  /// Возвращает `true` при успехе, `false` — при ошибке (виджет показывает
  /// snackbar). Бросает исключение наружу для показа сообщения.
  Future<bool> submitCustomer(UserShelterWorkerSerializers customer) async {
    if (state.submitting) return false;
    emit(state.copyWith(submitting: true));
    try {
      final result = await _authService.registrationCustomer(customer);
      return result is UserShelterWorkerSerializers;
    } finally {
      emit(state.copyWith(submitting: false));
    }
  }
}
