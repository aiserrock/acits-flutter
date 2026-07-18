import 'package:dio/dio.dart';

import 'auth_interceptor.dart';
import 'header_interceptor.dart';
import 'ports.dart';
import 'seams.dart';

const _timeout = Duration(milliseconds: 30000);

/// Единственный сконфигурированный Dio — единый путь запросов. Generic-обёртки
/// (ApiClient.get/post/...) намеренно нет: дефолтный путь — сгенерированный
/// адаптер поверх этого Dio.
///
/// Фиксированный порядок интерцепторов:
///   1. auth   — ретрай на 401 (single-flight refresh)
///   2. header — Bearer + accept-language
///   3. connectivity — проверка сети (placeholder)
///   4. logging — dev-логирование (placeholder, без тела на upload)
Dio createDio({
  required TokenStore tokenStore,
  required TokenRefresher refresher,
  required SessionInvalidator sessionInvalidator,
  required LocaleProvider localeProvider,
}) {
  final dio = Dio(BaseOptions(connectTimeout: _timeout, receiveTimeout: _timeout, sendTimeout: _timeout));

  dio.interceptors.addAll([
    AuthInterceptor(dio: dio, tokenStore: tokenStore, refresher: refresher, sessionInvalidator: sessionInvalidator),
    HeaderInterceptor(tokenStore: tokenStore, localeProvider: localeProvider),
    ConnectivityInterceptor(),
    LoggingInterceptor(),
  ]);

  return dio;
}
