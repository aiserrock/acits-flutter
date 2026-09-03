import 'package:core/api.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart' hide Timeout;
import 'package:mocktail/mocktail.dart';
import 'package:prescriptions/prescriptions.dart';
import 'package:util/util.dart';

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

DrugDto _drugDto() =>
    const DrugDto(id: 7, name: 'Амоксициллин', formOfDrug: 3, formOfDrugName: 'Таблетка', drugResiduesCount: 12);

PrescriptionExecutionTodayDto _todayDto() => PrescriptionExecutionTodayDto(
  id: 900,
  executeAt: DateTime.utc(2024, 5, 1, 9),
  prescription: const PrescriptionShortDto(
    id: 11,
    myType: 'COURSE_OF_TREATMENT',
    description: 'desc',
    animal: AnimalShortDto(id: 501, uuid: 'a-501', name: 'Барсик', specName: 'Кошка'),
    drugs: [PrescriptionDrugDto(drugId: 7, drugName: 'Амоксициллин', drugDosage: 2.5, formOfDrug: 'Таблетка')],
  ),
);

DioException _dioError({int statusCode = 400}) => DioException(
  requestOptions: RequestOptions(path: '/'),
  type: DioExceptionType.badResponse,
  response: Response(
    requestOptions: RequestOptions(path: '/'),
    data: 'boom',
    statusCode: statusCode,
  ),
);

void main() {
  late MockPrescriptionApiPort port;
  late MockShelterProvider shelter;
  late MockTypeLabels typeLabels;
  late PrescriptionRepository repository;

  setUpAll(() {
    registerFallbackValue(const PrescriptionWriteDto(animal: 0, myType: '', drugs: [], executions: []));
  });

  setUp(() {
    port = MockPrescriptionApiPort();
    shelter = MockShelterProvider();
    typeLabels = MockTypeLabels();
    when(() => shelter.shelterId).thenReturn(50);
    when(() => typeLabels.ensureLoaded()).thenAnswer((_) async {});
    repository = PrescriptionRepositoryImpl(port, shelter, typeLabels);
  });

  group('prescriptions', () {
    test('listByAnimal maps DTO→entity inside Ok and localizes executeAt', () async {
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

      final result = await repository.listByAnimal(501, isActual: true);

      expect(result.isOk, isTrue);
      final list = result.valueOrNull!;
      expect(list, hasLength(1));
      final p = list.single;
      expect(p, isA<Prescription>());
      expect(p.id, 11);
      expect(p.type, PrescriptionType.courseOfTreatment);
      expect(p.duration, PrescriptionDuration.everyWeek);
      expect(p.drugs.single.drugName, 'Амоксициллин');
      // executeAt переведён в локальное время (равен исходному моменту).
      expect(p.executions.single.executeAt.toUtc(), DateTime.utc(2024, 5, 1, 9));
      verify(() => typeLabels.ensureLoaded()).called(1);
    });

    test('listByAnimal scopes the call by the current shelter', () async {
      when(
        () => port.listByAnimal(
          any(),
          isActual: any(named: 'isActual'),
          isOld: any(named: 'isOld'),
          limit: any(named: 'limit'),
          offset: any(named: 'offset'),
          shelterId: any(named: 'shelterId'),
        ),
      ).thenAnswer((_) async => const []);

      await repository.listByAnimal(501, isOld: true);

      verify(
        () => port.listByAnimal(501, isActual: false, isOld: true, limit: null, offset: 0, shelterId: 50),
      ).called(1);
    });

    test('listByAnimal maps a bad-response DioException to Err(ServerFailure)', () async {
      when(
        () => port.listByAnimal(
          any(),
          isActual: any(named: 'isActual'),
          isOld: any(named: 'isOld'),
          limit: any(named: 'limit'),
          offset: any(named: 'offset'),
          shelterId: any(named: 'shelterId'),
        ),
      ).thenThrow(_dioError());

      final result = await repository.listByAnimal(501);

      expect(result.isErr, isTrue);
      expect(result.failureOrNull, isA<ServerFailure>());
      expect((result.failureOrNull! as ServerFailure).code, 400);
    });

    test('getById maps a 401 to Err(AuthFailure)', () async {
      when(() => port.getById(any(), shelterId: any(named: 'shelterId'))).thenThrow(_dioError(statusCode: 401));

      final result = await repository.getById(11);

      expect(result.failureOrNull, isA<AuthFailure>());
    });

    test('getById returns Ok with the mapped entity', () async {
      when(() => port.getById(any(), shelterId: any(named: 'shelterId'))).thenAnswer((_) async => _dto());

      final result = await repository.getById(11);

      expect(result.isOk, isTrue);
      expect(result.valueOrNull!.id, 11);
      expect(result.valueOrNull!.description, 'desc');
    });

    test('create assembles a write DTO with UTC executions inside Ok', () async {
      when(() => port.create(any(), shelterId: any(named: 'shelterId'))).thenAnswer((_) async => _dto());

      final entity = Prescription(
        animal: 501,
        type: PrescriptionType.courseOfTreatment,
        duration: PrescriptionDuration.custom,
        drugs: const [],
        executions: [PrescriptionExecution(executeAt: DateTime(2024, 5, 1, 9))],
      );
      final result = await repository.create(entity);

      expect(result.isOk, isTrue);
      final captured = verify(() => port.create(captureAny(), shelterId: 50)).captured.single as PrescriptionWriteDto;
      expect(captured.animal, 501);
      expect(captured.myType, 'COURSE_OF_TREATMENT');
      expect(captured.executions.single.executeAt.isUtc, isTrue);
    });

    test('create maps a connection error to Err(NoInternet)', () async {
      when(() => port.create(any(), shelterId: any(named: 'shelterId'))).thenThrow(
        DioException(
          requestOptions: RequestOptions(path: '/'),
          type: DioExceptionType.connectionError,
        ),
      );

      final result = await repository.create(
        const Prescription(animal: 501, type: PrescriptionType.courseOfTreatment, drugs: [], executions: []),
      );

      expect(result.failureOrNull, isA<NoInternet>());
    });

    test('update sends the id and returns Ok', () async {
      when(() => port.update(any(), any(), shelterId: any(named: 'shelterId'))).thenAnswer((_) async => _dto());

      final result = await repository.update(
        const Prescription(id: 11, animal: 501, type: PrescriptionType.courseOfTreatment, drugs: [], executions: []),
      );

      expect(result.isOk, isTrue);
      final captured =
          verify(() => port.update(11, captureAny(), shelterId: 50)).captured.single as PrescriptionWriteDto;
      expect(captured.id, 11);
    });

    test('update without an id fails with Err instead of throwing', () async {
      final result = await repository.update(
        const Prescription(animal: 501, type: PrescriptionType.courseOfTreatment, drugs: [], executions: []),
      );

      expect(result.isErr, isTrue);
      expect(result.failureOrNull, isA<UnknownFailure>());
      verifyNever(() => port.update(any(), any(), shelterId: any(named: 'shelterId')));
    });
  });

  group('today executions', () {
    test('listTodayExecutions maps DTO→entity inside Ok', () async {
      when(
        () => port.todayExecutions(
          search: any(named: 'search'),
          ordering: any(named: 'ordering'),
          limit: any(named: 'limit'),
          offset: any(named: 'offset'),
          shelterId: any(named: 'shelterId'),
        ),
      ).thenAnswer((_) async => [_todayDto()]);

      final result = await repository.listTodayExecutions(search: 'бар', ordering: 'execute_at');

      expect(result.isOk, isTrue);
      final item = result.valueOrNull!.single;
      expect(item, isA<PrescriptionExecutionToday>());
      expect(item.id, 900);
      expect(item.prescription.animal.name, 'Барсик');
      expect(item.prescription.type, PrescriptionType.courseOfTreatment);
      // executeAt приходит в UTC, отдаётся локальным (тот же момент времени).
      expect(item.executeAt.toUtc(), DateTime.utc(2024, 5, 1, 9));
    });

    test('listTodayExecutions maps a timeout to Err(Timeout)', () async {
      when(
        () => port.todayExecutions(
          search: any(named: 'search'),
          ordering: any(named: 'ordering'),
          limit: any(named: 'limit'),
          offset: any(named: 'offset'),
          shelterId: any(named: 'shelterId'),
        ),
      ).thenThrow(
        DioException(
          requestOptions: RequestOptions(path: '/'),
          type: DioExceptionType.receiveTimeout,
        ),
      );

      final result = await repository.listTodayExecutions();

      expect(result.failureOrNull, isA<Timeout>());
    });
  });

  group('drugs', () {
    test('listDrugs maps DTO→entity inside Ok', () async {
      when(
        () => port.listDrugs(
          search: any(named: 'search'),
          limit: any(named: 'limit'),
          offset: any(named: 'offset'),
          shelterId: any(named: 'shelterId'),
        ),
      ).thenAnswer((_) async => [_drugDto()]);

      final result = await repository.listDrugs(searchRequest: 'амок');

      expect(result.isOk, isTrue);
      final drug = result.valueOrNull!.single;
      expect(drug, isA<Drug>());
      expect(drug.id, 7);
      expect(drug.formOfDrugName, 'Таблетка');
      expect(drug.drugResiduesCount, 12);
      verify(() => port.listDrugs(search: 'амок', limit: 25, offset: 0, shelterId: 50)).called(1);
    });

    test('listDrugs maps a bad-response DioException to Err(ServerFailure)', () async {
      when(
        () => port.listDrugs(
          search: any(named: 'search'),
          limit: any(named: 'limit'),
          offset: any(named: 'offset'),
          shelterId: any(named: 'shelterId'),
        ),
      ).thenThrow(_dioError(statusCode: 500));

      final result = await repository.listDrugs();

      expect((result.failureOrNull! as ServerFailure).code, 500);
    });
  });

  group('PrescriptionService thin wrapper (media search adapter)', () {
    test('fetchDrugList unwraps Ok to a plain list', () async {
      when(
        () => port.listDrugs(
          search: any(named: 'search'),
          limit: any(named: 'limit'),
          offset: any(named: 'offset'),
          shelterId: any(named: 'shelterId'),
        ),
      ).thenAnswer((_) async => [_drugDto()]);

      final list = await PrescriptionService(repository).fetchDrugList(searchRequest: 'амок');

      expect(list, hasLength(1));
      expect(list.single.id, 7);
    });

    test('fetchDrugList returns an empty list on failure', () async {
      when(
        () => port.listDrugs(
          search: any(named: 'search'),
          limit: any(named: 'limit'),
          offset: any(named: 'offset'),
          shelterId: any(named: 'shelterId'),
        ),
      ).thenThrow(_dioError());

      final list = await PrescriptionService(repository).fetchDrugList();

      expect(list, isEmpty);
    });
  });
}
