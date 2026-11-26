import 'package:firebase_crashlytics/firebase_crashlytics.dart';

import 'error_reporter.dart';
import 'scrubber.dart';

/// Reports to Firebase Crashlytics. Not available on web — do not register it there.
final class CrashlyticsErrorReporter implements ErrorReporter {
  CrashlyticsErrorReporter([FirebaseCrashlytics? crashlytics]) : _crashlytics = crashlytics;

  final FirebaseCrashlytics? _crashlytics;

  FirebaseCrashlytics get _instance => _crashlytics ?? FirebaseCrashlytics.instance;

  @override
  Future<void> recordError(Object error, StackTrace? stackTrace, {String? reason, bool fatal = false}) =>
      _instance.recordError(error, stackTrace, reason: reason == null ? null : Scrubber.text(reason), fatal: fatal);

  @override
  void breadcrumb(String message) => _instance.log(Scrubber.text(message));

  @override
  Future<void> setUser({String? userId, String? shelterId}) async {
    await _instance.setUserIdentifier(userId ?? '');
    await _instance.setCustomKey('shelter_id', shelterId ?? '');
  }

  @override
  Future<void> setCollectionEnabled(bool enabled) => _instance.setCrashlyticsCollectionEnabled(enabled);
}
