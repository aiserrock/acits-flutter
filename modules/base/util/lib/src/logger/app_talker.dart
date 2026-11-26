import 'dart:developer' as dev;

import 'package:talker_flutter/talker_flutter.dart';

import 'app_log_formatter.dart';
import 'reporting_talker_observer.dart';

/// The app logger for both flavors.
///
/// Talker stays enabled in every build, otherwise its observer never runs and
/// release builds report nothing. [printToConsole] is what differs: off in
/// prod release, so headers and bodies never reach the device log.
Talker createAppTalker({
  required bool printToConsole,
  required LogErrorSink onError,
  required LogBreadcrumbSink onBreadcrumb,
}) {
  return Talker(
    observer: ReportingTalkerObserver(errorSink: onError, breadcrumbSink: onBreadcrumb),
    settings: TalkerSettings(useConsoleLogs: printToConsole, useHistory: printToConsole),
    logger: TalkerLogger(
      formatter: const AppLogFormatter('package:acits_flutter'),
      settings: TalkerLoggerSettings(level: LogLevel.debug),
      // Вывод в dart:developer.log — виден в IDE/`flutter logs` с тегом acits.
      output: (message) => message.split('\n').forEach((line) => dev.log(line, name: 'acits')),
    ),
  );
}
