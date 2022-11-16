import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:chopper/chopper.dart';

class HttpLoggingInterceptorUtf8 extends HttpLoggingInterceptor {
  @override
  FutureOr<Request> onRequest(Request request) async {
    final base = await request.toBaseRequest();
    chopperLogger.info('\n-----------------> ${base.method} ${base.url}');

    final headersString = base.headers.entries.map((e) => '${e.key}: ${e.value}').join(';\n');
    chopperLogger.info(headersString);

    var bytes = '';
    if (base is http.Request) {
      final body = base.body;
      if (body.isNotEmpty) {
        String? decoded;
        try {
          decoded = decoded = utf8.decode(body.codeUnits);
        } catch (_) {
          decoded = body;
        }
        chopperLogger.info(decoded);
        bytes = ' (${base.bodyBytes.length}-byte body)';
      }
    }

    chopperLogger.info('--> END ${base.method}$bytes \n');
    return request;
  }

  @override
  FutureOr<Response> onResponse(Response response) {
    final base = response.base.request;
    chopperLogger.info('\n<-- ${response.statusCode} ${base!.url}');

    final headersString =
        response.base.headers.entries.map((e) => '${e.key}: ${e.value}').join(';\n');
    chopperLogger.info(headersString);

    String? bytes;
    if (response.base is http.Response) {
      final resp = response.base as http.Response;
      if (resp.body.isNotEmpty) {
        String? decoded;
        try {
          decoded = decoded = utf8.decode(resp.body.codeUnits);
        } catch (_) {
          decoded = resp.body;
        }
        chopperLogger.info(decoded);
        bytes = ' (${response.bodyBytes.length}-byte body)';
      }
    }

    chopperLogger.info('\n------------------> END ${base.method}$bytes ');
    return response;
  }
}
