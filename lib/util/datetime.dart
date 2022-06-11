import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

final _dateOnlyFormat = DateFormat('yyyy-MM-dd');

extension DateTimeX on DateTime {
  /// yyyy-MM-dd
  String toIsoDateOnly() {
    return _dateOnlyFormat.format(this);
  }

  /// 15.05.2022 22:07
  String get toDateTimeHuman => DateFormat('dd.MM.yyyy HH:mm').format(toLocal());

  /// 01.04.2022
  String get toDateShortOnly => DateFormat('dd.MM.yyyy').format(this);

  /// 01.04.2022
  String get toDateShortWeekDay => DateFormat('dd.MM.yyyy, E').format(this);

  /// 2022-01-04 (формат для бэкенда, не принимает ISO!)
  String get toPatchApiDate => DateFormat('yyyy-MM-dd').format(this);

  /// Установить в текущей дате нужное время дня
  DateTime mergeTime(TimeOfDay time) => DateTime(
        year,
        month,
        day,
        time.hour,
        time.minute,
      );
}

extension DateTimeStringX on String {
  /// 01.04.2022 to DateTime
  DateTime get toDateShortOnlyParse => DateFormat('dd.MM.yyyy').parse(this);
}

extension TimeOfDayX on List<TimeOfDay> {
  /// Сравнение времени дня
  static int timeSort(TimeOfDay current, TimeOfDay other) {
    return (current.hour * 60 + current.minute).compareTo(other.hour * 60 + other.minute);
  }
}
