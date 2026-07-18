// Parity spike for the prescriptions + drugs endpoint group.
//
// The `Prescription` resource is polymorphic (`oneOf` by `my_type`); the adapter
// parses it from raw JSON into the flat [PrescriptionDto], tolerating unknown/
// absent `my_type`. Drugs + today-executions go through the typed generated
// clients. This proves both paths map the app's wire shape onto OUR DTOs.
import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:core/api.dart';
import 'package:core/api/src/prescriptions_client_barrel.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';

import 'fixtures/prescriptions_fixtures.dart';

/// Captures the outgoing request and replays a canned JSON body.
class _StubHttpAdapter implements HttpClientAdapter {
  _StubHttpAdapter(this._body);

  final Map<String, dynamic> _body;

  RequestOptions? lastRequest;
  Object? lastRequestData;

  @override
  Future<ResponseBody> fetch(
    RequestOptions options,
    Stream<Uint8List>? requestStream,
    Future<void>? cancelFuture,
  ) async {
    lastRequest = options;
    lastRequestData = options.data;
    return ResponseBody.fromString(
      jsonEncode(_body),
      200,
      headers: {
        Headers.contentTypeHeader: [Headers.jsonContentType],
      },
    );
  }

  @override
  void close({bool force = false}) {}
}

/// Fake typed client for the drugs + today-executions paths.
class _FakePrescriptionsClient implements PrescriptionsClient {
  _FakePrescriptionsClient(this.executionsPage);

  final PaginatedPrescriptionExecutionTodayList executionsPage;
  int? lastShelterId;

  @override
  Future<PaginatedPrescriptionExecutionTodayList> v1PrescriptionsExecutionsList({
    required DateTime from,
    required DateTime to,
    int? xCurrentShelter,
    int? limit,
    int? offset,
    String? ordering,
    String? search,
  }) async {
    lastShelterId = xCurrentShelter;
    return executionsPage;
  }

  @override
  dynamic noSuchMethod(Invocation invocation) => throw UnimplementedError('${invocation.memberName} unused');
}

class _FakeSheltersClient implements SheltersClient {
  _FakeSheltersClient(this.drugPage);

  final PaginatedShelterDrugList drugPage;
  int? lastShelterId;
  String? lastSearch;

  @override
  Future<PaginatedShelterDrugList> v1ShelterDrugsList({
    int? xCurrentShelter,
    int? limit,
    int? offset,
    String? search,
  }) async {
    lastShelterId = xCurrentShelter;
    lastSearch = search;
    return drugPage;
  }

  @override
  dynamic noSuchMethod(Invocation invocation) => throw UnimplementedError('${invocation.memberName} unused');
}

PrescriptionApiAdapter _adapter(Map<String, dynamic> body, {_StubHttpAdapter? out}) {
  final dio = Dio(BaseOptions(baseUrl: 'https://api.acits.ru'));
  dio.httpClientAdapter = out ?? _StubHttpAdapter(body);
  return PrescriptionApiAdapter(
    dio,
    _FakePrescriptionsClient(PaginatedPrescriptionExecutionTodayList.fromJson(todayExecutionsJson())),
    _FakeSheltersClient(PaginatedShelterDrugList.fromJson(drugListJson())),
  );
}

void main() {
  group('PrescriptionDto — polymorphic fromJson', () {
    test('parses a fully-populated course-of-treatment', () {
      final dto = PrescriptionDto.fromJson(prescriptionListByAnimalJson()['results'][0] as Map<String, dynamic>);
      expect(dto.id, 11);
      expect(dto.animal, 501);
      expect(dto.myType, 'COURSE_OF_TREATMENT');
      expect(dto.duration, 'EVERY_WEEK');
      expect(dto.description, 'Курс антибиотиков');
      expect(dto.createdBy, 'Иванов И.');
      expect(dto.drugs, hasLength(1));
      expect(dto.drugs.first.drugName, 'Амоксициллин');
      expect(dto.drugs.first.drugDosage, 2.5);
      expect(dto.executions, hasLength(2));
      expect(dto.executions.first.status, 'IN_PROGRESS');
      expect(dto.executions.first.executeAt, DateTime.utc(2024, 5, 1, 9));
      expect(dto.extraTypeAttributes, {'foo': 'bar'});
    });

    test('tolerates absent my_type (flat DTO, no crash)', () {
      final dto = PrescriptionDto.fromJson(prescriptionListByAnimalJson()['results'][1] as Map<String, dynamic>);
      expect(dto.id, 12);
      expect(dto.myType, isNull);
      expect(dto.drugs, isEmpty);
      expect(dto.executions, isEmpty);
    });

    test('tolerates an unknown my_type value (would throw in the sealed type)', () {
      final dto = PrescriptionDto.fromJson(prescriptionUnknownTypeJson());
      expect(dto.myType, 'SOME_FUTURE_TYPE');
      expect(dto.executions.single.status, 'CANCELLED');
    });
  });

  group('PrescriptionWriteDto — toJson', () {
    test('serializes flat with snake_case keys and omits nulls', () {
      final body = PrescriptionWriteDto(
        id: 11,
        animal: 501,
        myType: 'COURSE_OF_TREATMENT',
        duration: 'CUSTOM',
        description: 'desc',
        drugs: const [
          PrescriptionDrugDto(drugId: 7, drugName: 'Амоксициллин', drugDosage: 2.5, formOfDrug: 'Таблетка'),
        ],
        executions: [PrescriptionExecutionDto(executeAt: DateTime.utc(2024, 5, 1, 9))],
      );
      final json = body.toJson();
      expect(json['animal'], 501);
      expect(json['my_type'], 'COURSE_OF_TREATMENT');
      expect(json['drugs'], hasLength(1));
      expect((json['drugs'] as List).first['drug_id'], 7);
      expect((json['executions'] as List).first['execute_at'], '2024-05-01T09:00:00.000Z');
      expect(json.containsKey('extra_type_attributes'), isFalse);
    });
  });

  group('PrescriptionApiAdapter — raw Dio paths', () {
    test('listByAnimal unwraps results and passes filters + shelter header', () async {
      final stub = _StubHttpAdapter(prescriptionListByAnimalJson());
      final adapter = _adapter(prescriptionListByAnimalJson(), out: stub);

      final list = await adapter.listByAnimal(501, isActual: true, shelterId: 50);

      expect(list, hasLength(2));
      expect(list.first.myType, 'COURSE_OF_TREATMENT');
      expect(list[1].myType, isNull);
      expect(stub.lastRequest!.queryParameters['animal'], 501);
      expect(stub.lastRequest!.queryParameters.containsKey('execute_at__gte'), isTrue);
      expect(stub.lastRequest!.headers['x-current-shelter'], 50);
    });

    test('create posts flat body and parses the response', () async {
      final stub = _StubHttpAdapter(prescriptionUnknownTypeJson());
      final adapter = _adapter(prescriptionUnknownTypeJson(), out: stub);

      final dto = await adapter.create(
        const PrescriptionWriteDto(animal: 501, myType: 'OTHER', drugs: [], executions: []),
        shelterId: 50,
      );

      expect(dto.id, 99);
      expect(stub.lastRequest!.method, 'POST');
      final sent = stub.lastRequestData as Map<String, dynamic>;
      expect(sent['animal'], 501);
      expect(sent['my_type'], 'OTHER');
    });
  });

  group('PrescriptionApiAdapter — typed client paths', () {
    test('todayExecutions maps embedded short + animal', () async {
      final adapter = _adapter(const {});
      final list = await adapter.todayExecutions(shelterId: 50);
      expect(list, hasLength(1));
      final e = list.single;
      expect(e.id, 900);
      expect(e.prescription.myType, 'VACCINATION');
      expect(e.prescription.animal.id, 501);
      expect(e.prescription.animal.specName, 'Кошка');
      expect(e.prescription.drugs.single.drugName, 'Вакцина');
    });

    test('listDrugs flattens the ShelterDrug envelope', () async {
      final adapter = _adapter(const {});
      final drugs = await adapter.listDrugs(search: 'амок', shelterId: 50);
      expect(drugs, hasLength(1));
      expect(drugs.single.id, 7);
      expect(drugs.single.name, 'Амоксициллин');
      expect(drugs.single.formOfDrugName, 'Таблетка');
      expect(drugs.single.drugResiduesCount, 42);
    });
  });
}
