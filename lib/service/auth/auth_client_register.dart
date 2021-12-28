import 'dart:async';
import 'dart:io';

import 'package:acits_flutter/api/openapi.swagger.dart';
import 'package:acits_flutter/di/di_container.dart';
import 'package:acits_flutter/service/auth/auth_service.dart';
import 'package:chopper/chopper.dart';
import 'package:injectable/injectable.dart';

@module
abstract class AuthClientRegister {
  Future<Openapi> createClient(
    AuthInterceptor authInterceptor,
    HeaderInterceptor headerInterceptor,
  ) async {
    final chopper = ChopperClient(
      baseUrl: 'https://dev.acits.ru',
      interceptors: [
        headerInterceptor,
        HttpLoggingInterceptor(),
      ],
      authenticator: authInterceptor,
      converter: $JsonSerializableConverter(),
    );
    final client = Openapi.create(chopper);
    return client;
  }

  @Named('guest')
  Future<Openapi> createGuestClient() async {
    final chopper = ChopperClient(
        baseUrl: 'https://dev.acits.ru',
        converter: $JsonSerializableConverter(),
        interceptors: [HttpLoggingInterceptor()]);
    final client = Openapi.create(chopper);
    return client;
  }
}

@injectable
class HeaderInterceptor implements RequestInterceptor {
  @override
  FutureOr<Request> onRequest(Request request) {
    final authService = getIt<AuthService>();
    return request.copyWith(
        headers: request.headers..addAll({'authorization': 'Bearer ${authService.access}'}));
  }
}

@injectable
class AuthInterceptor implements Authenticator {
  @override
  FutureOr<Request?> authenticate(
    Request request,
    Response response,
  ) async {
    if (response.statusCode == HttpStatus.unauthorized) {
      final authService = getIt<AuthService>();
      final token = await authService.refreshToken().then((value) => value?.access);
      if (token != null) {
        return request.copyWith(
            headers: request.headers..addAll({'authorization': 'Bearer $token'}));
      }
    } else {
      return null;
    }
  }
}
