import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:network/network.dart';

class _MockAdapter extends Mock implements HttpClientAdapter {}

class _Info implements ClientInfoProvider {
  const _Info({this.version = '1.2.0', this.buildNumber = '1007', this.platform = 'android'});

  @override
  final String version;
  @override
  final String buildNumber;
  @override
  final String platform;
}

class _NoToken implements TokenStore {
  @override
  String? get accessToken => null;
}

class _Refresher implements TokenRefresher {
  @override
  Future<String?> refresh() async => null;
}

class _Invalidator implements SessionInvalidator {
  @override
  void invalidate() {}
}

class _Locale implements LocaleProvider {
  @override
  String get locale => 'ru-RU';
}

void main() {
  late _MockAdapter adapter;

  setUpAll(() => registerFallbackValue(RequestOptions(path: '/')));

  setUp(() {
    adapter = _MockAdapter();
    when(() => adapter.fetch(any(), any(), any())).thenAnswer(
      (_) async => ResponseBody.fromString(
        '{}',
        200,
        headers: {
          Headers.contentTypeHeader: [Headers.jsonContentType],
        },
      ),
    );
  });

  Map<String, dynamic> sentHeaders() =>
      (verify(() => adapter.fetch(captureAny(), any(), any())).captured.single as RequestOptions).headers;

  test('the authorised client sends version, build and platform with every request', () async {
    final dio = createDio(
      tokenStore: _NoToken(),
      refresher: _Refresher(),
      sessionInvalidator: _Invalidator(),
      localeProvider: _Locale(),
      clientInfo: const _Info(),
    )..httpClientAdapter = adapter;
    dio.options.baseUrl = 'https://example.test';

    await dio.get<dynamic>('/animals/');

    final headers = sentHeaders();
    expect(headers[ClientInfoInterceptor.versionHeader], '1.2.0');
    expect(headers[ClientInfoInterceptor.buildHeader], '1007');
    expect(headers[ClientInfoInterceptor.platformHeader], 'android');
    expect(headers['accept-language'], 'ru-RU');
  });

  test('the guest client sends the same headers and no authorization', () async {
    final dio = createGuestDio(
      baseUrl: 'https://example.test',
      clientInfo: const _Info(platform: 'ios'),
    )..httpClientAdapter = adapter;

    await dio.post<dynamic>('/token/');

    final headers = sentHeaders();
    expect(headers[ClientInfoInterceptor.versionHeader], '1.2.0');
    expect(headers[ClientInfoInterceptor.platformHeader], 'ios');
    expect(headers.containsKey('authorization'), isFalse);
  });

  test('an unknown version is left out instead of being sent empty', () async {
    final dio = createGuestDio(
      baseUrl: 'https://example.test',
      clientInfo: const _Info(version: '', buildNumber: ''),
    )..httpClientAdapter = adapter;

    await dio.get<dynamic>('/shelters/');

    final headers = sentHeaders();
    expect(headers.containsKey(ClientInfoInterceptor.versionHeader), isFalse);
    expect(headers.containsKey(ClientInfoInterceptor.buildHeader), isFalse);
    expect(headers[ClientInfoInterceptor.platformHeader], 'android');
  });

  test('a provider with no values adds no custom header at all (web: avoids a CORS preflight)', () async {
    final dio = createGuestDio(
      baseUrl: 'https://example.test',
      clientInfo: const _Info(version: '', buildNumber: '', platform: ''),
    )..httpClientAdapter = adapter;

    await dio.get<dynamic>('/shelters/');

    expect(sentHeaders().keys.where((name) => name.startsWith('x-app-')), isEmpty);
  });
}
