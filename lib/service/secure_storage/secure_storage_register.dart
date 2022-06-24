import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:injectable/injectable.dart';

@module
abstract class SecureStorageRegister {
  static FlutterSecureStorage? _instance;
  @preResolve
  FlutterSecureStorage createSp() => _instance ??= const FlutterSecureStorage();
}
