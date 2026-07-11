import 'dart:async';
import 'dart:io';

import 'package:chopper/chopper.dart';
import 'package:injectable/injectable.dart';

import 'package:acits_flutter/di/di_container.dart';
import 'package:acits_flutter/service/auth/auth_service.dart';
import 'package:acits_flutter/util/logger/log.dart';

@injectable
class AuthInterceptor implements Authenticator {
  @override
  FutureOr<Request?> authenticate(Request request, Response response, [Request? _]) async {
    if (response.statusCode != HttpStatus.unauthorized) return null;

    Log.warning('401 on ${request.url} → пробуем refresh токена');
    final authService = getIt<AuthService>();
    String? token;
    try {
      token = await authService.refreshToken().then((value) => value?.access);
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

  @override
  AuthenticationCallback? get onAuthenticationSuccessful => null;

  @override
  AuthenticationCallback? get onAuthenticationFailed => null;
}
