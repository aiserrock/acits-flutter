import 'dart:async';
import 'dart:io';

import 'package:chopper/chopper.dart';
import 'package:injectable/injectable.dart';

import 'package:acits_flutter/di/di_container.dart';
import 'package:acits_flutter/service/auth/auth_service.dart';
import 'package:acits_flutter/util/logger/log.dart';

@injectable
class AuthInterceptor implements Authenticator {
  /// Single-flight на refresh: при пачке параллельных 401 токен обновляется
  /// один раз, остальные запросы ждут тот же Future. Иначе несколько refresh
  /// шли бы с одним refresh-токеном, а при его ротации на бэке второй уходил бы
  /// с уже израсходованным токеном → лишний logout.
  static Future<String?>? _inFlightRefresh;

  @override
  FutureOr<Request?> authenticate(Request request, Response response, [Request? _]) async {
    if (response.statusCode != HttpStatus.unauthorized) return null;

    Log.warning('401 on ${request.url} → пробуем refresh токена');
    final authService = getIt<AuthService>();
    String? token;
    try {
      token = await (_inFlightRefresh ??= _refresh(authService));
    } catch (e, s) {
      // Обновление токена не удалось (сеть/невалидный refresh) — не зацикливаем
      // повторную авторизацию, выходим из сессии.
      Log.error('Refresh упал → logout', e, s);
      authService.logout();
      return null;
    }
    if (token == null) return null;

    return request.copyWith(headers: {...request.headers, 'authorization': 'Bearer $token'});
  }

  Future<String?> _refresh(AuthService authService) async {
    try {
      final result = await authService.refreshToken();
      return result?.access;
    } finally {
      // Сбрасываем «замок» после завершения (успех или ошибка), чтобы
      // следующий реальный 401 мог инициировать новый refresh.
      _inFlightRefresh = null;
    }
  }

  @override
  AuthenticationCallback? get onAuthenticationSuccessful => null;

  @override
  AuthenticationCallback? get onAuthenticationFailed => null;
}
