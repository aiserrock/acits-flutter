import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

/// Утилиты дат/времени, которые нужны экрану редактора назначения.
///
/// Перенесены из app `util/datetime.dart` (только используемое подмножество),
/// чтобы модуль не тянул приложение. Значения/формат идентичны исходным.
extension DateTimeX on DateTime {
  /// 01.04.2022, Пн
  String get toDateShortWeekDay => DateFormat('dd.MM.yyyy, E').format(this);

  /// Установить в текущей дате нужное время дня.
  DateTime mergeTime(TimeOfDay time) => DateTime(year, month, day, time.hour, time.minute);
}

extension TimeOfDayX on List<TimeOfDay> {
  /// Сравнение времени дня.
  static int timeSort(TimeOfDay current, TimeOfDay other) {
    return (current.hour * 60 + current.minute).compareTo(other.hour * 60 + other.minute);
  }
}
