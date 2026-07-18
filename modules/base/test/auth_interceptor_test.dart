import 'package:base/base.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class _MockAdapter extends Mock implements HttpClientAdapter {}

class _MutableTokenStore implements TokenStore {
  String? token = 'old';
  @override
  String? get accessToken => token;
}

class _CountingRefresher implements TokenRefresher {
  _CountingRefresher(this._store);

  final _MutableTokenStore _store;
  int calls = 0;

  @override
  Future<String?> refresh() async {
    calls++;
    await Future<void>.delayed(const Duration(milliseconds: 20));
    _store.token = 'fresh';
    return 'fresh';
  }
}

class _RecordingInvalidator implements SessionInvalidator {
  int calls = 0;
  @override
  void invalidate() => calls++;
}

class _FixedLocale implements LocaleProvider {
  @override
  String get locale => 'ru';
}

ResponseBody _resBody(int status) => ResponseBody.fromString(
  '{}',
  status,
  headers: {
    Headers.contentTypeHeader: [Headers.jsonContentType],
  },
);

void main() {
  setUpAll(() {
    registerFallbackValue(RequestOptions(path: '/'));
  });

  group('RefreshCoordinator single-flight', () {
    test('concurrent calls trigger the underlying refresh exactly once', () async {
      var calls = 0;
      final coordinator = RefreshCoordinator(() async {
        calls++;
        await Future<void>.delayed(const Duration(milliseconds: 20));
        return 'fresh';
      });

      final results = await Future.wait([coordinator.run(), coordinator.run(), coordinator.run(), coordinator.run()]);

      expect(calls, 1);
      expect(results, everyElement('fresh'));
    });

    test('lock resets so a later call refreshes again', () async {
      var calls = 0;
      final coordinator = RefreshCoordinator(() async {
        calls++;
        return 'fresh';
      });

      await coordinator.run();
      await coordinator.run();

      expect(calls, 2);
    });
  });

  group('AuthInterceptor', () {
    test('N concurrent 401s refresh exactly once and all retry with new token', () async {
      final adapter = _MockAdapter();
      final store = _MutableTokenStore();
      final refresher = _CountingRefresher(store);
      final invalidator = _RecordingInvalidator();

      final dio = Dio(BaseOptions(baseUrl: 'https://example.test'));
      dio.httpClientAdapter = adapter;
      dio.interceptors.add(
        AuthInterceptor(dio: dio, tokenStore: store, refresher: refresher, sessionInvalidator: invalidator),
      );
      dio.interceptors.add(HeaderInterceptor(tokenStore: store, localeProvider: _FixedLocale()));

      final retriedAuthHeaders = <String?>[];

      when(() => adapter.fetch(any(), any(), any())).thenAnswer((invocation) async {
        final options = invocation.positionalArguments[0] as RequestOptions;
        final auth = options.headers['authorization'] as String?;
        // Первый заход отдаёт 401; после ретрая (токен уже fresh) — 200.
        if (auth == 'Bearer fresh') {
          retriedAuthHeaders.add(auth);
          return _resBody(200);
        }
        return _resBody(401);
      });

      final responses = await Future.wait([
        dio.get<dynamic>('/a'),
        dio.get<dynamic>('/b'),
        dio.get<dynamic>('/c'),
        dio.get<dynamic>('/d'),
        dio.get<dynamic>('/e'),
      ]);

      expect(refresher.calls, 1);
      expect(invalidator.calls, 0);
      expect(responses.map((r) => r.statusCode), everyElement(200));
      expect(retriedAuthHeaders, everyElement('Bearer fresh'));
      expect(retriedAuthHeaders.length, 5);
    });

    test('refresh returning null invalidates the session and propagates 401', () async {
      final adapter = _MockAdapter();
      final store = _MutableTokenStore();
      final invalidator = _RecordingInvalidator();

      final dio = Dio(BaseOptions(baseUrl: 'https://example.test'));
      dio.httpClientAdapter = adapter;
      dio.interceptors.add(
        AuthInterceptor(dio: dio, tokenStore: store, refresher: _NullRefresher(), sessionInvalidator: invalidator),
      );

      when(() => adapter.fetch(any(), any(), any())).thenAnswer((_) async => _resBody(401));

      await expectLater(
        dio.get<dynamic>('/a'),
        throwsA(isA<DioException>().having((e) => e.response?.statusCode, 'status', 401)),
      );
      expect(invalidator.calls, 1);
    });

    test('non-401 errors pass through without refresh', () async {
      final adapter = _MockAdapter();
      final store = _MutableTokenStore();
      final refresher = _CountingRefresher(store);
      final invalidator = _RecordingInvalidator();

      final dio = Dio(BaseOptions(baseUrl: 'https://example.test'));
      dio.httpClientAdapter = adapter;
      dio.interceptors.add(
        AuthInterceptor(dio: dio, tokenStore: store, refresher: refresher, sessionInvalidator: invalidator),
      );

      when(() => adapter.fetch(any(), any(), any())).thenAnswer((_) async => _resBody(500));

      await expectLater(dio.get<dynamic>('/a'), throwsA(isA<DioException>()));
      expect(refresher.calls, 0);
      expect(invalidator.calls, 0);
    });
  });
}

class _NullRefresher implements TokenRefresher {
  @override
  Future<String?> refresh() async => null;
}
