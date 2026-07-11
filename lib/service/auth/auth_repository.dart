import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:injectable/injectable.dart';

import 'package:acits_flutter/util/logger/log.dart';

const _refreshKey = 'refreshKey';

/// Хранилище key-value в аппаратном storage
@injectable
class AuthRepository {
  AuthRepository(this._secureStorage);

  final FlutterSecureStorage _secureStorage;

  /// Сохранить refresh токен
  Future<void> setRefresh(String? token) {
    Log.debug(token == null ? 'Refresh token cleared' : 'Refresh token stored');
    return _secureStorage.write(key: _refreshKey, value: token);
  }

  /// Прочитать refresh токен
  Future<String?> get refresh {
    Log.debug('Read refresh token');
    return _secureStorage.read(key: _refreshKey);
  }

  /// Удалить refresh токен из хранилища
  Future<void> clearRefresh() {
    Log.debug('Refresh token cleared');
    return _secureStorage.delete(key: _refreshKey);
  }
}
