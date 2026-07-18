import 'package:base/base.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:prescriptions/prescriptions.dart';

class MockPrescriptionService extends Mock implements PrescriptionService {}

Prescription _prescription(int id) =>
    Prescription(id: id, animal: 501, type: PrescriptionType.courseOfTreatment, drugs: const [], executions: const []);

void main() {
  late MockPrescriptionService service;

  setUp(() {
    service = MockPrescriptionService();
  });

  test('loads actual prescriptions on creation', () async {
    when(
      () => service.fetchPrescriptionListByAnimal(
        any(),
        isActual: any(named: 'isActual'),
        isOld: any(named: 'isOld'),
      ),
    ).thenAnswer((_) async => [_prescription(1)]);

    final cubit = AnimalPrescriptionsCubit(service, animalId: 501);
    await Future<void>.delayed(Duration.zero);

    expect(cubit.state.prescriptionActive, isTrue);
    expect(cubit.state.prescriptions, isA<DataContent<List<Prescription>?>>());
    expect(cubit.state.prescriptions.valueOrNull, hasLength(1));
    verify(() => service.fetchPrescriptionListByAnimal(501, isActual: true, isOld: false)).called(1);
  });

  test('emits error state when the service throws', () async {
    when(
      () => service.fetchPrescriptionListByAnimal(
        any(),
        isActual: any(named: 'isActual'),
        isOld: any(named: 'isOld'),
      ),
    ).thenThrow(Exception('boom'));

    final cubit = AnimalPrescriptionsCubit(service, animalId: 501);
    await Future<void>.delayed(Duration.zero);

    expect(cubit.state.prescriptions, isA<DataError>());
  });

  test('togglePrescriptionActive switches the filter and reloads (old)', () async {
    when(
      () => service.fetchPrescriptionListByAnimal(
        any(),
        isActual: any(named: 'isActual'),
        isOld: any(named: 'isOld'),
      ),
    ).thenAnswer((_) async => const <Prescription>[]);

    final cubit = AnimalPrescriptionsCubit(service, animalId: 501);
    await Future<void>.delayed(Duration.zero);

    cubit.togglePrescriptionActive(false);
    await Future<void>.delayed(Duration.zero);

    expect(cubit.state.prescriptionActive, isFalse);
    verify(() => service.fetchPrescriptionListByAnimal(501, isActual: false, isOld: true)).called(1);
  });
}
