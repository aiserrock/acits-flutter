import 'package:acits_api/acits_api.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:prescriptions/prescriptions.dart';

class MockPrescriptionApiPort extends Mock implements PrescriptionApiPort {}

class MockShelterProvider extends Mock implements PrescriptionsShelterProvider {}

class MockTypeLabels extends Mock implements PrescriptionTypeLabels {}

PrescriptionDto _dto() => PrescriptionDto(
  id: 11,
  animal: 501,
  myType: 'COURSE_OF_TREATMENT',
  duration: 'EVERY_WEEK',
  description: 'desc',
  createdBy: 'Иванов И.',
  drugs: const [PrescriptionDrugDto(drugId: 7, drugName: 'Амоксициллин', drugDosage: 2.5, formOfDrug: 'Таблетка')],
  executions: [PrescriptionExecutionDto(id: 100, executeAt: DateTime.utc(2024, 5, 1, 9), status: 'IN_PROGRESS')],
);

void main() {
  late MockPrescriptionApiPort port;
  late MockShelterProvider shelter;
  late MockTypeLabels typeLabels;
  late PrescriptionService service;

  setUpAll(() {
    registerFallbackValue(const PrescriptionWriteDto(animal: 0, myType: '', drugs: [], executions: []));
  });

  setUp(() {
    port = MockPrescriptionApiPort();
    shelter = MockShelterProvider();
    typeLabels = MockTypeLabels();
    when(() => shelter.shelterId).thenReturn(50);
    when(() => typeLabels.ensureLoaded()).thenAnswer((_) async {});
    service = PrescriptionService(port, shelter, typeLabels);
  });

  test('fetchPrescriptionListByAnimal maps DTO→entity and localizes executeAt', () async {
    when(
      () => port.listByAnimal(
        any(),
        isActual: any(named: 'isActual'),
        isOld: any(named: 'isOld'),
        limit: any(named: 'limit'),
        offset: any(named: 'offset'),
        shelterId: any(named: 'shelterId'),
      ),
    ).thenAnswer((_) async => [_dto()]);

    final list = await service.fetchPrescriptionListByAnimal(501, isActual: true);

    expect(list, hasLength(1));
    final p = list.single;
    expect(p.id, 11);
    expect(p.type, PrescriptionType.courseOfTreatment);
    expect(p.duration, PrescriptionDuration.everyWeek);
    expect(p.drugs.single.drugName, 'Амоксициллин');
    // executeAt переведён в локальное время (равен исходному моменту).
    expect(p.executions.single.executeAt.toUtc(), DateTime.utc(2024, 5, 1, 9));
  });

  test('createPrescription assembles a write DTO with UTC executions', () async {
    when(() => port.create(any(), shelterId: any(named: 'shelterId'))).thenAnswer((_) async => _dto());

    final entity = Prescription(
      animal: 501,
      type: PrescriptionType.courseOfTreatment,
      duration: PrescriptionDuration.custom,
      drugs: const [],
      executions: [PrescriptionExecution(executeAt: DateTime(2024, 5, 1, 9))],
    );
    await service.createPrescription(entity);

    final captured = verify(() => port.create(captureAny(), shelterId: 50)).captured.single as PrescriptionWriteDto;
    expect(captured.animal, 501);
    expect(captured.myType, 'COURSE_OF_TREATMENT');
    expect(captured.executions.single.executeAt.isUtc, isTrue);
  });

  test('getTypeName delegates to the type-labels port with the wire string', () {
    when(() => typeLabels.nameForWire('COURSE_OF_TREATMENT')).thenReturn('Курс лечения');
    expect(service.getTypeName(PrescriptionType.courseOfTreatment), 'Курс лечения');
  });
}
