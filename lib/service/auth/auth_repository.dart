import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:injectable/injectable.dart';

const _refreshKey = 'refreshKey';

/// Хранилище key-value в аппаратном storage
@injectable
class AuthRepository {
  AuthRepository(this._secureStorage);

  final FlutterSecureStorage _secureStorage;

  /// Сохранить refresh токен
  Future<void> setRefresh(String? token) => _secureStorage.write(key: _refreshKey, value: token);

  /// Прочитать refresh токен
  Future<String?> get refresh => _secureStorage.read(key: _refreshKey);
}
