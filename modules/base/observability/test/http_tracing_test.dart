import 'dart:convert';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:observability/observability.dart';

class _JsonAdapter implements HttpClientAdapter {
  final requests = <RequestOptions>[];

  @override
  Future<ResponseBody> fetch(
    RequestOptions options,
    Stream<Uint8List>? requestStream,
    Future<void>? cancelFuture,
  ) async {
    requests.add(options);
    return ResponseBody.fromString(
      jsonEncode({'ok': true}),
      200,
      headers: {
        Headers.contentTypeHeader: [Headers.jsonContentType],
      },
    );
  }

  @override
  void close({bool force = false}) {}
}

void main() {
  test('with tracing and no DSN, requests go through the same adapter and interceptors', () async {
    final adapter = _JsonAdapter();
    final dio = Dio(BaseOptions(baseUrl: 'https://api.example.test'))
      ..httpClientAdapter = adapter
      ..interceptors.add(InterceptorsWrapper(onRequest: (o, h) => h.next(o..headers['x-test'] = '1')));
    final interceptorsBefore = dio.interceptors.length;

    addHttpTracing(dio);
    final response = await dio.get<Map<String, dynamic>>('/ping');

    expect(response.data, {'ok': true});
    expect(adapter.requests.single.path, '/ping');
    expect(adapter.requests.single.headers['x-test'], '1');
    // Failed-request capture is off: no interceptor is inserted, so a 5xx is
    // not reported a second time next to the repository's own report.
    expect(dio.interceptors, hasLength(interceptorsBefore));
  });
}
