import 'dart:io';

class SslHttpOverrides extends HttpOverrides {
  SslHttpOverrides({this.withTrustedRoots = false, this.certFilePathes, this.certBytes})
    : assert(certFilePathes != null || certBytes != null);

  final bool withTrustedRoots;
  final List<String>? certFilePathes;
  final List<List<int>>? certBytes;

  @override
  HttpClient createHttpClient(context) {
    final pinnedContext = SecurityContext(withTrustedRoots: withTrustedRoots);

    certFilePathes?.forEach(pinnedContext.setTrustedCertificates);

    certBytes?.forEach(pinnedContext.setTrustedCertificatesBytes);

    return super.createHttpClient(pinnedContext);
  }
}
