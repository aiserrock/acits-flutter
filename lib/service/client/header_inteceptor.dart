import 'dart:async';

import 'package:chopper/chopper.dart';
import 'package:injectable/injectable.dart';

import 'package:acits_flutter/di/di_container.dart';
import 'package:acits_flutter/service/auth/auth_service.dart';
import 'package:acits_flutter/service/config/config_service.dart';

@injectable
class HeaderInterceptor implements RequestInterceptor {
  @override
  FutureOr<Request> onRequest(Request request) {
    final authService = getIt<AuthService>();
    final configService = getIt<ConfigService>();
    return request.copyWith(
      headers: request.headers
        ..addAll(
          {
            'authorization': 'Bearer ${authService.access}',
            'accept-language': configService.local,
          },
        ),
    );
  }
}
