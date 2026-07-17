import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart';

import 'ports.dart';

/// Single-flight координатор refresh: пачка параллельных вызовов дожидается
/// одного и того же Future, реальный refresh уходит ровно один раз. Замок
/// сбрасывается в finally, чтобы следующий реальный 401 мог начать новый.
class RefreshCoordinator {
  RefreshCoordinator(this._refresh);

  final Future<String?> Function() _refresh;
  Future<String?>? _inFlight;

  Future<String?> run() {
    return _inFlight ??= _guarded();
  }

  Future<String?> _guarded() async {
    try {
      return await _refresh();
    } finally {
      _inFlight = null;
    }
  }
}

/// На 401 запускает single-flight refresh и, при успехе, ретраит упавший запрос
/// с новым Bearer. При провале refresh — инвалидация сессии и проброс ошибки.
///
/// Обычный (не queued) Interceptor: пачка параллельных 401 приходит в onError
/// почти одновременно, поэтому `??=`-замок в координаторе реально шарит один
/// Future. QueuedInterceptorsWrapper здесь не подходит — он сериализует ошибки,
/// и замок успевал бы сброситься между ними → refresh на каждый запрос.
class AuthInterceptor extends Interceptor {
  AuthInterceptor({
    required Dio dio,
    required TokenStore tokenStore,
    required TokenRefresher refresher,
    required SessionInvalidator sessionInvalidator,
  }) : _dio = dio,
       _tokenStore = tokenStore,
       _sessionInvalidator = sessionInvalidator,
       _coordinator = RefreshCoordinator(refresher.refresh);

  final Dio _dio;
  final TokenStore _tokenStore;
  final SessionInvalidator _sessionInvalidator;
  final RefreshCoordinator _coordinator;

  static const _retriedFlag = 'acits_core.auth_retried';

  @override
  Future<void> onError(DioException err, ErrorInterceptorHandler handler) async {
    final options = err.response?.requestOptions ?? err.requestOptions;
    // Не зацикливаемся: ретраим запрос максимум один раз.
    if (err.response?.statusCode != HttpStatus.unauthorized || options.extra[_retriedFlag] == true) {
      return handler.next(err);
    }

    String? token;
    try {
      token = await _coordinator.run();
    } catch (_) {
      _sessionInvalidator.invalidate();
      return handler.next(err);
    }
    if (token == null) {
      _sessionInvalidator.invalidate();
      return handler.next(err);
    }

    options.extra[_retriedFlag] = true;
    options.headers['authorization'] = 'Bearer ${_tokenStore.accessToken ?? token}';
    try {
      final response = await _dio.fetch<dynamic>(options);
      return handler.resolve(response);
    } on DioException catch (e) {
      return handler.next(e);
    }
  }
}
