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

Animal _animal({int id = 501, int? speciesId = 7}) => Animal(
  id: id,
  name: 'Барсик',
  shelterId: 50,
  status: AnimalStatus.inTheShelter,
  images: const [],
  attributes: const {},
  speciesId: speciesId,
  dateJoined: DateTime.utc(2024),
  placeOfCatch: 'двор',
);

void main() {
  late _MockRepo repo;
  final shelter = _FakeShelter();

  setUpAll(() {
    registerFallbackValue(_animal());
  });

  setUp(() => repo = _MockRepo());

  void stubGetById(Result<Failure, Animal> result) {
    when(() => repo.getById(any(), shelterId: any(named: 'shelterId'))).thenAnswer((_) async => result);
  }

  void stubCreate(Result<Failure, Animal> result) {
    when(
      () => repo.create(
        any(),
        attributes: any(named: 'attributes'),
        newImages: any(named: 'newImages'),
        retainImageIds: any(named: 'retainImageIds'),
        shelterId: any(named: 'shelterId'),
      ),
    ).thenAnswer((_) async => result);
  }

  void stubUpdate(Result<Failure, Animal> result) {
    when(
      () => repo.update(
        any(),
        any(),
        attributes: any(named: 'attributes'),
        newImages: any(named: 'newImages'),
        retainImageIds: any(named: 'retainImageIds'),
        shelterId: any(named: 'shelterId'),
      ),
    ).thenAnswer((_) async => result);
  }

  group('load', () {
    blocTest<AnimalEditCubit, DataState<AnimalEditContent>>(
      'edit: success → content(Animal)',
      setUp: () => stubGetById(Ok(_animal(id: 501))),
      build: () => AnimalEditCubit(repo, shelter, id: 501),
      wait: const Duration(milliseconds: 10),
      verify: (cubit) {
        expect(cubit.state.isContent, isTrue);
        expect(cubit.state.valueOrNull?.animal?.id, 501);
        expect(cubit.state.valueOrNull?.mode, AnimalEditMode.form);
        verify(() => repo.getById(501, shelterId: 50)).called(1);
      },
    );

    blocTest<AnimalEditCubit, DataState<AnimalEditContent>>(
      'edit: error → error',
      setUp: () => stubGetById(const Err(ServerFailure(500, 'boom'))),
      build: () => AnimalEditCubit(repo, shelter, id: 501),
      wait: const Duration(milliseconds: 10),
      verify: (cubit) => expect(cubit.state.hasError, isTrue),
    );

    blocTest<AnimalEditCubit, DataState<AnimalEditContent>>(
      'create (no id): no load, stays empty form content',
      build: () => AnimalEditCubit(repo, shelter),
      wait: const Duration(milliseconds: 10),
      verify: (cubit) {
        expect(cubit.state.valueOrNull?.animal, isNull);
        verifyNever(() => repo.getById(any(), shelterId: any(named: 'shelterId')));
      },
    );
  });

  group('submit', () {
    blocTest<AnimalEditCubit, DataState<AnimalEditContent>>(
      'create success → success mode + create called with populated write',
      setUp: () => stubCreate(Ok(_animal(id: 900))),
      build: () => AnimalEditCubit(repo, shelter),
      act: (cubit) => cubit.submit(
        _animal(id: 0, speciesId: null),
        attributes: const [AnimalAttributeInput(attrId: 3, name: 'sex', value: 'male', isRequired: true)],
        specId: 7,
      ),
      wait: const Duration(milliseconds: 10),
      verify: (cubit) {
        expect(cubit.state.valueOrNull?.mode, AnimalEditMode.success);
        final captured = verify(
          () => repo.create(
            captureAny(),
            attributes: captureAny(named: 'attributes'),
            newImages: any(named: 'newImages'),
            retainImageIds: any(named: 'retainImageIds'),
            shelterId: captureAny(named: 'shelterId'),
          ),
        ).captured;
        final animal = captured[0] as Animal;
        final attrs = captured[1] as List<AnimalAttributeInput>;
        final shelterId = captured[2] as int?;
        expect(animal.name, 'Барсик');
        expect(animal.speciesId, 7); // explicit specId injected into entity
        expect(animal.status.wire, 'IN_THE_SHELTER');
        expect(animal.shelterId, 50);
        expect(attrs.single.name, 'sex');
        expect(shelterId, 50);
      },
    );

    blocTest<AnimalEditCubit, DataState<AnimalEditContent>>(
      'update success → success mode + update called with id',
      setUp: () {
        stubGetById(Ok(_animal(id: 501))); // ctor triggers _load in edit mode
        stubUpdate(Ok(_animal(id: 501)));
      },
      build: () => AnimalEditCubit(repo, shelter, id: 501),
      act: (cubit) => cubit.submit(_animal(id: 501), attributes: const []),
      wait: const Duration(milliseconds: 10),
      verify: (cubit) {
        expect(cubit.state.valueOrNull?.mode, AnimalEditMode.success);
        verify(
          () => repo.update(
            501,
            any(),
            attributes: any(named: 'attributes'),
            newImages: any(named: 'newImages'),
            retainImageIds: any(named: 'retainImageIds'),
            shelterId: 50,
          ),
        ).called(1);
      },
    );

    blocTest<AnimalEditCubit, DataState<AnimalEditContent>>(
      'failure → error state, returns false',
      setUp: () => stubCreate(const Err(ServerFailure(400, 'bad'))),
      build: () => AnimalEditCubit(repo, shelter),
      act: (cubit) async {
        final ok = await cubit.submit(_animal(id: 0), attributes: const [], specId: 7);
        expect(ok, isFalse);
      },
      wait: const Duration(milliseconds: 10),
      verify: (cubit) => expect(cubit.state.hasError, isTrue),
    );
  });
}
