import 'dart:async';
import 'dart:io';

import 'package:http/io_client.dart' as http;
import 'package:chopper/chopper.dart';
import 'package:injectable/injectable.dart';

import 'package:acits_flutter/service/shared_pref/preference_storage.dart';
import 'package:acits_flutter/api/openapi.swagger.dart';
import 'package:acits_flutter/di/di_container.dart';
import 'package:acits_flutter/domain/env.dart';
import 'package:acits_flutter/service/auth/auth_service.dart';

@module
abstract class AuthClientRegister {
  Openapi createClient(
    AuthInterceptor authInterceptor,
    HeaderInterceptor headerInterceptor,
    Env env,
    PreferenceStorage ps,
  ) {
    final proxyUrl = ps.proxy;

    final t = HttpClient();

    if (proxyUrl != null) {
      t.findProxy = (url) => 'PROXY $proxyUrl';
    }

    final chopper = ChopperClient(
      client: http.IOClient(t),
      baseUrl: env.apiUrl,
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
  Openapi createGuestClient(
    Env env,
    PreferenceStorage ps,
  ) {
    final proxyUrl = ps.proxy;

    final t = HttpClient();

    if (proxyUrl != null) {
      t.findProxy = (url) => 'PROXY $proxyUrl';
    }

    final chopper = ChopperClient(
        client: http.IOClient(t),
        baseUrl: env.apiUrl,
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
    Response response, [
    Request? _,
  ]) async {
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
    return null;
  }
}
