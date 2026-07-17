import 'package:acits_api/acits_api.dart';
import 'package:acits_domain/acits_domain.dart' show MessagedException;
import 'package:dio/dio.dart';

import 'package:personal/domain/domain.dart';
import 'package:personal/util/util.dart';

/// Сервис профиля текущего пользователя.
///
/// Прикладной сервис поверх стабильного [ProfileApiPort]: вызывает порт,
/// разворачивает DTO → доменную сущность [UserProfile], ошибки Dio →
/// [MessagedException] (внешний контракт для UI сохранён). Скоуп по приюту и
/// сигнал разлогина (для сброса кеша) берутся из [PersonalShelterProvider]
/// (мостится в приложении к AuthService).
class PersonalService {
  PersonalService(this._port, this._shelterProvider) {
    _shelterProvider.addLogoutListener(_onLogout);
  }

  final ProfileApiPort _port;
  final PersonalShelterProvider _shelterProvider;

  UserProfile? _person;

  Future<UserProfile> fetchPersonal({bool force = false}) async {
    Log.debug('Fetch personal: force=$force');
    final cached = _person;
    if (!force && cached != null) {
      Log.debug('Personal returned from cache: id=${cached.id}');
      return cached;
    }

    try {
      final dto = await _port.me(shelterId: _shelterProvider.shelterId);
      final user = _mapUser(dto);
      _person = user;
      Log.info('Personal loaded: id=${user.id}');
      return user;
    } on DioException catch (e) {
      Log.warning('Fetch personal failed: ${_errorText(e)}');
      throw MessagedException(error: _errorText(e));
    }
  }

  /// Изменить данные пользователя
  Future<UserProfile> changePersonal(UserProfile data) async {
    Log.debug('Change personal: id=${data.id}');
    try {
      final dto = await _port.updateMe(_toWrite(data), shelterId: _shelterProvider.shelterId);
      final user = _mapUser(dto);
      _person = user;
      Log.info('Personal updated: id=${user.id}');
      return user;
    } on DioException catch (e) {
      Log.warning('Change personal failed: ${_errorText(e)}');
      throw MessagedException(error: _errorText(e));
    }
  }

  /// Очистка кеша сервиса при разлогине
  void _onLogout() {
    _person = null;
  }

  /// Сменить пароль пользователя
  Future<void> changePass(String oldPass, String newPass) async {
    Log.debug('Change password attempt');
    try {
      await _port.changePassword(oldPass, newPass, shelterId: _shelterProvider.shelterId);
      Log.info('Change password success');
    } on DioException catch (e) {
      Log.warning('Change password failed: ${_errorText(e)}');
      throw MessagedException(error: _errorText(e));
    }
  }

  // ── DTO ↔ сущность ──────────────────────────────────────────────────────────

  UserProfile _mapUser(UserDto d) => UserProfile(
    id: d.id,
    username: d.username,
    firstName: d.firstName,
    lastName: d.lastName,
    fullName: d.fullName,
    email: d.email,
    dateJoined: d.dateJoined,
    isVerified: d.isVerified,
    fathersName: d.fathersName,
    phoneNumber: d.phoneNumber,
    address: d.address,
    isOfferSigned: d.isOfferSigned,
  );

  UserWriteDto _toWrite(UserProfile u) => UserWriteDto(
    id: u.id,
    username: u.username,
    firstName: u.firstName,
    lastName: u.lastName,
    fullName: u.fullName,
    email: u.email,
    dateJoined: u.dateJoined,
    isVerified: u.isVerified,
    fathersName: u.fathersName,
    phoneNumber: u.phoneNumber,
    address: u.address,
    isOfferSigned: u.isOfferSigned,
  );

  String _errorText(DioException e) => e.response?.data?.toString() ?? e.message ?? e.toString();
}
