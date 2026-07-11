import 'package:flutter/foundation.dart';

/// Обернуть URL в CORS-прокси для web-сборки.
///
/// Нужен только в WEB (в нативе возвращает исходную строку). Базовый URL
/// прокси задаётся compile-time переменной `CORS_PROXY_BASE`:
///
/// ```
/// flutter build web --dart-define=CORS_PROXY_BASE=https://proxy.cors.sh/
/// ```
///
/// Если переменная не задана — URL возвращается без изменений (прокси нет).
///
/// Прокси — временный обход: CORS-allowlist бэка пускает только
/// acits.ru/www.acits.ru, поэтому запросы с github.io браузер блокирует.
/// Правильный фикс — добавить origin PWA в allowlist на сервере
/// (см. docs/README: CORS для web-PWA).
abstract class UrlCorsProxy {
  static const _proxyBase = String.fromEnvironment('CORS_PROXY_BASE');

  /// Прокси задан в сборке (web с обходом CORS).
  static bool get isEnabled => kIsWeb && _proxyBase.isNotEmpty;

  static String? add(String? url) {
    if (!isEnabled || url == null) return url;
    // Не двоить префикс: сервер уже мог отдать «проксированный» URL.
    if (url.startsWith(_proxyBase)) return url;
    return '$_proxyBase$url';
  }

  /// Обернуть базовый URL API (chopper/dio) целиком: прокси-стиль
  /// `https://proxy/https://host` — chopper корректно доклеивает path
  /// (`_mergeUri` сохраняет base-path). На нативе/без прокси — как есть.
  static String wrapBase(String baseUrl) => add(baseUrl) ?? baseUrl;
}
