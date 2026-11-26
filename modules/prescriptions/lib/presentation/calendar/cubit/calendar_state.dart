import 'package:util/util.dart';
import 'package:equatable/equatable.dart';

import 'package:prescriptions/domain/domain.dart';
import 'package:prescriptions/presentation/calendar/cubit/calendar_dates.dart';

/// Исполнения месяца, сгруппированные по локальной дате (ключ — дата без времени).
typedef CalendarExecutions = Map<DateTime, List<PrescriptionExecutionToday>>;

/// Состояние экрана «Календарь».
///
/// [visibleMonth] — первый день показанного месяца, [selectedDay] — выбранный
/// день (дата без времени), [data] — исполнения показанного месяца.
class CalendarState extends Equatable {
  const CalendarState({required this.visibleMonth, required this.selectedDay, this.data = const DataState.loading()});

  /// Начальное состояние: месяц и выбранный день — по [now].
  factory CalendarState.initial(DateTime now) =>
      CalendarState(visibleMonth: monthStart(now), selectedDay: dateOnly(now));

  final DateTime visibleMonth;
  final DateTime selectedDay;
  final DataState<CalendarExecutions> data;

  /// Исполнения дня [day] по возрастанию времени; пустой список, если их нет
  /// или данные ещё не загружены.
  List<PrescriptionExecutionToday> executionsOn(DateTime day) => data.valueOrNull?[dateOnly(day)] ?? const [];

  /// Исполнения выбранного дня.
  List<PrescriptionExecutionToday> get selectedExecutions => executionsOn(selectedDay);

  CalendarState copyWith({DateTime? visibleMonth, DateTime? selectedDay, DataState<CalendarExecutions>? data}) {
    return CalendarState(
      visibleMonth: visibleMonth ?? this.visibleMonth,
      selectedDay: selectedDay ?? this.selectedDay,
      data: data ?? this.data,
    );
  }

  @override
  List<Object?> get props => [visibleMonth, selectedDay, data];
}
