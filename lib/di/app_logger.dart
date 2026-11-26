import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:talker_flutter/talker_flutter.dart';
import 'package:util/util.dart';

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
