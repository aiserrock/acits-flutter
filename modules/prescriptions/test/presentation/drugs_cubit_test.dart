import 'dart:async';

import 'package:util/util.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:prescriptions/prescriptions.dart';

typedef _DrugsResult = Result<Failure, List<Drug>>;

class _ListCall {
  _ListCall(this.search, this.limit, this.offset);

  final String? search;
  final int limit;
  final int offset;
  final completer = Completer<_DrugsResult>();
}

/// Репозиторий-заглушка: каждый вызов [listDrugs] записывается и ждёт, пока тест
/// завершит его completer. Остальные методы в этих тестах не вызываются.
class _FakeRepository implements PrescriptionRepository {
  final calls = <_ListCall>[];

  @override
  Future<_DrugsResult> listDrugs({String? searchRequest, int limit = 25, int offset = 0}) {
    final call = _ListCall(searchRequest, limit, offset);
    calls.add(call);
    return call.completer.future;
  }

  @override
  dynamic noSuchMethod(Invocation invocation) => throw UnimplementedError('${invocation.memberName}');
}

List<Drug> _drugs(int count, {int from = 0}) => [
  for (var i = from; i < from + count; i++)
    Drug(id: i, name: 'Drug $i', formOfDrug: 1, formOfDrugName: 'Tablets', drugResiduesCount: i),
];

Future<void> _tick() => Future<void>.delayed(Duration.zero);

void main() {
  late _FakeRepository repository;
  late DrugsCubit cubit;

  setUp(() {
    repository = _FakeRepository();
    cubit = DrugsCubit(repository, searchDebounce: const Duration(milliseconds: 10));
  });

  tearDown(() => cubit.close());

  Future<void> completeLast(_DrugsResult result) async {
    repository.calls.last.completer.complete(result);
    await _tick();
  }

  test('first load requests page 0 and emits content', () async {
    expect(cubit.state.data, isA<DataLoading<List<Drug>>>());
    expect(repository.calls, hasLength(1));
    expect(repository.calls.single.offset, 0);
    expect(repository.calls.single.limit, drugsPageSize);
    expect(repository.calls.single.search, isNull);

    await completeLast(Ok(_drugs(3)));

    expect(cubit.state.data, isA<DataContent<List<Drug>>>());
    expect(cubit.state.data.valueOrNull, hasLength(3));
  });

  test('failure on first load emits error state with the Failure', () async {
    await completeLast(const Err(ServerFailure(500)));

    expect(cubit.state.data, isA<DataError<List<Drug>>>());
    expect((cubit.state.data as DataError).error, isA<ServerFailure>());
  });

  test('reload after an error loads the list again', () async {
    await completeLast(const Err(ServerFailure(500)));

    unawaited(cubit.reload());
    expect(cubit.state.data, isA<DataLoading<List<Drug>>>());
    await completeLast(Ok(_drugs(2)));

    expect(cubit.state.data.valueOrNull, hasLength(2));
  });

  test('next page appends and requests the next offset', () async {
    await completeLast(Ok(_drugs(drugsPageSize)));

    cubit.loadNextPage();
    expect(cubit.state.page, isA<DataLoading<int>>());
    expect(repository.calls, hasLength(2));
    expect(repository.calls.last.offset, drugsPageSize);

    await completeLast(Ok(_drugs(drugsPageSize, from: drugsPageSize)));

    final list = cubit.state.data.valueOrNull!;
    expect(list, hasLength(drugsPageSize * 2));
    expect(list.map((d) => d.id), List.generate(drugsPageSize * 2, (i) => i));
    expect(cubit.state.page, isA<DataContent<int>>());
  });

  test('a short page ends the list and stops further paging', () async {
    await completeLast(Ok(_drugs(drugsPageSize)));
    cubit.loadNextPage();
    await completeLast(Ok(_drugs(3, from: drugsPageSize)));
    expect(cubit.state.data.valueOrNull, hasLength(drugsPageSize + 3));

    cubit.loadNextPage();
    await _tick();

    expect(repository.calls, hasLength(2));
  });

  test('loadNextPage is ignored while a page request is in flight', () async {
    await completeLast(Ok(_drugs(drugsPageSize)));

    cubit.loadNextPage();
    cubit.loadNextPage();

    expect(repository.calls, hasLength(2));
  });

  test('loadNextPage is ignored while the main list is loading', () async {
    cubit.loadNextPage();

    expect(repository.calls, hasLength(1));
  });

  test('page failure keeps the list and a retry requests the same offset', () async {
    await completeLast(Ok(_drugs(drugsPageSize)));
    cubit.loadNextPage();
    await completeLast(const Err(ServerFailure(503)));

    expect(cubit.state.page, isA<DataError<int>>());
    expect(cubit.state.data.valueOrNull, hasLength(drugsPageSize));

    cubit.loadNextPage();
    expect(repository.calls, hasLength(3));
    expect(repository.calls.last.offset, drugsPageSize);
  });

  test('search resets paging and sends the query from offset 0', () async {
    await completeLast(Ok(_drugs(drugsPageSize)));
    cubit.loadNextPage();
    await completeLast(Ok(_drugs(drugsPageSize, from: drugsPageSize)));
    expect(cubit.state.data.valueOrNull, hasLength(drugsPageSize * 2));

    cubit.onSearchChanged('para');
    await Future<void>.delayed(const Duration(milliseconds: 50));

    expect(cubit.state.searchRequest, 'para');
    expect(cubit.state.data, isA<DataLoading<List<Drug>>>());
    expect(repository.calls.last.search, 'para');
    expect(repository.calls.last.offset, 0);

    await completeLast(Ok(_drugs(drugsPageSize, from: 500)));

    expect(cubit.state.data.valueOrNull, hasLength(drugsPageSize));
    expect(cubit.state.data.valueOrNull!.first.id, 500);

    // Offset после поиска считается заново: следующая страница идёт с 25, а не с 50.
    cubit.loadNextPage();
    expect(repository.calls, hasLength(4));
    expect(repository.calls.last.search, 'para');
    expect(repository.calls.last.offset, drugsPageSize);
  });

  test('search is debounced: only the last query is sent', () async {
    await completeLast(Ok(_drugs(2)));

    cubit.onSearchChanged('p');
    cubit.onSearchChanged('pa');
    cubit.onSearchChanged('par');
    await Future<void>.delayed(const Duration(milliseconds: 50));

    expect(repository.calls, hasLength(2));
    expect(repository.calls.last.search, 'par');
  });

  test('closing search clears the query and reloads the unfiltered list', () async {
    await completeLast(Ok(_drugs(2)));
    cubit.toggleSearch();
    expect(cubit.state.isSearchActive, isTrue);
    cubit.onSearchChanged('para');
    await Future<void>.delayed(const Duration(milliseconds: 50));
    await completeLast(Ok(_drugs(1, from: 9)));

    cubit.toggleSearch();

    expect(cubit.state.isSearchActive, isFalse);
    expect(cubit.state.searchRequest, isEmpty);
    expect(repository.calls.last.search, isNull);
    expect(repository.calls.last.offset, 0);
  });

  test('stale response of a superseded reload is ignored', () async {
    final first = repository.calls.single;

    unawaited(cubit.reload());
    final second = repository.calls.last;
    expect(second, isNot(same(first)));

    second.completer.complete(Ok(_drugs(2, from: 100)));
    await _tick();
    first.completer.complete(Ok(_drugs(5)));
    await _tick();

    expect(cubit.state.data.valueOrNull!.map((d) => d.id), [100, 101]);
  });

  test('stale page response arriving after a reset is ignored', () async {
    await completeLast(Ok(_drugs(drugsPageSize)));
    cubit.loadNextPage();
    final stalePage = repository.calls.last;

    unawaited(cubit.reload());
    final fresh = repository.calls.last;
    fresh.completer.complete(Ok(_drugs(2, from: 200)));
    await _tick();
    stalePage.completer.complete(Ok(_drugs(drugsPageSize, from: drugsPageSize)));
    await _tick();

    expect(cubit.state.data.valueOrNull!.map((d) => d.id), [200, 201]);
  });

  test('a response arriving after close does not throw', () async {
    final call = repository.calls.single;
    await cubit.close();

    call.completer.complete(Ok(_drugs(1)));
    await _tick();
  });
}
