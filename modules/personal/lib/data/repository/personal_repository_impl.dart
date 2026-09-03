import 'package:core/api.dart' show ProfileApiPort;
import 'package:core/data.dart';
import 'package:util/util.dart';

import 'package:personal/data/mapper/mapper.dart';
import 'package:personal/domain/domain.dart';
import 'package:personal/util/util.dart';

/// Реализация [PersonalRepository]. Здесь DTO заканчиваются: вызываем
/// [ProfileApiPort], разворачиваем DTO → сущность маппером, ловим исключения →
/// типизированный [Failure] через общий [guard]. Наружу (в домен/UI) уходят
/// только сущности в [Result].
///
/// Держит кеш профиля (его читает боковое меню, чтобы не ходить в сеть на
/// каждый показ) и сбрасывает его по сигналу разлогина из
/// [PersonalShelterProvider].
class PersonalRepositoryImpl implements PersonalRepository {
  PersonalRepositoryImpl(this._port, this._shelterProvider) {
    _shelterProvider.addLogoutListener(_onLogout);
  }

  final ProfileApiPort _port;
  final PersonalShelterProvider _shelterProvider;

  UserProfile? _person;

  @override
  Future<Result<Failure, UserProfile>> fetchPersonal({bool force = false}) async {
    Log.debug('Fetch personal: force=$force');
    final cached = _person;
    if (!force && cached != null) {
      Log.debug('Personal returned from cache: id=${cached.id}');
      return Ok(cached);
    }

    final result = await guard(() async {
      final dto = await _port.me(shelterId: _shelterProvider.shelterId);
      return UserProfileMapper(dto).toEntity();
    });
    return result.map((user) {
      _person = user;
      Log.info('Personal loaded: id=${user.id}');
      return user;
    });
  }

  @override
  Future<Result<Failure, UserProfile>> changePersonal(UserProfile data) async {
    Log.debug('Change personal: id=${data.id}');
    final result = await guard(() async {
      final dto = await _port.updateMe(UserProfileWriteMapper(data).toDto(), shelterId: _shelterProvider.shelterId);
      return UserProfileMapper(dto).toEntity();
    });
    return result.map((user) {
      _person = user;
      Log.info('Personal updated: id=${user.id}');
      return user;
    });
  }

  @override
  Future<Result<Failure, void>> changePass(String oldPass, String newPass) {
    Log.debug('Change password attempt');
    return guard(() async {
      await _port.changePassword(oldPass, newPass, shelterId: _shelterProvider.shelterId);
      Log.info('Change password success');
    });
  }

  /// Сброс кеша профиля при разлогине.
  void _onLogout() {
    _person = null;
  }
}
