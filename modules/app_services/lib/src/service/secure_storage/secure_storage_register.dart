import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:injectable/injectable.dart';

@module
abstract class SecureStorageRegister {
  static FlutterSecureStorage? _instance;

  FlutterSecureStorage createSp() => _instance ??= const FlutterSecureStorage(
    // Явно ограничиваем доступ к Keychain на iOS: только после первой
    // разблокировки устройства (данные недоступны до первого unlock).
    iOptions: IOSOptions(accessibility: KeychainAccessibility.first_unlock),
    // v11 сменил шифр ключа по умолчанию (RSA-OAEP → AES-GCM) и переносит данные
    // при первом доступе; бэкап страхует перенос от обрыва на середине.
    aOptions: AndroidOptions(migrateWithBackup: true),
  );
}
