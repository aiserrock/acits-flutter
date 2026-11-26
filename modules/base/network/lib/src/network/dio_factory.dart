import 'package:dio/dio.dart';

import 'auth_interceptor.dart';
import 'client_info_interceptor.dart';
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
///   3. client info — версия, сборка и платформа клиента
///   4. connectivity — проверка сети (placeholder)
///   5. logging — dev-логирование (placeholder, без тела на upload)
Dio createDio({
  required TokenStore tokenStore,
  required TokenRefresher refresher,
  required SessionInvalidator sessionInvalidator,
  required LocaleProvider localeProvider,
  required ClientInfoProvider clientInfo,
}) {
  final dio = Dio(BaseOptions(connectTimeout: _timeout, receiveTimeout: _timeout, sendTimeout: _timeout));

  dio.interceptors.addAll([
    AuthInterceptor(dio: dio, tokenStore: tokenStore, refresher: refresher, sessionInvalidator: sessionInvalidator),
    HeaderInterceptor(tokenStore: tokenStore, localeProvider: localeProvider),
    ClientInfoInterceptor(clientInfo),
    ConnectivityInterceptor(),
    LoggingInterceptor(),
  ]);

  return dio;
}

/// Dio без авторизации (логин, регистрация, список приютов): те же таймауты и
/// заголовки клиента, но без Bearer и без refresh.
Dio createGuestDio({required String baseUrl, required ClientInfoProvider clientInfo}) {
  final dio = Dio(
    BaseOptions(baseUrl: baseUrl, connectTimeout: _timeout, receiveTimeout: _timeout, sendTimeout: _timeout),
  );
  dio.interceptors.add(ClientInfoInterceptor(clientInfo));
  return dio;
}
