import 'package:dio/dio.dart';
import 'package:sentry_dio/sentry_dio.dart';

/// Adds Sentry spans and breadcrumbs for every request made through [dio].
///
/// Call it last, after the adapter and interceptors are set. Without a DSN the
/// Sentry hub is a no-op, so the wrapper costs nothing and sends nothing.
///
/// Failed responses are not captured as separate events: repositories already
/// turn them into typed failures and report the unexpected ones, so a second
/// event per 5xx would only duplicate them. Headers and bodies stay out of
/// the events (`sendDefaultPii` is off) and breadcrumbs pass the scrubber.
void addHttpTracing(Dio dio) => dio.addSentry(captureFailedRequests: false);
