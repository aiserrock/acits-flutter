import 'package:talker_flutter/talker_flutter.dart';

import 'package:acits_flutter/di/di_container.dart';

/// Тонкий фасад над Talker для бизнес-кода: `Log.info(...)`, `Log.error(...)`.
///
/// Не тянет Talker-импорт в каждый сервис и не требует прокидывать логгер через
/// конструкторы. Talker берётся из getIt лениво; в release он отключён
/// ([AppLoggerModule]), поэтому вызовы дёшевы и безопасны (ничего не пишут).
abstract final class Log {
  static Talker get _talker => getIt<Talker>();

  static void debug(String message) => _talker.debug(message);

  static void info(String message) => _talker.info(message);

  static void warning(String message, [Object? exception, StackTrace? stackTrace]) =>
      _talker.warning(message, exception, stackTrace);

  static void error(String message, [Object? exception, StackTrace? stackTrace]) =>
      _talker.error(message, exception, stackTrace);

  /// Обработать пойманное исключение (пишет с уровнем error + stack).
  static void handle(Object exception, [StackTrace? stackTrace, String? message]) =>
      _talker.handle(exception, stackTrace, message);
}
