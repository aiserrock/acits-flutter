import 'package:flutter_test/flutter_test.dart';
import 'package:observability/observability.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

void main() {
  group('without a DSN', () {
    const config = SentryConfig(dsn: '', environment: 'prod', release: '1.0.0', dist: '1007');

    test('the config reports itself disabled', () {
      expect(config.isEnabled, isFalse);
      expect(
        const SentryConfig.fromEnvironment(environment: 'prod', release: '1.0.0', dist: '1007').isEnabled,
        isFalse,
      );
    });

    test('start does not initialise the SDK and every call stays a no-op', () async {
      final reporter = SentryErrorReporter(config);

      await reporter.start();
      await reporter.recordError(StateError('boom'), StackTrace.current, reason: 'r', fatal: true);
      reporter.breadcrumb('crumb');
      await reporter.setUser(userId: '7', shelterId: '50');
      await reporter.setCollectionEnabled(true);

      expect(Sentry.isEnabled, isFalse);
    });
  });

  group('scrubEvent', () {
    test('drops credentials, query string, cookies and personal user fields', () {
      final event = SentryEvent(
        message: SentryMessage('Login failed for ivan@example.org'),
        user: SentryUser(id: '7', email: 'ivan@example.org', username: 'ivan', ipAddress: '10.0.0.1'),
        request: SentryRequest(
          url: 'https://app.example/api/v1/token/?email=ivan@example.org',
          method: 'POST',
          queryString: 'email=ivan@example.org',
          cookies: 'sid=1',
          headers: {'Authorization': 'Bearer abc.def.ghi', 'accept-language': 'ru-RU'},
          data: {'password': 'hunter2'},
        ),
      );

      final scrubbed = SentryErrorReporter.scrubEvent(event, Hint());

      expect(scrubbed.message?.formatted, isNot(contains('example.org')));
      expect(scrubbed.user?.id, '7');
      expect(scrubbed.user?.email, isNull);
      expect(scrubbed.user?.username, isNull);
      expect(scrubbed.user?.ipAddress, isNull);
      final request = scrubbed.request!;
      expect(request.url, 'https://app.example/api/v1/token/');
      expect(request.queryString, isNull);
      expect(request.cookies, isNull);
      expect(request.data, isNull);
      expect(request.headers['Authorization'], Scrubber.redacted);
      expect(request.headers['accept-language'], 'ru-RU');
    });
  });

  group('scrubBreadcrumb', () {
    test('keeps method, status and path of an HTTP crumb and nothing else', () {
      final crumb = Breadcrumb(
        message: 'request by ivan@example.org',
        data: {
          'url': 'https://app.example/api/v1/animals/?search=ivan@example.org',
          'method': 'GET',
          'status_code': 200,
          'request_body': '{"password":"hunter2"}',
        },
      );

      final scrubbed = SentryErrorReporter.scrubBreadcrumb(crumb, Hint())!;

      expect(scrubbed.message, isNot(contains('example.org')));
      expect(scrubbed.data, {'method': 'GET', 'status_code': 200, 'url': 'https://app.example/api/v1/animals/'});
    });
  });
}
