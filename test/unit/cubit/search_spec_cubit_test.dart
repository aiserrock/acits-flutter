import 'package:acits_core/acits_core.dart';
import 'package:acits_flutter/di/di_container.dart';
import 'package:acits_flutter/ui/screen/search_screen/cubit/search_spec_cubit.dart';
import 'package:animals/animals.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class _MockRepo extends Mock implements AnimalRepository {}

class _MockShelter extends Mock implements CurrentShelterProvider {}

AnimalSpecies _species(int id, {int level = 1, String name = 'Кошки'}) =>
    AnimalSpecies(id: id, name: name, level: level);

void main() {
  late _MockRepo repo;
  late _MockShelter shelter;

  setUp(() {
    repo = _MockRepo();
    shelter = _MockShelter();
    when(() => shelter.shelterId).thenReturn(50);
    getIt.registerFactory<AnimalRepository>(() => repo);
    getIt.registerFactory<CurrentShelterProvider>(() => shelter);
  });

  tearDown(() async {
    await getIt.reset();
  });

  void stubListSpecies(List<AnimalSpecies> result) {
    when(
      () => repo.listSpecies(
        level: any(named: 'level'),
        parentId: any(named: 'parentId'),
        search: any(named: 'search'),
        limit: any(named: 'limit'),
        offset: any(named: 'offset'),
        shelterId: any(named: 'shelterId'),
      ),
    ).thenAnswer((_) async => Ok([...result]));
  }

  test('top level (no parent) queries species level 1 and exposes AnimalSpecies', () async {
    stubListSpecies([_species(3)]);
    final cubit = SearchSpecCubit();
    await Future<void>.delayed(Duration.zero);

    expect(cubit.state.data.valueOrNull, isA<List<AnimalSpecies>>());
    expect(cubit.state.data.valueOrNull!.single.name, 'Кошки');
    verify(() => repo.listSpecies(level: 1, parentId: null, search: null, offset: 0, shelterId: 50)).called(1);
    await cubit.close();
  });

  test('with parent species of level 1 → queries level 2 scoped to parentId', () async {
    stubListSpecies([_species(9, level: 2, name: 'Барсик')]);
    final cubit = SearchSpecCubit(parentSearch: _species(3, level: 1));
    await Future<void>.delayed(Duration.zero);

    verify(() => repo.listSpecies(level: 2, parentId: 3, search: null, offset: 0, shelterId: 50)).called(1);
    await cubit.close();
  });

  test('failure → error state', () async {
    when(
      () => repo.listSpecies(
        level: any(named: 'level'),
        parentId: any(named: 'parentId'),
        search: any(named: 'search'),
        limit: any(named: 'limit'),
        offset: any(named: 'offset'),
        shelterId: any(named: 'shelterId'),
      ),
    ).thenAnswer((_) async => const Err(NoInternet()));

    final cubit = SearchSpecCubit();
    await Future<void>.delayed(Duration.zero);

    expect(cubit.state.data.hasError, isTrue);
    await cubit.close();
  });
}
