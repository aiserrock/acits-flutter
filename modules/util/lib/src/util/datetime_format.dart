import 'package:intl/intl.dart';

final _dateShortOnlyFormat = DateFormat('dd.MM.yyyy');

/// Форматтеры дат для UI. Держим отдельно от доменных типов — это чисто
/// презентационная утилита, переиспользуемая фичами.
extension DateTimeFormatX on DateTime {
  /// 01.04.2022
  String get toDateShortOnly => _dateShortOnlyFormat.format(this);
}
