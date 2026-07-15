import 'dart:async';
import 'dart:convert';

import 'package:chopper/chopper.dart';
import 'package:flutter_alice/alice.dart';
import 'package:flutter_alice/model/alice_http_call.dart';
import 'package:flutter_alice/model/alice_http_error.dart';
import 'package:flutter_alice/model/alice_http_request.dart';
import 'package:flutter_alice/model/alice_http_response.dart';
import 'package:http/http.dart' as http;

/// Прокидывает HTTP-вызовы chopper в Alice-инспектор (dev debug-меню → «HTTP»).
///
/// `flutter_alice` из коробки поддерживает Dio, но не chopper (встроенный
/// chopper-интерцептор в пакете закомментирован), поэтому `AliceHttpCall`
/// формируется вручную и отдаётся через публичный [Alice.addHttpCall].
///
/// Только dev: в prod chopper-клиент этот интерцептор не получает (заголовки с
/// `Authorization` и тела не должны утекать). Тело декодируется UTF-8 (кириллица).
class AliceChopperInterceptor implements Interceptor {
  AliceChopperInterceptor(this._alice);

  final Alice _alice;

  @override
  FutureOr<Response<BodyType>> intercept<BodyType>(Chain<BodyType> chain) async {
    final request = chain.request;
    final base = await request.toBaseRequest();

    final call = AliceHttpCall(base.hashCode);
    call.client = 'Chopper';
    call.method = base.method;
    call.uri = base.url.toString();
    call.endpoint = base.url.path.isEmpty ? '/' : base.url.path;
    call.server = base.url.host;
    call.secure = base.url.scheme == 'https';

    final aliceRequest = AliceHttpRequest();
    aliceRequest.headers = Map<String, dynamic>.from(base.headers);
    aliceRequest.contentType = base.headers['content-type'] ?? base.headers['Content-Type'];
    aliceRequest.queryParameters = base.url.queryParameters;
    aliceRequest.time = DateTime.now();
    if (base is http.Request) {
      final body = (base as http.Request).body;
      aliceRequest.body = _decode(body);
      aliceRequest.size = body.length;
    }
    call.request = aliceRequest;
    call.response = AliceHttpResponse();

    try {
      final response = await chain.proceed(request);

      final aliceResponse = AliceHttpResponse();
      aliceResponse.status = response.statusCode;
      aliceResponse.headers = response.base.headers;
      aliceResponse.time = DateTime.now();
      if (response.base is http.Response) {
        final body = (response.base as http.Response).body;
        aliceResponse.body = _decode(body);
        aliceResponse.size = body.length;
      }
      call.response = aliceResponse;
      call.duration = aliceResponse.time.millisecondsSinceEpoch - aliceRequest.time.millisecondsSinceEpoch;
      call.loading = false;
      _alice.addHttpCall(call);

      return response;
    } catch (e, s) {
      final aliceError = AliceHttpError()
        ..error = e
        ..stackTrace = s;
      call.error = aliceError;
      call.loading = false;
      _alice.addHttpCall(call);
      rethrow;
    }
  }

  /// UTF-8-декод тела; при неудаче возвращает исходную строку.
  String _decode(String body) {
    try {
      return utf8.decode(body.codeUnits);
    } catch (_) {
      return body;
    }
  }
}
