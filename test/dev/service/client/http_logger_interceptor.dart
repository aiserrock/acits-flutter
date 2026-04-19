import 'dart:async';
import 'dart:convert';

import 'package:chopper/chopper.dart';
import 'package:http/http.dart' as http;

class HttpLoggingInterceptorUtf8 implements Interceptor {
  @override
  FutureOr<Response<BodyType>> intercept<BodyType>(Chain<BodyType> chain) async {
    final request = chain.request;
    final base = await request.toBaseRequest();

    chopperLogger.info('\n-----------------> ${base.method} ${base.url}');

    final headersString = base.headers.entries.map((e) => '${e.key}: ${e.value}').join(';\n');
    chopperLogger.info(headersString);

    var bytes = '';
    if (base is http.Request) {
      final http.Request req = base as http.Request;
      final body = req.body;
      if (body.isNotEmpty) {
        String? decoded;
        try {
          decoded = utf8.decode(body.codeUnits);
        } catch (_) {
          decoded = body;
        }
        chopperLogger.info(decoded);
        bytes = ' (${req.bodyBytes.length}-byte body)';
      }
    }

    chopperLogger.info('--> END ${base.method}$bytes \n');

    final response = await chain.proceed(request);

    final baseResponseRequest = response.base.request;
    chopperLogger.info('\n<-- ${response.statusCode} ${baseResponseRequest?.url}');

    final respHeadersString = response.base.headers.entries
        .map((e) => '${e.key}: ${e.value}')
        .join(';\n');
    chopperLogger.info(respHeadersString);

    String? respBytes;
    if (response.base is http.Response) {
      final resp = response.base as http.Response;
      if (resp.body.isNotEmpty) {
        String? decoded;
        try {
          decoded = utf8.decode(resp.body.codeUnits);
        } catch (_) {
          decoded = resp.body;
        }
        chopperLogger.info(decoded);
        respBytes = ' (${response.bodyBytes.length}-byte body)';
      }
    }

    chopperLogger.info('\n------------------> END ${baseResponseRequest?.method}$respBytes ');

    return response;
  }
}
