import 'dart:async';
import 'dart:convert';

import 'package:chopper/chopper.dart';
import 'package:http/http.dart' as http;
import 'package:talker_flutter/talker_flutter.dart';

import 'package:acits_flutter/di/di_container.dart';

/// Логирует HTTP-запросы/ответы chopper в Talker (виден в debug-меню → «Логи»).
///
/// Только dev: в prod-клиент такой интерцептор не ставится (иначе заголовки, в
/// т.ч. `Authorization: Bearer`, и тела попадут в системный лог устройства).
/// UTF-8-декод тела сохранён — иначе кириллица в логах ломается.
class HttpLoggingInterceptorUtf8 implements Interceptor {
  @override
  FutureOr<Response<BodyType>> intercept<BodyType>(Chain<BodyType> chain) async {
    final talker = getIt<Talker>();
    final request = chain.request;
    final base = await request.toBaseRequest();

    final reqLog = StringBuffer('--> ${base.method} ${base.url}');
    if (base.headers.isNotEmpty) {
      reqLog.write('\n${_formatHeaders(base.headers)}');
    }
    if (base is http.Request) {
      final body = (base as http.Request).body;
      if (body.isNotEmpty) reqLog.write('\n\n${_decode(body)}');
    }
    talker.info(reqLog.toString());

    final response = await chain.proceed(request);

    final url = response.base.request?.url;
    final respLog = StringBuffer('<-- ${response.statusCode} $url');
    if (response.base.headers.isNotEmpty) {
      respLog.write('\n${_formatHeaders(response.base.headers)}');
    }
    if (response.base is http.Response) {
      final body = (response.base as http.Response).body;
      if (body.isNotEmpty) respLog.write('\n\n${_decode(body)}');
    }
    // Ошибочные ответы (4xx/5xx) — уровень error, чтобы бросались в глаза.
    if (response.statusCode >= 400) {
      talker.error(respLog.toString());
    } else {
      talker.info(respLog.toString());
    }

    return response;
  }

  String _formatHeaders(Map<String, String> headers) => headers.entries.map((e) => '${e.key}: ${e.value}').join('\n');

  /// UTF-8-декод тела; при неудаче возвращает исходную строку.
  String _decode(String body) {
    try {
      return utf8.decode(body.codeUnits);
    } catch (_) {
      return body;
    }
  }
}
