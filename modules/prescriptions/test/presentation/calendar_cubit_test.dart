import 'dart:async';

import 'package:util/util.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:prescriptions/prescriptions.dart';

typedef _ExecutionsResult = Result<Failure, List<PrescriptionExecutionToday>>;

class _ListCall {
  _ListCall(this.from, this.to);

  final DateTime from;
  final DateTime to;
  final completer = Completer<_ExecutionsResult>();
}

/// Репозиторий-заглушка: каждый вызов [listExecutions] записывается и ждёт, пока
/// тест завершит его completer. Остальные методы в этих тестах не вызываются.
class _FakeRepository implements PrescriptionRepository {
  final calls = <_ListCall>[];

  @override
  Future<_ExecutionsResult> listExecutions(DateTime from, DateTime to) {
    final call = _ListCall(from, to);
    calls.add(call);
    return call.completer.future;
  }

  @override
  dynamic noSuchMethod(Invocation invocation) => throw UnimplementedError('${invocation.memberName}');
}

PrescriptionExecutionToday _execution(DateTime at, {int id = 1}) => PrescriptionExecutionToday(
  id: id,
  executeAt: at,
  prescription: const PrescriptionShortEntity(
    animal: AnimalShort(id: 7, uuid: 'uuid', specName: 'Dog'),
    drugs: [],
  ),
);

Future<void> _tick() => Future<void>.delayed(Duration.zero);

void main() {
  // «Сегодня» зафиксировано: 26 ноября 2026.
  final now = DateTime(2026, 11, 26, 10, 30);

  late _FakeRepository repository;
  late CalendarCubit cubit;

  setUp(() {
    repository = _FakeRepository();
    cubit = CalendarCubit(repository, clock: () => now);
  });

  tearDown(() => cubit.close());

  Future<void> completeLast(_ExecutionsResult result) async {
    repository.calls.last.completer.complete(result);
    await _tick();
  }

  test('first load requests the current month and groups executions by local day', () async {
    expect(cubit.state.data, isA<DataLoading<CalendarExecutions>>());
    expect(cubit.state.visibleMonth, DateTime(2026, 11));
    expect(cubit.state.selectedDay, DateTime(2026, 11, 26));
    expect(repository.calls, hasLength(1));
    expect(repository.calls.single.from, DateTime(2026, 11));
    expect(repository.calls.single.to, DateTime(2026, 12));

    await completeLast(
      Ok([
        _execution(DateTime(2026, 11, 3, 8, 0), id: 1),
        _execution(DateTime(2026, 11, 3, 23, 59), id: 2),
        _execution(DateTime(2026, 11, 26, 0, 0), id: 3),
        _execution(DateTime(2026, 11, 26, 9, 15), id: 4),
      ]),
    );

    final data = cubit.state.data.valueOrNull!;
    expect(data.keys, unorderedEquals([DateTime(2026, 11, 3), DateTime(2026, 11, 26)]));
    expect(data[DateTime(2026, 11, 3)]!.map((e) => e.id), [1, 2]);
    expect(data[DateTime(2026, 11, 26)]!.map((e) => e.id), [3, 4]);
    expect(cubit.state.selectedExecutions.map((e) => e.id), [3, 4]);
  });

  test('executions of a day are sorted by time even when the repository returns them unsorted', () async {
    await completeLast(
      Ok([_execution(DateTime(2026, 11, 26, 18, 0), id: 2), _execution(DateTime(2026, 11, 26, 7, 0), id: 1)]),
    );

    expect(cubit.state.selectedExecutions.map((e) => e.id), [1, 2]);
  });

  test('showMonth requests [from, to) of the new month and keeps the old data hidden while loading', () async {
    await completeLast(Ok([_execution(DateTime(2026, 11, 3, 8, 0))]));

    unawaited(cubit.showMonth(DateTime(2026, 12)));

    expect(cubit.state.visibleMonth, DateTime(2026, 12));
    expect(cubit.state.data, isA<DataLoading<CalendarExecutions>>());
    expect(repository.calls, hasLength(2));
    expect(repository.calls.last.from, DateTime(2026, 12));
    expect(repository.calls.last.to, DateTime(2027, 1));
    // Выбранный день — 1-е число, раз сегодня не в этом месяце.
    expect(cubit.state.selectedDay, DateTime(2026, 12));

    await completeLast(const Ok([]));
    expect(cubit.state.data.valueOrNull, isEmpty);
  });

  test('showMonth back to the current month selects today', () async {
    await completeLast(const Ok([]));
    unawaited(cubit.showMonth(DateTime(2026, 10)));
    await completeLast(const Ok([]));
    expect(repository.calls.last.from, DateTime(2026, 10));
    expect(repository.calls.last.to, DateTime(2026, 11));

    unawaited(cubit.showMonth(DateTime(2026, 11, 15)));

    expect(cubit.state.visibleMonth, DateTime(2026, 11));
    expect(cubit.state.selectedDay, DateTime(2026, 11, 26));
    expect(repository.calls.last.from, DateTime(2026, 11));
    expect(repository.calls.last.to, DateTime(2026, 12));
  });

  test('stale response of a previous month is ignored when months are flipped quickly', () async {
    final novemberCall = repository.calls.single;

    unawaited(cubit.showMonth(DateTime(2026, 12)));
    final decemberCall = repository.calls.last;

    // Ответ на декабрь приходит первым, ноябрьский — позже и должен быть отброшен.
    decemberCall.completer.complete(Ok([_execution(DateTime(2026, 12, 5, 9, 0), id: 10)]));
    await _tick();
    novemberCall.completer.complete(Ok([_execution(DateTime(2026, 11, 3, 8, 0), id: 99)]));
    await _tick();

    expect(cubit.state.visibleMonth, DateTime(2026, 12));
    final data = cubit.state.data.valueOrNull!;
    expect(data.keys, [DateTime(2026, 12, 5)]);
    expect(data[DateTime(2026, 12, 5)]!.single.id, 10);
  });

  test('stale failure does not overwrite the current month', () async {
    final novemberCall = repository.calls.single;

    unawaited(cubit.showMonth(DateTime(2026, 12)));
    await completeLast(const Ok([]));

    novemberCall.completer.complete(const Err(ServerFailure(500)));
    await _tick();

    expect(cubit.state.data, isA<DataContent<CalendarExecutions>>());
  });

  test('failure emits error state with the Failure and load() retries', () async {
    await completeLast(const Err(ServerFailure(500)));

    expect(cubit.state.data, isA<DataError<CalendarExecutions>>());
    expect((cubit.state.data as DataError).error, isA<ServerFailure>());

    unawaited(cubit.load());
    expect(cubit.state.data, isA<DataLoading<CalendarExecutions>>());
    expect(repository.calls, hasLength(2));
    expect(repository.calls.last.from, DateTime(2026, 11));

    await completeLast(Ok([_execution(DateTime(2026, 11, 26, 9, 0))]));
    expect(cubit.state.data, isA<DataContent<CalendarExecutions>>());
  });

  test('selecting a day of the visible month does not reload', () async {
    await completeLast(const Ok([]));

    await cubit.selectDay(DateTime(2026, 11, 12, 15, 40));

    expect(cubit.state.selectedDay, DateTime(2026, 11, 12));
    expect(cubit.state.visibleMonth, DateTime(2026, 11));
    expect(repository.calls, hasLength(1));
  });

  test('selecting a day of another month switches the month and loads it', () async {
    await completeLast(const Ok([]));

    unawaited(cubit.selectDay(DateTime(2027, 1, 9)));

    expect(cubit.state.visibleMonth, DateTime(2027, 1));
    expect(cubit.state.selectedDay, DateTime(2027, 1, 9));
    expect(repository.calls, hasLength(2));
    expect(repository.calls.last.from, DateTime(2027, 1));
    expect(repository.calls.last.to, DateTime(2027, 2));

    await completeLast(Ok([_execution(DateTime(2027, 1, 9, 12, 0), id: 5)]));
    expect(cubit.state.selectedExecutions.map((e) => e.id), [5]);
  });

  test('goToToday returns to the current month and selects today', () async {
    await completeLast(const Ok([]));
    unawaited(cubit.selectDay(DateTime(2027, 3, 1)));
    await completeLast(const Ok([]));

    unawaited(cubit.goToToday());

    expect(cubit.state.visibleMonth, DateTime(2026, 11));
    expect(cubit.state.selectedDay, DateTime(2026, 11, 26));
    expect(repository.calls.last.from, DateTime(2026, 11));
  });

  test('a day without executions yields an empty list', () async {
    await completeLast(Ok([_execution(DateTime(2026, 11, 3, 8, 0))]));

    expect(cubit.state.executionsOn(DateTime(2026, 11, 4)), isEmpty);
    expect(cubit.state.selectedExecutions, isEmpty);

    await cubit.selectDay(DateTime(2026, 11, 3));
    expect(cubit.state.selectedExecutions, hasLength(1));
  });

  test('executions in the last minutes of the month stay on their own day', () async {
    await completeLast(Ok([_execution(DateTime(2026, 11, 30, 23, 59))]));

    expect(cubit.state.data.valueOrNull!.keys, [DateTime(2026, 11, 30)]);
  });
}
