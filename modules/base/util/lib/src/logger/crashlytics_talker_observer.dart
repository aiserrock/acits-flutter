import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:talker_flutter/talker_flutter.dart';

/// Проксирует критичные логи Talker в Firebase Crashlytics (аналог
/// `SentryTalkerObserver` из a production driver app; Sentry в acits нет).
///
/// - `error`/`critical` → `recordError` (non-fatal, с исключением и стеком);
/// - `warning`/`info` → `Crashlytics.log` (хлебные крошки в отчётах о крашах).
///
/// Crashlytics-плагина на web нет — на web observer ничего не делает.
class CrashlyticsTalkerObserver extends TalkerObserver {
  const CrashlyticsTalkerObserver();

  @override
  void onLog(TalkerData log) {
    if (kIsWeb) return;

    switch (log.logLevel) {
      case LogLevel.critical:
      case LogLevel.error:
        FirebaseCrashlytics.instance.recordError(
          log.exception ?? log.error ?? log.message,
          log.stackTrace,
          reason: log.message,
          fatal: false,
        );
      case LogLevel.warning:
      case LogLevel.info:
        FirebaseCrashlytics.instance.log(log.generateTextMessage());
      default:
        break;
    }
  }
}
