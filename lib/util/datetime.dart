import 'package:intl/intl.dart';

final _dateOnlyFormat = DateFormat('yyyy-MM-dd');

extension DateTimeX on DateTime {
  String toIsoDateOnly() {
    return _dateOnlyFormat.format(this);
  }
}
