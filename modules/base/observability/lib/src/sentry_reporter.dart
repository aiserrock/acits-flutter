import 'package:sentry_flutter/sentry_flutter.dart';

import 'error_reporter.dart';
import 'scrubber.dart';

/// Build-time Sentry configuration. With an empty [dsn] Sentry is never
/// initialised and nothing is sent.
final class SentryConfig {
  const SentryConfig({required this.dsn, required this.environment, required this.release, required this.dist});

  /// Reads `--dart-define=SENTRY_DSN=...`; empty when the define is absent.
  const SentryConfig.fromEnvironment({required this.environment, required this.release, required this.dist})
    : dsn = const String.fromEnvironment('SENTRY_DSN');

  final String dsn;

  /// Flavor name: `prod` or `dev`.
  final String environment;

  /// Marketing version, e.g. `1.2.0`.
  final String release;

  /// Build number shared by all stores.
  final String dist;

  bool get isEnabled => dsn.isNotEmpty;
}

/// Reports to Sentry. Every call is a no-op until [SentryErrorReporter.start]
/// has initialised the SDK, which happens only with a non-empty DSN.
final class SentryErrorReporter implements ErrorReporter {
  SentryErrorReporter(this.config);

  final SentryConfig config;
  bool _collectionEnabled = true;

  /// Initialises the SDK when a DSN is configured and collection is allowed.
  Future<void> start() async {
    if (!config.isEnabled || !_collectionEnabled || Sentry.isEnabled) return;
    await SentryFlutter.init((options) {
      options
        ..dsn = config.dsn
        ..environment = config.environment
        ..release = config.release
        ..dist = config.dist
        ..sendDefaultPii = false
        ..attachScreenshot = false
        ..tracesSampleRate = 0.1
        ..beforeSend = scrubEvent
        ..beforeBreadcrumb = scrubBreadcrumb;
      // The app owns the Flutter and platform error hooks and feeds this reporter;
      // Sentry's own hooks would report the same error a second time.
      for (final integration in List.of(options.integrations)) {
        if (const {'FlutterErrorIntegration', 'OnErrorIntegration'}.contains('${integration.runtimeType}')) {
          options.removeIntegration(integration);
        }
      }
    });
  }

  @override
  Future<void> recordError(Object error, StackTrace? stackTrace, {String? reason, bool fatal = false}) async {
    if (!Sentry.isEnabled) return;
    await Sentry.captureException(
      error,
      stackTrace: stackTrace,
      withScope: (scope) {
        scope.level = fatal ? SentryLevel.fatal : SentryLevel.error;
        if (reason != null) scope.setTag('reason', Scrubber.text(reason));
      },
    );
  }

  @override
  void breadcrumb(String message) {
    if (!Sentry.isEnabled) return;
    Sentry.addBreadcrumb(Breadcrumb(message: Scrubber.text(message)));
  }

  @override
  Future<void> setUser({String? userId, String? shelterId}) async {
    if (!Sentry.isEnabled) return;
    await Sentry.configureScope((scope) async {
      await scope.setUser(userId == null ? null : SentryUser(id: userId));
      if (shelterId == null) {
        await scope.removeTag('shelter_id');
      } else {
        await scope.setTag('shelter_id', shelterId);
      }
    });
  }

  @override
  Future<void> setCollectionEnabled(bool enabled) async {
    _collectionEnabled = enabled;
    if (enabled) {
      await start();
    } else if (Sentry.isEnabled) {
      await Sentry.close();
    }
  }

  /// Strips credentials and personal data from an outgoing event.
  static SentryEvent scrubEvent(SentryEvent event, Hint hint) {
    final request = event.request;
    if (request != null) {
      final url = request.url;
      request
        ..url = url == null ? null : Scrubber.url(url)
        ..queryString = null
        ..cookies = null
        ..headers = Scrubber.headers(request.headers);
      event.request = SentryRequest(url: request.url, method: request.method, headers: request.headers);
    }
    final message = event.message;
    if (message != null) message.formatted = Scrubber.text(message.formatted);
    for (final exception in event.exceptions ?? const <SentryException>[]) {
      final value = exception.value;
      if (value != null) exception.value = Scrubber.text(value);
    }
    final user = event.user;
    if (user != null) event.user = SentryUser(id: user.id);
    return event;
  }

  /// Strips credentials and personal data from a breadcrumb; HTTP crumbs keep
  /// only the method, the path and the status.
  static Breadcrumb? scrubBreadcrumb(Breadcrumb? breadcrumb, Hint hint) {
    if (breadcrumb == null) return null;
    final message = breadcrumb.message;
    if (message != null) breadcrumb.message = Scrubber.text(message);
    final data = breadcrumb.data;
    if (data != null) {
      breadcrumb.data = {
        for (final key in const ['method', 'status_code', 'reason', 'duration'])
          if (data[key] != null) key: data[key],
        if (data['url'] is String) 'url': Scrubber.url(data['url'] as String),
      };
    }
    return breadcrumb;
  }
}
