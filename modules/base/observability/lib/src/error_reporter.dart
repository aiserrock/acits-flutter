/// Where errors and breadcrumbs from the app are sent. One call reaches every
/// configured backend exactly once.
abstract interface class ErrorReporter {
  /// Reports [error]. [fatal] marks an error that took the app down.
  Future<void> recordError(Object error, StackTrace? stackTrace, {String? reason, bool fatal = false});

  /// Leaves a breadcrumb that is attached to later error reports.
  void breadcrumb(String message);

  /// Identifies the session by ids only — never a name, an e-mail or a phone.
  Future<void> setUser({String? userId, String? shelterId});

  /// Turns sending on or off (the user's opt-out).
  Future<void> setCollectionEnabled(bool enabled);
}

/// Sends every call to each of [reporters]. A reporter that throws does not
/// stop the others: reporting must never be the reason the app fails.
final class CompositeErrorReporter implements ErrorReporter {
  const CompositeErrorReporter(this.reporters);

  final List<ErrorReporter> reporters;

  @override
  Future<void> recordError(Object error, StackTrace? stackTrace, {String? reason, bool fatal = false}) =>
      _each((r) => r.recordError(error, stackTrace, reason: reason, fatal: fatal));

  @override
  void breadcrumb(String message) {
    for (final reporter in reporters) {
      try {
        reporter.breadcrumb(message);
      } catch (_) {}
    }
  }

  @override
  Future<void> setUser({String? userId, String? shelterId}) =>
      _each((r) => r.setUser(userId: userId, shelterId: shelterId));

  @override
  Future<void> setCollectionEnabled(bool enabled) => _each((r) => r.setCollectionEnabled(enabled));

  Future<void> _each(Future<void> Function(ErrorReporter reporter) call) async {
    for (final reporter in reporters) {
      try {
        await call(reporter);
      } catch (_) {}
    }
  }
}

/// Reports nothing. Used on platforms without a backend and in tests.
final class NoopErrorReporter implements ErrorReporter {
  const NoopErrorReporter();

  @override
  Future<void> recordError(Object error, StackTrace? stackTrace, {String? reason, bool fatal = false}) async {}

  @override
  void breadcrumb(String message) {}

  @override
  Future<void> setUser({String? userId, String? shelterId}) async {}

  @override
  Future<void> setCollectionEnabled(bool enabled) async {}
}
