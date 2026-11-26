import 'package:talker_flutter/talker_flutter.dart';

/// Called for a warning or error log: [error] is the thrown object when there is one.
typedef LogErrorSink = void Function(Object error, StackTrace? stackTrace, String message);

/// Called for an informational log that is worth keeping as a breadcrumb.
typedef LogBreadcrumbSink = void Function(String message);

/// Forwards Talker records to the error reporter:
/// - `error`/`critical` logs, handled errors and exceptions → [errorSink];
/// - `warning`/`info` logs → [breadcrumbSink].
///
/// `debug` and `verbose` records stay on the device.
class ReportingTalkerObserver extends TalkerObserver {
  const ReportingTalkerObserver({required this.errorSink, required this.breadcrumbSink});

  final LogErrorSink errorSink;
  final LogBreadcrumbSink breadcrumbSink;

  @override
  void onLog(TalkerData log) {
    switch (log.logLevel) {
      case LogLevel.critical:
      case LogLevel.error:
        _report(log);
      case LogLevel.warning:
      case LogLevel.info:
        breadcrumbSink(log.message ?? '');
      default:
        break;
    }
  }

  @override
  void onError(TalkerError err) => _report(err);

  @override
  void onException(TalkerException err) => _report(err);

  void _report(TalkerData data) {
    final message = data.message ?? '';
    errorSink(data.exception ?? data.error ?? message, data.stackTrace, message);
  }
}
