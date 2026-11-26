import 'package:easy_localization/easy_localization.dart';
import 'package:localization/localization.dart';
import 'package:material_ui/material_ui.dart';

import 'package:prescriptions/presentation/calendar/cubit/cubit.dart';

/// Минимальная высота ячейки дня (достаточная для касания).
const calendarCellMinHeight = 48.0;

/// Сетка месяца: 7 колонок, неделя с понедельника, не больше 6 строк.
///
/// Дни с исполнениями получают бейдж с количеством, сегодня обведён, выбранный
/// день залит.
class MonthGrid extends StatelessWidget {
  const MonthGrid({
    required this.month,
    required this.selectedDay,
    required this.executions,
    required this.onDaySelected,
    super.key,
  });

  /// Первый день показанного месяца.
  final DateTime month;
  final DateTime selectedDay;

  /// Исполнения месяца по датам; null — данные ещё не загружены.
  final CalendarExecutions? executions;
  final ValueChanged<DateTime> onDaySelected;

  @override
  Widget build(BuildContext context) {
    final locale = context.locale.toString();
    final weekdayFormat = DateFormat.E(locale);
    final theme = Theme.of(context);
    final today = dateOnly(DateTime.now());

    final daysInMonth = DateTime(month.year, month.month + 1, 0).day;
    final leading = month.weekday - DateTime.monday;
    final rowCount = ((leading + daysInMonth) / DateTime.daysPerWeek).ceil();

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ExcludeSemantics(
          child: Row(
            children: [
              for (var i = 0; i < DateTime.daysPerWeek; i++)
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    // 2024-01-01 — понедельник.
                    child: Text(
                      toBeginningOfSentenceCase(weekdayFormat.format(DateTime(2024, 1, 1 + i))),
                      textAlign: TextAlign.center,
                      style: theme.textTheme.labelMedium?.copyWith(color: theme.colorScheme.onSurfaceVariant),
                    ),
                  ),
                ),
            ],
          ),
        ),
        for (var row = 0; row < rowCount; row++)
          IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                for (var col = 0; col < DateTime.daysPerWeek; col++)
                  Expanded(
                    child: _buildCell(context, row * DateTime.daysPerWeek + col - leading + 1, daysInMonth, today),
                  ),
              ],
            ),
          ),
      ],
    );
  }

  Widget _buildCell(BuildContext context, int dayNumber, int daysInMonth, DateTime today) {
    if (dayNumber < 1 || dayNumber > daysInMonth) return const SizedBox.shrink();
    final day = DateTime(month.year, month.month, dayNumber);
    final count = executions?[day]?.length ?? 0;
    final fullDate = DateFormat.yMMMMEEEEd(context.locale.toString()).format(day);
    return _DayCell(
      day: day,
      count: count,
      isToday: isSameDay(day, today),
      isSelected: isSameDay(day, selectedDay),
      semanticsLabel: count > 0 ? LocaleKeys.calendarDaySemantics.tr(args: [fullDate, '$count']) : fullDate,
      onTap: () => onDaySelected(day),
    );
  }
}

class _DayCell extends StatelessWidget {
  const _DayCell({
    required this.day,
    required this.count,
    required this.isToday,
    required this.isSelected,
    required this.semanticsLabel,
    required this.onTap,
  });

  final DateTime day;
  final int count;
  final bool isToday;
  final bool isSelected;
  final String semanticsLabel;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final radius = BorderRadius.circular(12.0);
    final foreground = isSelected ? scheme.onPrimary : scheme.onSurface;

    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: Semantics(
        button: true,
        selected: isSelected,
        label: semanticsLabel,
        excludeSemantics: true,
        onTap: onTap,
        child: Material(
          color: isSelected ? scheme.primary : Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: radius,
            side: isToday ? BorderSide(color: scheme.primary, width: 2.0) : BorderSide.none,
          ),
          child: InkWell(
            borderRadius: radius,
            onTap: onTap,
            child: ConstrainedBox(
              constraints: const BoxConstraints(minHeight: calendarCellMinHeight - 4.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '${day.day}',
                    style: theme.textTheme.bodyLarge?.copyWith(
                      color: foreground,
                      fontWeight: isToday || isSelected ? FontWeight.w600 : null,
                    ),
                  ),
                  if (count > 0) _CountBadge(count: count, isSelected: isSelected),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _CountBadge extends StatelessWidget {
  const _CountBadge({required this.count, required this.isSelected});

  final int count;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final background = isSelected ? scheme.onPrimary : scheme.secondaryContainer;
    final foreground = isSelected ? scheme.primary : scheme.onSecondaryContainer;
    return Container(
      margin: const EdgeInsets.only(top: 2.0),
      padding: const EdgeInsets.symmetric(horizontal: 6.0),
      constraints: const BoxConstraints(minWidth: 16.0),
      decoration: BoxDecoration(color: background, borderRadius: BorderRadius.circular(8.0)),
      child: Text(
        '$count',
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 10.0, height: 1.5, fontWeight: FontWeight.w600, color: foreground),
      ),
    );
  }
}
