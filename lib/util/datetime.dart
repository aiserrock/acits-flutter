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
}
