import 'dart:io';

/// Глобальный [HttpOverrides], направляющий ВЕСЬ HTTP-трафик приложения через
/// прокси (Charles/mitmproxy) и доверяющий любому TLS-сертификату.
///
/// Ставится в `HttpOverrides.global` при СТАРТЕ приложения (dev-сборка), потому
/// что per-client `HttpClient` покрывает только chopper-запросы, а картинки
/// (`Image.network`), dio и прочее создают свои клиенты. Глобальный override
/// перехватывает их все. Именно поэтому смена прокси требует полного
/// перезапуска процесса.
class ProxyHttpOverrides extends HttpOverrides {
  ProxyHttpOverrides(this.proxy);

  /// Адрес прокси в формате `host:port` (напр. `192.168.2.131:8888`).
  final String proxy;

  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..findProxy = ((_) => 'PROXY $proxy')
      // Charles перехватывает HTTPS своим сертификатом — доверяем любому серту,
      // иначе запросы падают на проверке TLS. Только dev-сборка.
      ..badCertificateCallback = ((X509Certificate cert, String host, int port) => true);
  }
}
