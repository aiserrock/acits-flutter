import 'dart:developer' as dev;

import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:talker_flutter/talker_flutter.dart';

import 'package:acits_flutter/util/logger/app_log_formatter.dart';
import 'package:acits_flutter/util/logger/crashlytics_talker_observer.dart';

/// DI-модуль единого логгера приложения (Talker) для PROD-флейвора.
///
/// В release (`kDebugMode == false`) логирование выключено
/// ([TalkerSettings.enabled] = false) — ручные `Log.*` в бизнес-коде становятся
/// no-op, поэтому заголовки/тела в системный лог устройства не попадают.
/// Критичные записи (пока Talker включён, т.е. в debug) идут в Crashlytics
/// через [CrashlyticsTalkerObserver].
///
/// Dev-флейвор регистрирует свой Talker (test/dev/service/logger/) с
/// enabled=true ВСЕГДА — включая release-web на GitHub Pages: это сборка для
/// разработчиков, экран логов (debug-меню) должен работать.
@module
abstract class AppLoggerModule {
  @singleton
  @prod
  Talker talker() => createAppTalker(enabled: kDebugMode);
}

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
