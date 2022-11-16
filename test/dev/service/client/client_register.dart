import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:http/io_client.dart' as http;
import 'package:chopper/chopper.dart';
import 'package:injectable/injectable.dart';

import 'package:acits_flutter/export.dart';
import 'package:acits_flutter/domain/env.dart';
import 'package:acits_flutter/service/client/auth_interceptor.dart';
import 'package:acits_flutter/service/client/header_inteceptor.dart';

import '../shared_pref/debug_preference_storage.dart';
import 'http_logger_interceptor.dart';

@module
abstract class ClientRegisterDev {
  @dev
  Openapi createClient(
    AuthInterceptor authInterceptor,
    HeaderInterceptor headerInterceptor,
    Env env,
    DebugPreferenceStorage ps,
  ) {
    final baseUrl = ps.baseUrl;

    final chopper = ChopperClient(
      client: kIsWeb ? null : http.IOClient(_proxyClient(ps)),
      baseUrl: baseUrl ?? env.apiUrl,
      interceptors: [
        headerInterceptor,
        HttpLoggingInterceptorUtf8(),
      ],
      authenticator: authInterceptor,
      converter: $JsonSerializableConverter(),
    );
    final client = Openapi.create(chopper);

    return client;
  }

  @dev
  @Named('guest')
  Openapi createGuestClient(
    Env env,
    DebugPreferenceStorage ps,
  ) {
    final baseUrl = ps.baseUrl;

    final chopper = ChopperClient(
        client: kIsWeb ? null : http.IOClient(_proxyClient(ps)),
        baseUrl: baseUrl ?? env.apiUrl,
        converter: $JsonSerializableConverter(),
        interceptors: [HttpLoggingInterceptorUtf8()]);
    final client = Openapi.create(chopper);

    return client;
  }

  HttpClient _proxyClient(DebugPreferenceStorage ps) {
    final proxyUrl = ps.proxy;

    final t = HttpClient();

    if (proxyUrl != null && proxyUrl.isNotEmpty) {
      t.findProxy = (url) => 'PROXY $proxyUrl';
    }

    return t;
  }
}
