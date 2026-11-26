import 'dart:async';

import 'package:util/util.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:prescriptions/domain/domain.dart';
import 'package:prescriptions/presentation/calendar/cubit/calendar_dates.dart';
import 'package:prescriptions/presentation/calendar/cubit/calendar_state.dart';
import 'package:prescriptions/util/util.dart';

/// Cubit экрана «Календарь» (только чтение).
///
/// Держит показанный месяц, выбранный день и исполнения месяца, сгруппированные
/// по локальной дате. Месяц загружается целиком одним запросом `[from, to)`.
/// Ответы на устаревшие запросы (быстрое листание месяцев) игнорируются.
/// Данные загружаются сразу при создании.
class CalendarCubit extends Cubit<CalendarState> {
  CalendarCubit(this._repository, {DateTime Function() clock = DateTime.now})
    : _clock = clock,
      super(CalendarState.initial(clock())) {
    load();
  }

  final PrescriptionRepository _repository;
  final DateTime Function() _clock;

  /// Поколение запроса: инкрементится при каждой загрузке. Ответ из прошлого
  /// поколения игнорируется, иначе поздний ответ другого месяца затёр бы текущий.
  int _requestGen = 0;

  /// Загрузить показанный месяц заново (старт, pull-to-refresh, retry).
  Future<void> load() {
    final gen = ++_requestGen;
    safeEmit(state.copyWith(data: const DataState.loading()));
    return _fetch(gen, state.visibleMonth);
  }

  /// Показать месяц, в который попадает [month] (пред./след./сегодня).
  ///
  /// Выбранный день — сегодня, если он в этом месяце, иначе 1-е число. Повторный
  /// вызов для уже показанного месяца только перезагружает его.
  Future<void> showMonth(DateTime month) {
    final target = monthStart(month);
    if (isSameMonth(target, state.visibleMonth)) return load();
    final today = dateOnly(_clock());
    return _openMonth(target, isSameMonth(target, today) ? today : target);
  }

  /// Перейти на сегодня: показать текущий месяц и выбрать сегодняшний день.
  Future<void> goToToday() {
    final today = dateOnly(_clock());
    return selectDay(today);
  }

  /// Выбрать день [day]. День другого месяца переключает показанный месяц.
  Future<void> selectDay(DateTime day) {
    final selected = dateOnly(day);
    if (isSameMonth(selected, state.visibleMonth)) {
      safeEmit(state.copyWith(selectedDay: selected));
      return Future<void>.value();
    }
    return _openMonth(monthStart(selected), selected);
  }

  Future<void> _openMonth(DateTime month, DateTime selected) {
    final gen = ++_requestGen;
    safeEmit(CalendarState(visibleMonth: month, selectedDay: selected));
    return _fetch(gen, month);
  }

  Future<void> _fetch(int gen, DateTime month) async {
    final from = DateTime(month.year, month.month);
    final to = DateTime(month.year, month.month + 1);
    final result = await _repository.listExecutions(from, to);
    if (gen != _requestGen) {
      Log.debug('CalendarCubit: stale response gen=$gen cur=$_requestGen, skip');
      return;
    }
    result.fold((failure) {
      Log.error('CalendarCubit: load failed month=$from', failure);
      safeEmit(state.copyWith(data: DataState.error(failure)));
    }, (executions) => safeEmit(state.copyWith(data: DataState.content(_groupByDay(executions)))));
  }

  static CalendarExecutions _groupByDay(List<PrescriptionExecutionToday> executions) {
    final sorted = [...executions]..sort((a, b) => a.executeAt.compareTo(b.executeAt));
    final grouped = <DateTime, List<PrescriptionExecutionToday>>{};
    for (final execution in sorted) {
      grouped.putIfAbsent(dateOnly(execution.executeAt), () => []).add(execution);
    }
    return grouped;
  }
}
