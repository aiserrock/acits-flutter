import 'dart:io';

import 'package:acits_flutter/domain/exception.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

@injectable
class EmailConfirmRepository {
  EmailConfirmRepository(this._client);

  final Dio _client;

  /// Разрешённый суффикс хоста для ссылок подтверждения e-mail.
  /// Ссылка приходит из внешнего deep-link, поэтому перед выполнением
  /// сетевого запроса проверяем, что она ведёт на доверенный домен и путь —
  /// иначе устройство можно заставить сделать произвольный GET (SSRF).
  static const _allowedHostSuffix = '.acits.ru';
  static const _requiredPathSegment = '/api/v1/users/verify-email/';

  Future<void> confirmEmail(String confirmLink) async {
    final uri = Uri.tryParse(confirmLink);
    if (!_isTrustedConfirmLink(uri)) {
      throw EmailConfirmException();
    }

    // Не мутируем общий Dio: следование редиректам отключаем через Options
    // конкретного запроса, а интерцептор регистрируем один раз, чтобы дубликаты
    // не накапливались при повторных вызовах.
    if (!_client.interceptors.any((i) => i is _EmailConfirmInterceptor)) {
      _client.interceptors.add(_EmailConfirmInterceptor());
    }

    await _client.getUri(uri!, options: Options(followRedirects: false));
  }

  /// Ссылка должна быть HTTPS, вести на `*.acits.ru` (или сам `acits.ru`) и
  /// содержать путь подтверждения e-mail.
  bool _isTrustedConfirmLink(Uri? uri) {
    if (uri == null || uri.scheme != 'https' || !uri.hasAuthority) return false;
    final host = uri.host.toLowerCase();
    final hostOk = host == 'acits.ru' || host.endsWith(_allowedHostSuffix);
    return hostOk && uri.path.contains(_requiredPathSegment);
  }
}

class _EmailConfirmInterceptor extends Interceptor {
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    final response = err.response;
    if (response != null &&
        response.statusCode == HttpStatus.movedTemporarily &&
        (response.headers.value('location')?.contains('status=email_verified') ?? false)) {
      return handler.resolve(Response(statusCode: 200, requestOptions: response.requestOptions));
    }
    if (response != null &&
        response.statusCode == HttpStatus.movedTemporarily &&
        (response.headers.value('location')?.contains('status=invalid_link') ?? false)) {
      return handler.reject(
        DioException(requestOptions: response.requestOptions, error: EmailConfirmException()),
      );
    }
    super.onError(err, handler);
  }
}
