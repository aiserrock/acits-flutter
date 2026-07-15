import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter_alice/alice.dart';
import 'package:http/io_client.dart' as http;
import 'package:chopper/chopper.dart';
import 'package:injectable/injectable.dart';

import 'package:acits_flutter/export.dart';
import 'package:acits_flutter/domain/env.dart';
import 'package:acits_flutter/service/client/auth_interceptor.dart';
import 'package:acits_flutter/service/client/header_inteceptor.dart';

import '../../di/di_container.dart';
import '../shared_pref/debug_preference_storage.dart';
import 'alice_chopper_interceptor.dart';
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
      // wrapBase: на web с CORS_PROXY_BASE базовый URL оборачивается в
      // CORS-прокси (бэкенд пускает только Origin acits.ru); chopper корректно
      // доклеивает path к прокси-стилю https://proxy/https://host.
      baseUrl: Uri.parse(UrlCorsProxy.wrapBase(baseUrl ?? env.apiUrl)),
      interceptors: [headerInterceptor, HttpLoggingInterceptorUtf8(), AliceChopperInterceptor(getIt<Alice>())],
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
      baseUrl: Uri.parse(UrlCorsProxy.wrapBase(baseUrl ?? env.apiUrl)),
      converter: $JsonSerializableConverter(),
      interceptors: [HttpLoggingInterceptorUtf8(), AliceChopperInterceptor(getIt<Alice>())],
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
