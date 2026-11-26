/// Локальная дата без времени — ключ группировки исполнений по дням.
DateTime dateOnly(DateTime value) {
  final local = value.isUtc ? value.toLocal() : value;
  return DateTime(local.year, local.month, local.day);
}

/// Первый день месяца, в который попадает [value] (локальная полночь).
DateTime monthStart(DateTime value) {
  final local = value.isUtc ? value.toLocal() : value;
  return DateTime(local.year, local.month);
}

/// Лежат ли [a] и [b] в одном календарном месяце.
bool isSameMonth(DateTime a, DateTime b) => a.year == b.year && a.month == b.month;

/// Лежат ли [a] и [b] в одном календарном дне.
bool isSameDay(DateTime a, DateTime b) => a.year == b.year && a.month == b.month && a.day == b.day;
