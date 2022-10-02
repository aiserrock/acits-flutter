import 'dart:io';

import 'package:acits_flutter/domain/exception.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

@injectable
class EmailConfirmRepository {
  EmailConfirmRepository(this._client);

  final Dio _client;

  Future<void> confirmEmail(String email) async {
    _client.options = _client.options.copyWith(followRedirects: false);
    _client.interceptors.add(_EmailConfirmInterceptor());

    await Future.delayed(Duration(seconds: 3));

    await _client.get(email);
  }
}

class _EmailConfirmInterceptor extends Interceptor {
  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    final response = err.response;
    if (response != null &&
        response.statusCode == HttpStatus.movedTemporarily &&
        (response.headers.value('location')?.contains('status=email_verified') ?? false)) {
      return handler.resolve(
        Response(
          statusCode: 200,
          requestOptions: response.requestOptions,
        ),
      );
    }
    if (response != null &&
        response.statusCode == HttpStatus.movedTemporarily &&
        (response.headers.value('location')?.contains('status=invalid_link') ?? false)) {
      return handler.reject(
          DioError(requestOptions: response.requestOptions, error: EmailConfirmException()));
    }
    super.onError(err, handler);
  }
}
