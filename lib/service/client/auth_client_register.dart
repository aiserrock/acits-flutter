import 'package:chopper/chopper.dart';
import 'package:injectable/injectable.dart';

import 'package:acits_flutter/export.dart';
import 'package:acits_flutter/domain/env.dart';
import 'package:acits_flutter/service/client/auth_interceptor.dart';
import 'package:acits_flutter/service/client/header_inteceptor.dart';

@module
abstract class ClientRegister {
  @prod
  Openapi createClient(
    AuthInterceptor authInterceptor,
    HeaderInterceptor headerInterceptor,
    Env env,
  ) {
    final chopper = ChopperClient(
      baseUrl: Uri.parse(env.apiUrl),
      interceptors: [headerInterceptor, HttpLoggingInterceptor()],
      authenticator: authInterceptor,
      converter: $JsonSerializableConverter(),
    );
    final client = Openapi.create(chopper);
    return client;
  }

  @prod
  @Named('guest')
  Openapi createGuestClient(Env env) {
    final chopper = ChopperClient(
      baseUrl: Uri.parse(env.apiUrl),
      converter: $JsonSerializableConverter(),
      interceptors: [HttpLoggingInterceptor()],
    );
    final client = Openapi.create(chopper);
    return client;
  }
}
