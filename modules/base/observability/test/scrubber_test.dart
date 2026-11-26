import 'package:flutter_test/flutter_test.dart';
import 'package:observability/observability.dart';

void main() {
  group('Scrubber.text', () {
    test('removes e-mail addresses', () {
      expect(Scrubber.text('Login attempt: username=ivan.petrov@example.org'), isNot(contains('example.org')));
    });

    test('removes bearer tokens and bare JWTs', () {
      const jwt = 'eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiIxMjM0NTY3ODkwIn0.SflKxwRJSMeKKF2QT4fwpMeJf36POk6yJV';
      expect(Scrubber.text('Authorization: Bearer $jwt'), isNot(contains('eyJ')));
      expect(Scrubber.text('token was $jwt here'), isNot(contains('eyJ')));
    });

    test('removes credential values but keeps the key', () {
      final out = Scrubber.text('{"password": "hunter2", "re_password":"hunter2", "refresh": "abc.def"}');
      expect(out, isNot(contains('hunter2')));
      expect(out, isNot(contains('abc.def')));
      expect(out, contains('password'));
    });

    test('removes phone numbers', () {
      expect(Scrubber.text('phone +7 (912) 345-67-89 saved'), isNot(contains('345')));
    });

    test('leaves ordinary diagnostics readable', () {
      const message = 'Animal attributes loaded: count=12 shelterId=50';
      expect(Scrubber.text(message), message);
    });
  });

  group('Scrubber.headers', () {
    test('redacts credential headers whatever their case', () {
      final out = Scrubber.headers({'Authorization': 'Bearer abc', 'cookie': 'sid=1', 'accept-language': 'ru-RU'});
      expect(out['Authorization'], Scrubber.redacted);
      expect(out['cookie'], Scrubber.redacted);
      expect(out['accept-language'], 'ru-RU');
    });
  });

  group('Scrubber.url', () {
    test('drops the query string', () {
      expect(
        Scrubber.url('https://app.example/api/v1/users/verify-email/?token=secret&email=a@b.c'),
        'https://app.example/api/v1/users/verify-email/',
      );
    });
  });
}
