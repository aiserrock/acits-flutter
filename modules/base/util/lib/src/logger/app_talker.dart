import 'dart:developer' as dev;

import 'package:talker_flutter/talker_flutter.dart';

import 'app_log_formatter.dart';
import 'crashlytics_talker_observer.dart';

/// Общая фабрика Talker для обоих флейворов (единый форматтер/observer/вывод).
Talker createAppTalker({required bool enabled}) {
  return Talker(
    observer: const CrashlyticsTalkerObserver(),
    settings: TalkerSettings(enabled: enabled),
    logger: TalkerLogger(
      formatter: const AppLogFormatter('package:acits_flutter'),
      settings: TalkerLoggerSettings(level: LogLevel.debug),
      // Вывод в dart:developer.log — виден в IDE/`flutter logs` с тегом acits.
      output: (message) => message.split('\n').forEach((line) => dev.log(line, name: 'acits')),
    ),
  );
}
