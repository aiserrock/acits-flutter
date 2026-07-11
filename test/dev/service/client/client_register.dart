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

// Прокси (Charles): глобальный HttpOverrides.global (main.dart) покрывает
// картинки/dio, а chopper-клиенты получают ЯВНЫЙ IOClient с findProxy — иначе
// на iOS/Android chopper не всегда подхватывает глобальный override для своих
// keep-alive соединений (симптом: API мимо прокси, картинки — через).
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
      client: _proxyClient(ps),
      baseUrl: Uri.parse(baseUrl ?? env.apiUrl),
      interceptors: [headerInterceptor, HttpLoggingInterceptorUtf8()],
      authenticator: authInterceptor,
      converter: $JsonSerializableConverter(),
    );
    final client = Openapi.create(client: chopper);

    return client;
  }

  @dev
  @Named('guest')
  Openapi createGuestClient(Env env, DebugPreferenceStorage ps) {
    final baseUrl = ps.baseUrl;

    final chopper = ChopperClient(
      client: _proxyClient(ps),
      baseUrl: Uri.parse(baseUrl ?? env.apiUrl),
      converter: $JsonSerializableConverter(),
      interceptors: [HttpLoggingInterceptorUtf8()],
    );
    final client = Openapi.create(client: chopper);

    return client;
  }

  /// http-клиент для chopper: при включённом прокси — IOClient с findProxy +
  /// доверием сертам (Charles); иначе дефолтный клиент. На web возвращаем null
  /// (там HttpClient недоступен, chopper использует BrowserClient).
  http.IOClient? _proxyClient(DebugPreferenceStorage ps) {
    if (kIsWeb) return null;
    final t = HttpClient();
    if (ps.proxyEnabled) {
      final proxyUrl = ps.proxy;
      if (proxyUrl != null && proxyUrl.isNotEmpty) {
        t.findProxy = (url) => 'PROXY $proxyUrl';
      }
      t.badCertificateCallback = (cert, host, port) => true;
    }
    return http.IOClient(t);
  }
}
