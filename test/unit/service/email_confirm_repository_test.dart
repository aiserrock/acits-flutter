import 'package:acits_flutter/domain/exception.dart';
import 'package:acits_flutter/service/auth/email_confirm_repository.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class _MockDio extends Mock implements Dio {}

void main() {
  late _MockDio dio;
  late EmailConfirmRepository repository;
  late Interceptors interceptors;

  setUpAll(() {
    registerFallbackValue(Uri.parse('https://dev.acits.ru/'));
  });

  setUp(() {
    dio = _MockDio();
    interceptors = Interceptors();
    // options getter/setter — репозиторий делает copyWith и присваивает обратно.
    when(() => dio.options).thenReturn(BaseOptions());
    when(() => dio.interceptors).thenReturn(interceptors);
    // getUri успешно завершается для доверенной ссылки.
    when(
      () => dio.getUri<dynamic>(any()),
    ).thenAnswer((_) async => Response<dynamic>(requestOptions: RequestOptions(path: '')));
    repository = EmailConfirmRepository(dio);
  });

  group('confirmEmail — SSRF guard via _isTrustedConfirmLink', () {
    const trustedLink = 'https://dev.acits.ru/api/v1/users/verify-email/abc123?token=xyz';

    test('trusted https .acits.ru link with verify-email path calls getUri once', () async {
      await repository.confirmEmail(trustedLink);

      verify(() => dio.getUri<dynamic>(any())).called(1);
    });

    test('trusted apex host acits.ru is allowed', () async {
      await repository.confirmEmail('https://acits.ru/api/v1/users/verify-email/token');

      verify(() => dio.getUri<dynamic>(any())).called(1);
    });

    test('untrusted host throws and never calls dio', () async {
      await expectLater(
        repository.confirmEmail('https://evil.test/api/v1/users/verify-email/token'),
        throwsA(isA<EmailConfirmException>()),
      );

      verifyNever(() => dio.getUri<dynamic>(any()));
    });

    test('host that only suffix-matches loosely is rejected (e.g. acits.ru.evil.com)', () async {
      await expectLater(
        repository.confirmEmail('https://acits.ru.evil.com/api/v1/users/verify-email/token'),
        throwsA(isA<EmailConfirmException>()),
      );

      verifyNever(() => dio.getUri<dynamic>(any()));
    });

    test('http scheme throws and never calls dio', () async {
      await expectLater(
        repository.confirmEmail('http://dev.acits.ru/api/v1/users/verify-email/token'),
        throwsA(isA<EmailConfirmException>()),
      );

      verifyNever(() => dio.getUri<dynamic>(any()));
    });

    test('missing verify-email path segment throws and never calls dio', () async {
      await expectLater(
        repository.confirmEmail('https://dev.acits.ru/api/v1/something-else/'),
        throwsA(isA<EmailConfirmException>()),
      );

      verifyNever(() => dio.getUri<dynamic>(any()));
    });

    test('link without authority (relative) throws and never calls dio', () async {
      await expectLater(
        repository.confirmEmail('/api/v1/users/verify-email/token'),
        throwsA(isA<EmailConfirmException>()),
      );

      verifyNever(() => dio.getUri<dynamic>(any()));
    });

    test('empty string throws and never calls dio', () async {
      await expectLater(repository.confirmEmail(''), throwsA(isA<EmailConfirmException>()));

      verifyNever(() => dio.getUri<dynamic>(any()));
    });
  });
}
