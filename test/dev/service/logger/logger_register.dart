import 'package:acits_flutter/di/app_logger.dart';
import 'package:injectable/injectable.dart';
import 'package:observability/observability.dart';
import 'package:talker_flutter/talker_flutter.dart';

/// Talker для DEV-флейвора: вывод в консоль и история включены ВСЕГДА, в том
/// числе в release-web на GitHub Pages — это сборка для разработчиков, логи и
/// debug-меню должны работать. Prod-флейвор — см. [AppLoggerModule].
@module
abstract class LoggerRegisterDev {
  @singleton
  @dev
  Talker talker(ErrorReporter reporter) => createReportingTalker(reporter, printToConsole: true);
}
