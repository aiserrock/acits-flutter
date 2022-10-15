import 'package:flutter/foundation.dart';

/// Изменить URL для проксирования с подменой CORS, нужен только в WEB,
/// в нативе возвращает ту же строку без прокси
abstract class UrlCorsProxy {
  static String? add(String? url) {
    return (kIsWeb && url != null) ? 'https://andx2.tplinkdns.com/cors/$url' : url;
  }
}
