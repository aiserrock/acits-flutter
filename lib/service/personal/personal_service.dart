import 'package:acits_flutter/domain/exception.dart';
import 'package:acits_flutter/export.dart';
import 'package:acits_flutter/service/auth/auth_service.dart';
import 'package:acits_flutter/util/logger/log.dart';
import 'package:injectable/injectable.dart';

@singleton
class PersonalService {
  PersonalService(this._acitsClient, this._authService) {
    _authService.addListener(_onLogout);
  }

  final Openapi _acitsClient;
  final AuthService _authService;

  UserSerializers? _person;

  Future<UserSerializers> fetchPersonal({bool force = false}) async {
    Log.debug('Fetch personal: force=$force');
    final cached = _person;
    if (!force && cached != null) {
      Log.debug('Personal returned from cache: id=${cached.id}');
      return cached;
    }

    final result = await _acitsClient.apiV1UsersMeGet(
      xCurrentShelter: _authService.currentShelterId,
    );

    final user = result.body;
    if (user != null) {
      _person = user;
      Log.info('Personal loaded: id=${user.id}');
      return user;
    } else {
      Log.warning('Fetch personal failed: ${result.error}');
      throw MessagedException(error: result.error);
    }
  }

  /// Изменить данные пользователя
  Future<UserSerializers> changePersonal(UserSerializers data) async {
    Log.debug('Change personal: id=${data.id}');
    final result = await _acitsClient.apiV1UsersMePut(
      body: data,
      xCurrentShelter: _authService.currentShelterId,
    );

    final user = result.body;
    if (user != null) {
      _person = user;
      Log.info('Personal updated: id=${user.id}');
      return user;
    } else {
      Log.warning('Change personal failed: ${result.error}');
      throw MessagedException(error: result.error);
    }
  }

  /// Очистка кеша сервиса при разлогине
  void _onLogout() {
    _person = null;
  }

  /// Сменить пароль пользователя
  Future<void> changePass(String oldPass, String newPass) async {
    Log.debug('Change password attempt');
    final result = await _acitsClient.apiV1UsersMeChangePasswordPut(
      body: UserChangePasswordSerializers(
        oldPassword: oldPass,
        password: newPass,
        rePassword: newPass,
      ),
      xCurrentShelter: _authService.currentShelterId,
    );

    if (result.body != null) {
      Log.info('Change password success');
      return;
    } else {
      Log.warning('Change password failed: ${result.error}');
      throw MessagedException(error: result.error);
    }
  }
}
