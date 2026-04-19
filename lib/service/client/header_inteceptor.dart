import 'dart:async';

import 'package:chopper/chopper.dart';
import 'package:injectable/injectable.dart';

import 'package:acits_flutter/di/di_container.dart';
import 'package:acits_flutter/service/auth/auth_service.dart';
import 'package:acits_flutter/service/config/config_service.dart';

@injectable
class HeaderInterceptor implements Interceptor {
  @override
  FutureOr<Response<BodyType>> intercept<BodyType>(Chain<BodyType> chain) async {
    final authService = getIt<AuthService>();
    final configService = getIt<ConfigService>();
    final request = chain.request.copyWith(
      headers: {
        ...chain.request.headers,
        'authorization': 'Bearer ${authService.access}',
        'accept-language': configService.local,
      },
    );
    return chain.proceed(request);
  }
}
