import 'package:get_it/get_it.dart';
import 'package:talker_flutter/talker_flutter.dart';

/// Тонкий фасад над Talker для бизнес-кода модуля: `Log.info(...)` и т.п.
///
/// Talker — тот же глобальный синглтон, что и в приложении (`GetIt.instance`):
/// модуль пишет в общий лог без импорта приложения. Если Talker не
/// зарегистрирован (юнит-тесты cubit'ов без DI) — логирование становится no-op,
/// вспомогательный лог не роняет бизнес-логику.
abstract final class Log {
  static Talker? get _talker => GetIt.instance.isRegistered<Talker>() ? GetIt.instance<Talker>() : null;

  static void debug(String message) => _talker?.debug(message);

  static void info(String message) => _talker?.info(message);

  static void warning(String message, [Object? exception, StackTrace? stackTrace]) =>
      _talker?.warning(message, exception, stackTrace);

  static void error(String message, [Object? exception, StackTrace? stackTrace]) =>
      _talker?.error(message, exception, stackTrace);
}
