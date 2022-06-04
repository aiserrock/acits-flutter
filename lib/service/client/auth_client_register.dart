import 'dart:io';

import 'package:http/io_client.dart' as http;
import 'package:chopper/chopper.dart';
import 'package:injectable/injectable.dart';

import 'package:acits_flutter/service/shared_pref/preference_storage.dart';
import 'package:acits_flutter/api/openapi.swagger.dart';
import 'package:acits_flutter/domain/env.dart';
import 'package:acits_flutter/service/client/auth_interceptor.dart';
import 'package:acits_flutter/service/client/header_inteceptor.dart';

@module
abstract class ClientRegister {
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
