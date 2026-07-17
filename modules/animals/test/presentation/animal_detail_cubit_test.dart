import 'package:acits_core/acits_core.dart';
import 'package:animals/animals.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class _MockRepo extends Mock implements AnimalRepository {}

class _FakeShelter implements CurrentShelterProvider {
  @override
  int? get shelterId => 50;
}

Animal _animal(int id) => Animal(
  id: id,
  name: 'Барсик',
  shelterId: 50,
  status: AnimalStatus.inTheShelter,
  images: const [],
  attributes: const {},
);

void main() {
  late _MockRepo repo;
  final shelter = _FakeShelter();

  setUp(() => repo = _MockRepo());

  void stubGetById(Result<Failure, Animal> result) {
    when(() => repo.getById(any(), shelterId: any(named: 'shelterId'))).thenAnswer((_) async => result);
  }

  group('AnimalDetailCubit initial load', () {
    blocTest<AnimalDetailCubit, DataState<Animal>>(
      'success → content(Animal)',
      setUp: () => stubGetById(Ok(_animal(501))),
      build: () => AnimalDetailCubit(repo, shelter, id: 501),
      wait: const Duration(milliseconds: 10),
      verify: (cubit) {
        expect(cubit.state.isContent, isTrue);
        expect(cubit.state.valueOrNull?.id, 501);
      },
    );

    blocTest<AnimalDetailCubit, DataState<Animal>>(
      'error → error',
      setUp: () => stubGetById(const Err(ServerFailure(500, 'boom'))),
      build: () => AnimalDetailCubit(repo, shelter, id: 501),
      wait: const Duration(milliseconds: 10),
      verify: (cubit) => expect(cubit.state.hasError, isTrue),
    );
  });

  blocTest<AnimalDetailCubit, DataState<Animal>>(
    'loadAnimal scopes by current shelter',
    setUp: () => stubGetById(Ok(_animal(501))),
    build: () => AnimalDetailCubit(repo, shelter, id: 501),
    wait: const Duration(milliseconds: 10),
    verify: (_) => verify(() => repo.getById(501, shelterId: 50)).called(1),
  );
}
