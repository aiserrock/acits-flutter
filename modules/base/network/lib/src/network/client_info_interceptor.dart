import 'package:dio/dio.dart';

import 'ports.dart';

/// Marks every request with the client's version, build and platform.
///
/// Installed on the guest client too: login and registration are where an
/// outdated client has to be recognised first.
class ClientInfoInterceptor extends Interceptor {
  ClientInfoInterceptor(this._info);

  static const versionHeader = 'x-app-version';
  static const buildHeader = 'x-app-build';
  static const platformHeader = 'x-app-platform';

  final ClientInfoProvider _info;

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    // Never send an empty value: a header that is present must be meaningful.
    _set(options, versionHeader, _info.version);
    _set(options, buildHeader, _info.buildNumber);
    _set(options, platformHeader, _info.platform);
    handler.next(options);
  }

  void _set(RequestOptions options, String name, String value) {
    if (value.isNotEmpty) options.headers[name] = value;
  }
}
