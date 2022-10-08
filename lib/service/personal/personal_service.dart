import 'package:acits_flutter/domain/exception.dart';
import 'package:acits_flutter/export.dart';
import 'package:acits_flutter/service/auth/auth_service.dart';
import 'package:injectable/injectable.dart';

@singleton
class PersonalService {
  PersonalService(
    this._acitsClient,
    this._authService,
  ) {
    _authService.addListener(_onLogout);
  }

  final Openapi _acitsClient;
  final AuthService _authService;

  UserSerializers? _person;

  Future<UserSerializers> fetchPersonal({bool force = false}) async {
    final cached = _person;
    if (!force && cached != null) return cached;

    final result = await _acitsClient.apiV1UsersMeGet(
      xCurrentShelter: _authService.currentShelterId,
    );

    final user = result.body;
    if (user != null) {
      _person = user;
      return user;
    } else {
      throw MessagedException(error: result.error);
    }
  }

  /// Изменить данные пользователя
  Future<UserSerializers> changePersonal(UserSerializers data) async {
    final result = await _acitsClient.apiV1UsersMePut(
      body: data,
      xCurrentShelter: _authService.currentShelterId,
    );

    final user = result.body;
    if (user != null) {
      _person = user;
      return user;
    } else {
      throw MessagedException(error: result.error);
    }
  }

  /// Очистка кеша сервиса при разлогине
  void _onLogout() {
    _person = null;
  }

  /// Сменить пароль пользователя
  Future<void> changePass(
    String oldPass,
    String newPass,
  ) async {
    final result = await _acitsClient.apiV1UsersMeChangePasswordPut(
      body: UserChangePasswordSerializers(
        oldPassword: oldPass,
        password: newPass,
        rePassword: newPass,
      ),
      xCurrentShelter: _authService.currentShelterId,
    );

    if (result.body != null) {
      return;
    } else {
      throw MessagedException(error: result.error);
    }
  }
}
