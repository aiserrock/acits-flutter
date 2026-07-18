import 'package:network/network.dart';
import 'package:injectable/injectable.dart';

import 'package:di/di.dart';
import 'package:app_services/src/service/auth/auth_service.dart';
import 'package:app_services/src/service/config/config_service.dart';

/// Мосты между портами base (сеть/интерцепторы) и существующими
/// сервисами приложения. base не знает про [AuthService]/[ConfigService];
/// эти адаптеры инъектятся в новый Dio (Step 7).
///
/// [AuthService] резолвится ЛЕНИВО через `getIt`, а не конструктором: authed
/// Dio держит эти мосты, а [AuthService] теперь сам зависит от [AuthApiPort]
/// (поверх того же Dio) — конструкторная инъекция замкнула бы цикл. Ленивый
/// резолв (как в chopper HeaderInterceptor) его разрывает.

/// Отдаёт текущий access-токен из [AuthService].
@Injectable(as: TokenStore)
class AuthServiceTokenStore implements TokenStore {
  const AuthServiceTokenStore();

  @override
  String? get accessToken => getIt<AuthService>().access;
}

/// Обновляет токен через [AuthService.refreshToken]. Возвращает новый access
/// или null, если refresh не удался (контракт [TokenRefresher]).
@Injectable(as: TokenRefresher)
class AuthServiceTokenRefresher implements TokenRefresher {
  const AuthServiceTokenRefresher();

  @override
  Future<String?> refresh() async {
    final result = await getIt<AuthService>().refreshToken();
    return result?.access;
  }
}

/// Инвалидирует сессию через [AuthService.logout].
@Injectable(as: SessionInvalidator)
class AuthServiceSessionInvalidator implements SessionInvalidator {
  const AuthServiceSessionInvalidator();

  @override
  void invalidate() => getIt<AuthService>().logout();
}

/// Отдаёт текущую локаль (формат `ru-RU`) для accept-language из
/// [ConfigService.local].
@Injectable(as: LocaleProvider)
class ConfigServiceLocaleProvider implements LocaleProvider {
  const ConfigServiceLocaleProvider();

  // Ленивый резолв (как chopper HeaderInterceptor): ConfigService зависит от
  // AuthService, а тот теперь — от AuthApiPort поверх этого же Dio.
  @override
  String get locale => getIt<ConfigService>().local;
}
