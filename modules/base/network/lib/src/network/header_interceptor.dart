import 'package:dio/dio.dart';

import 'ports.dart';

/// Добавляет Bearer-токен (только если он есть — иначе на сервер ушёл бы
/// буквальный `Bearer null`) и accept-language к каждому запросу.
class HeaderInterceptor extends Interceptor {
  HeaderInterceptor({required this.tokenStore, required this.localeProvider});

  final TokenStore tokenStore;
  final LocaleProvider localeProvider;

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    final access = tokenStore.accessToken;
    if (access != null) {
      options.headers['authorization'] = 'Bearer $access';
    }
    options.headers['accept-language'] = localeProvider.locale;
    handler.next(options);
  }
}
