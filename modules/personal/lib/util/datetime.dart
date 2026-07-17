import 'package:intl/intl.dart';

/// Утилиты дат/времени, которые нужны UI модуля «Личный кабинет / комментарии».
///
/// Перенесены из app `util/datetime.dart` (только используемое подмножество),
/// чтобы модуль не тянул приложение. Значения/формат идентичны исходным.
extension DateTimeX on DateTime {
  /// 15.05.2022 22:07
  String get toDateTimeHuman => DateFormat('dd.MM.yyyy HH:mm').format(toLocal());
}
