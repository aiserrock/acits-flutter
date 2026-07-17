import 'package:acits_core/acits_core.dart';
import 'package:injectable/injectable.dart';

import 'package:acits_flutter/service/auth/auth_service.dart';
import 'package:acits_flutter/service/config/config_service.dart';

/// Мосты между портами acits_core (сеть/интерцепторы) и существующими
/// сервисами приложения. acits_core не знает про [AuthService]/[ConfigService];
/// эти адаптеры инъектятся в новый Dio (Step 7) и живут рядом с chopper, пока
/// фичи не мигрированы. Регистрируются в DI, но новый Dio пока никем не
/// используется — «adapters exist before they are registered/used».

/// Отдаёт текущий access-токен из [AuthService].
@Injectable(as: TokenStore)
class AuthServiceTokenStore implements TokenStore {
  const AuthServiceTokenStore(this._authService);

  final AuthService _authService;

  @override
  String? get accessToken => _authService.access;
}

/// Обновляет токен через [AuthService.refreshToken]. Возвращает новый access
/// или null, если refresh не удался (контракт [TokenRefresher]).
@Injectable(as: TokenRefresher)
class AuthServiceTokenRefresher implements TokenRefresher {
  const AuthServiceTokenRefresher(this._authService);

  final AuthService _authService;

  @override
  Future<String?> refresh() async {
    final result = await _authService.refreshToken();
    return result?.access;
  }
}

/// Инвалидирует сессию через [AuthService.logout].
@Injectable(as: SessionInvalidator)
class AuthServiceSessionInvalidator implements SessionInvalidator {
  const AuthServiceSessionInvalidator(this._authService);

  final AuthService _authService;

  @override
  void invalidate() => _authService.logout();
}

/// Отдаёт текущую локаль (формат `ru-RU`) для accept-language из
/// [ConfigService.local].
@Injectable(as: LocaleProvider)
class ConfigServiceLocaleProvider implements LocaleProvider {
  const ConfigServiceLocaleProvider(this._configService);

  final ConfigService _configService;

  @override
  String get locale => _configService.local;
}
