import 'package:flutter/foundation.dart';

/// Обернуть URL в CORS-прокси для web-сборки.
///
/// Нужен только в WEB (в нативе возвращает исходную строку). Базовый URL
/// прокси задаётся compile-time переменной `CORS_PROXY_BASE`:
///
/// ```
/// flutter build web --dart-define=CORS_PROXY_BASE=https://your-proxy.example/cors/
/// ```
///
/// Если переменная не задана — URL возвращается без изменений (прокси нет).
abstract class UrlCorsProxy {
  static const _proxyBase = String.fromEnvironment('CORS_PROXY_BASE');

  static String? add(String? url) {
    if (!kIsWeb || url == null || _proxyBase.isEmpty) return url;
    return '$_proxyBase$url';
  }
}
