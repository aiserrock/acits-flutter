import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:injectable/injectable.dart';

@module
abstract class SecureStorageRegister {
  static FlutterSecureStorage? _instance;

  FlutterSecureStorage createSp() => _instance ??= const FlutterSecureStorage(
    // Явно ограничиваем доступ к Keychain на iOS: только после первой
    // разблокировки устройства (данные недоступны до первого unlock).
    // На Android хранилище шифруется по умолчанию (v10+), доп. опции не нужны.
    iOptions: IOSOptions(accessibility: KeychainAccessibility.first_unlock),
  );
}
