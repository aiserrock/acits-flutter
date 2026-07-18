import 'package:util/util.dart';
import 'package:animals/animals.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class _MockRepo extends Mock implements AnimalRepository {}

class _FakeShelter implements CurrentShelterProvider {
  @override
  int? get shelterId => 50;
}

AnimalListItem _item(int id, {String name = 'A'}) =>
    AnimalListItem(id: id, name: name, status: AnimalStatus.inTheShelter);

List<AnimalListItem> _page(int count, {int from = 0}) =>
    List.generate(count, (i) => _item(from + i, name: 'A${from + i}'));

void main() {
  late _MockRepo repo;
  final shelter = _FakeShelter();

  setUp(() {
    repo = _MockRepo();
  });

  // Стаб list() дефолтом — ctor cubit'а сразу дёргает первую загрузку.
  void stubList(Result<Failure, List<AnimalListItem>> result) {
    when(
      () => repo.list(
        shelterId: any(named: 'shelterId'),
        search: any(named: 'search'),
        ordering: any(named: 'ordering'),
        limit: any(named: 'limit'),
        offset: any(named: 'offset'),
      ),
    ).thenAnswer((_) async => result);
  }

  group('AnimalsCubit initial load', () {
    blocTest<AnimalsCubit, AnimalsState>(
      'success → content(items)',
      setUp: () => stubList(Ok(_page(3))),
      build: () => AnimalsCubit(repo, shelter),
      wait: const Duration(milliseconds: 10),
      verify: (cubit) {
        expect(cubit.state.data.valueOrNull, hasLength(3));
        expect(cubit.state.data.isContent, isTrue);
      },
    );

    blocTest<AnimalsCubit, AnimalsState>(
      'error → data error',
      setUp: () => stubList(const Err(NoInternet())),
      build: () => AnimalsCubit(repo, shelter),
      wait: const Duration(milliseconds: 10),
      verify: (cubit) => expect(cubit.state.data.hasError, isTrue),
    );
  });

  group('AnimalsCubit search', () {
    blocTest<AnimalsCubit, AnimalsState>(
      'debounced search triggers a filtered reload',
      setUp: () => stubList(Ok(_page(2))),
      build: () => AnimalsCubit(repo, shelter),
      wait: const Duration(milliseconds: 10),
      act: (cubit) async {
        cubit.onSearchChanged('bar');
        await Future<void>.delayed(const Duration(milliseconds: 350));
      },
      verify: (cubit) {
        expect(cubit.state.searchRequest, 'bar');
        verify(
          () => repo.list(
            search: 'bar',
            ordering: any(named: 'ordering'),
            shelterId: 50,
            limit: 25,
            offset: 0,
          ),
        ).called(1);
      },
    );
  });

  group('AnimalsCubit pagination', () {
    blocTest<AnimalsCubit, AnimalsState>(
      'loadNextPage appends the next page',
      setUp: () {
        // Первая (полная) страница = 25, чтобы reachedEnd не выставился.
        when(
          () => repo.list(
            shelterId: any(named: 'shelterId'),
            search: any(named: 'search'),
            ordering: any(named: 'ordering'),
            limit: any(named: 'limit'),
            offset: 0,
          ),
        ).thenAnswer((_) async => Ok(_page(25)));
        when(
          () => repo.list(
            shelterId: any(named: 'shelterId'),
            search: any(named: 'search'),
            ordering: any(named: 'ordering'),
            limit: any(named: 'limit'),
            offset: 25,
          ),
        ).thenAnswer((_) async => Ok(_page(5, from: 25)));
      },
      build: () => AnimalsCubit(repo, shelter),
      wait: const Duration(milliseconds: 10),
      act: (cubit) async {
        // Дождаться первой загрузки (ctor стартует её асинхронно).
        await Future<void>.delayed(const Duration(milliseconds: 10));
        cubit.loadNextPage();
        await Future<void>.delayed(const Duration(milliseconds: 10));
      },
      verify: (cubit) => expect(cubit.state.data.valueOrNull, hasLength(30)),
    );
  });

  group('AnimalsCubit delete', () {
    blocTest<AnimalsCubit, AnimalsState>(
      'optimistic delete success removes the item',
      setUp: () {
        stubList(Ok(_page(3)));
        when(() => repo.delete(any(), shelterId: any(named: 'shelterId'))).thenAnswer((_) async => const Ok(null));
      },
      build: () => AnimalsCubit(repo, shelter),
      wait: const Duration(milliseconds: 10),
      act: (cubit) async {
        await Future<void>.delayed(const Duration(milliseconds: 10));
        final target = cubit.state.data.valueOrNull!.first;
        final ok = await cubit.deleteAnimal(target);
        expect(ok, isTrue);
      },
      verify: (cubit) => expect(cubit.state.data.valueOrNull, hasLength(2)),
    );

    blocTest<AnimalsCubit, AnimalsState>(
      'delete failure rolls back the list',
      setUp: () {
        stubList(Ok(_page(3)));
        when(
          () => repo.delete(any(), shelterId: any(named: 'shelterId')),
        ).thenAnswer((_) async => const Err(ServerFailure(500, 'boom')));
      },
      build: () => AnimalsCubit(repo, shelter),
      wait: const Duration(milliseconds: 10),
      act: (cubit) async {
        await Future<void>.delayed(const Duration(milliseconds: 10));
        final target = cubit.state.data.valueOrNull!.first;
        final ok = await cubit.deleteAnimal(target);
        expect(ok, isFalse);
      },
      verify: (cubit) => expect(cubit.state.data.valueOrNull, hasLength(3)),
    );
  });
}
