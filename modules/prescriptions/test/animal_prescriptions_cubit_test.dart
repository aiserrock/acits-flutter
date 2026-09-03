import 'package:util/util.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:prescriptions/prescriptions.dart';

class MockPrescriptionRepository extends Mock implements PrescriptionRepository {}

Prescription _prescription(int id) =>
    Prescription(id: id, animal: 501, type: PrescriptionType.courseOfTreatment, drugs: const [], executions: const []);

void main() {
  late MockPrescriptionRepository repository;

  setUp(() {
    repository = MockPrescriptionRepository();
  });

  test('loads actual prescriptions on creation', () async {
    when(
      () => repository.listByAnimal(
        any(),
        limit: any(named: 'limit'),
        offset: any(named: 'offset'),
        isActual: any(named: 'isActual'),
        isOld: any(named: 'isOld'),
      ),
    ).thenAnswer((_) async => Ok([_prescription(1)]));

    final cubit = AnimalPrescriptionsCubit(repository, animalId: 501);
    await Future<void>.delayed(Duration.zero);

    expect(cubit.state.prescriptionActive, isTrue);
    expect(cubit.state.prescriptions, isA<DataContent<List<Prescription>?>>());
    expect(cubit.state.prescriptions.valueOrNull, hasLength(1));
    verify(() => repository.listByAnimal(501, isActual: true, isOld: false)).called(1);
  });

  test('emits error state carrying the Failure when the repository returns Err', () async {
    when(
      () => repository.listByAnimal(
        any(),
        limit: any(named: 'limit'),
        offset: any(named: 'offset'),
        isActual: any(named: 'isActual'),
        isOld: any(named: 'isOld'),
      ),
    ).thenAnswer((_) async => const Err(ServerFailure(500)));

    final cubit = AnimalPrescriptionsCubit(repository, animalId: 501);
    await Future<void>.delayed(Duration.zero);

    expect(cubit.state.prescriptions, isA<DataError>());
    expect((cubit.state.prescriptions as DataError).error, isA<ServerFailure>());
  });

  test('togglePrescriptionActive switches the filter and reloads (old)', () async {
    when(
      () => repository.listByAnimal(
        any(),
        limit: any(named: 'limit'),
        offset: any(named: 'offset'),
        isActual: any(named: 'isActual'),
        isOld: any(named: 'isOld'),
      ),
    ).thenAnswer((_) async => const Ok(<Prescription>[]));

    final cubit = AnimalPrescriptionsCubit(repository, animalId: 501);
    await Future<void>.delayed(Duration.zero);

    cubit.togglePrescriptionActive(false);
    await Future<void>.delayed(Duration.zero);

    expect(cubit.state.prescriptionActive, isFalse);
    verify(() => repository.listByAnimal(501, isActual: false, isOld: true)).called(1);
  });
}
