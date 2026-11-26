import 'dart:io';

import 'package:core/data.dart';
import 'package:dio/dio.dart';
import 'package:util/util.dart';
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

  /// `Err(EmailLinkRejected)` — ссылка недоверенная или сервер её не принял.
  Future<Result<Failure, void>> confirmEmail(String confirmLink) async {
    Log.debug('Confirm email');
    final uri = Uri.tryParse(confirmLink);
    if (!_isTrustedConfirmLink(uri)) {
      Log.warning('Untrusted confirm link rejected: ${uri?.host ?? '<unparseable>'}');
      return const Err(EmailLinkRejected());
    }

    // Не мутируем общий Dio: следование редиректам отключаем через Options
    // конкретного запроса, а интерцептор регистрируем один раз, чтобы дубликаты
    // не накапливались при повторных вызовах.
    if (!_client.interceptors.any((i) => i is _EmailConfirmInterceptor)) {
      _client.interceptors.add(_EmailConfirmInterceptor());
    }

    final result = await guard(
      () => _client.getUri<dynamic>(uri!, options: Options(followRedirects: false)),
      onError: (e, s) => Log.warning('Confirm email failed', e, s),
    );
    return result.fold((failure) => Err(failure), (response) {
      if (response.extra[_rejectedFlag] == true) return const Err(EmailLinkRejected());
      Log.info('Email confirmed: ${uri!.host}');
      return const Ok(null);
    });
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

const _rejectedFlag = 'email_confirm.rejected';

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
      // Сервер ответил редиректом «ссылка недействительна» — это ответ, а не сбой сети.
      return handler.resolve(
        Response(statusCode: 200, requestOptions: response.requestOptions, extra: {_rejectedFlag: true}),
      );
    }
    super.onError(err, handler);
  }
}
