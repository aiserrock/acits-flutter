import 'package:talker_flutter/talker_flutter.dart';

/// Форматтер логов Talker: перед сообщением подставляет номер строки вызова
/// (первый кадр стека из нашего пакета) и оборачивает текст в рамку.
///
/// Порт `LoggerWithLinesNumber` из tms-driver-app. Colored-вывод включается
/// настройкой [TalkerLoggerSettings.enableColors].
class AppLogFormatter implements LoggerFormatter {
  const AppLogFormatter(this._packageName);

  /// Префикс пакета для поиска кадра вызова, например `package:acits_flutter`.
  final String _packageName;

  String _getLineNumber() {
    final lines = StackTrace.current.toString().split('\n');
    var matchIndex = 0;
    for (final line in lines) {
      if (line.contains(_packageName)) {
        // Пропускаем кадры самого логгера (fmt → talker), берём вызов бизнес-кода.
        if (matchIndex >= 2) {
          return "${line.split(RegExp(r'\s+')).last}\n";
        }
        matchIndex++;
      }
    }
    return '';
  }

  static String _getUnderline(int length, {String lineSymbol = '─'}) => '└${lineSymbol * length}';

  static String _getTopline(int length, {String lineSymbol = '─'}) => '┌${lineSymbol * length}';

  @override
  String fmt(LogDetails details, TalkerLoggerSettings settings) {
    final underline = _getUnderline(settings.maxLineWidth, lineSymbol: settings.lineSymbol);
    final topline = _getTopline(settings.maxLineWidth, lineSymbol: settings.lineSymbol);

    var msg = '';
    if (details.message != null) {
      msg = '${_getLineNumber()}${details.message}';
    }

    final msgBorderedLines = msg.split('\n').map((e) => '│ $e');
    if (!settings.enableColors) {
      return '$topline\n${msgBorderedLines.join('\n')}\n$underline';
    }
    var lines = [topline, ...msgBorderedLines, underline];
    lines = lines.map((e) => details.pen.write(e)).toList();
    return lines.join('\n');
  }
}
