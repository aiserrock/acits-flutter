import 'dart:developer' as dev;

import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:talker_flutter/talker_flutter.dart';

import 'package:acits_flutter/util/logger/app_log_formatter.dart';
import 'package:acits_flutter/util/logger/crashlytics_talker_observer.dart';

/// DI-модуль единого логгера приложения (Talker).
///
/// Один синглтон на оба флейвора: dev-сборка открывает его логи в `TalkerScreen`
/// (debug-меню), prod шлёт критичные записи в Crashlytics через
/// [CrashlyticsTalkerObserver].
///
/// В release (`kDebugMode == false`) логирование выключено
/// ([TalkerSettings.enabled] = false) — ручные `Log.*` в бизнес-коде становятся
/// no-op, поэтому заголовки/тела в системный лог устройства не попадают.
@module
abstract class AppLoggerModule {
  @singleton
  Talker talker() {
    return Talker(
      observer: const CrashlyticsTalkerObserver(),
      settings: TalkerSettings(enabled: kDebugMode),
      logger: TalkerLogger(
        formatter: const AppLogFormatter('package:acits_flutter'),
        settings: TalkerLoggerSettings(level: LogLevel.debug),
        // Вывод в dart:developer.log — виден в IDE/`flutter logs` с тегом acits.
        output: (message) => message.split('\n').forEach((line) => dev.log(line, name: 'acits')),
      ),
    );
  }
}
