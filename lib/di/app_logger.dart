import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:observability/observability.dart';
import 'package:talker_flutter/talker_flutter.dart';
import 'package:util/util.dart';

/// DI-модуль единого логгера приложения (Talker) для PROD-флейвора.
///
/// Talker включён всегда: иначе его observer не вызывается и release-сборка
/// ничего не репортит. В release выключен только вывод в консоль устройства,
/// поэтому заголовки и тела запросов в системный лог не попадают. Ошибки и
/// предупреждения уходят в [ErrorReporter] (Crashlytics, Sentry).
///
/// Dev-флейвор регистрирует свой Talker (test/dev/service/logger/) с выводом в
/// консоль всегда — включая release-web: экран логов в debug-меню должен работать.
@module
abstract class AppLoggerModule {
  @singleton
  @prod
  Talker talker(ErrorReporter reporter) => createReportingTalker(reporter, printToConsole: kDebugMode);
}

/// Talker, пересылающий ошибки и «хлебные крошки» в [reporter].
Talker createReportingTalker(ErrorReporter reporter, {required bool printToConsole}) => createAppTalker(
  printToConsole: printToConsole,
  onError: (error, stackTrace, message) => reporter.recordError(error, stackTrace, reason: message),
  onBreadcrumb: reporter.breadcrumb,
);
