// Parity spike for the staff endpoint group (applicants + curators).
//
// Both resources map onto the typed generated clients. These tests prove the
// adapter unwraps the paginated list, maps generated → OUR DTO, and builds the
// write body (with shelter scoping) that the app historically posted.
import 'package:core/api.dart';
import 'package:core/api/src/staff_client_barrel.dart';
import 'package:flutter_test/flutter_test.dart';

class _FakeApplicantsClient implements ApplicantsClient {
  PaginatedApplicantList listPage = const PaginatedApplicantList(results: []);
  Applicant single = _applicant();

  int? lastShelterId;
  String? lastSearch;
  Applicant? lastBody;
  int? lastId;

  @override
  Future<PaginatedApplicantList> v1ApplicantsList({
    int? xCurrentShelter,
    int? limit,
    int? offset,
    String? ordering,
    String? search,
  }) async {
    lastShelterId = xCurrentShelter;
    lastSearch = search;
    return listPage;
  }

  @override
  Future<Applicant> v1ApplicantsRetrieve({required int id, int? xCurrentShelter}) async {
    lastId = id;
    lastShelterId = xCurrentShelter;
    return single;
  }

  @override
  Future<Applicant> v1ApplicantsCreate({required Applicant body, int? xCurrentShelter}) async {
    lastBody = body;
    lastShelterId = xCurrentShelter;
    return single;
  }

  @override
  Future<Applicant> v1ApplicantsUpdate({required int id, required Applicant body, int? xCurrentShelter}) async {
    lastId = id;
    lastBody = body;
    lastShelterId = xCurrentShelter;
    return single;
  }

  @override
  dynamic noSuchMethod(Invocation invocation) => throw UnimplementedError('${invocation.memberName} unused');
}

class _FakeCuratorsClient implements CuratorsClient {
  PaginatedCuratorList listPage = const PaginatedCuratorList(results: []);
  Curator single = _curator();

  int? lastShelterId;
  String? lastSearch;
  Curator? lastBody;
  int? lastId;

  @override
  Future<PaginatedCuratorList> v1CuratorsList({int? xCurrentShelter, int? limit, int? offset, String? search}) async {
    lastShelterId = xCurrentShelter;
    lastSearch = search;
    return listPage;
  }

  @override
  Future<Curator> v1CuratorsRetrieve({required int id, int? xCurrentShelter}) async {
    lastId = id;
    lastShelterId = xCurrentShelter;
    return single;
  }

  @override
  Future<Curator> v1CuratorsCreate({required Curator body, int? xCurrentShelter}) async {
    lastBody = body;
    lastShelterId = xCurrentShelter;
    return single;
  }

  @override
  Future<Curator> v1CuratorsUpdate({required int id, required Curator body, int? xCurrentShelter}) async {
    lastId = id;
    lastBody = body;
    lastShelterId = xCurrentShelter;
    return single;
  }

  @override
  dynamic noSuchMethod(Invocation invocation) => throw UnimplementedError('${invocation.memberName} unused');
}

Applicant _applicant() => Applicant(
  id: 7,
  url: 'https://api/applicants/7/',
  shelter: 50,
  firstName: 'Grace',
  lastName: 'Hopper',
  email: 'grace@navy.mil',
  phoneNumber: '+70000000000',
  contactDetails: 'tg:@grace',
  createdBy: 'admin',
  updatedBy: 'admin',
  createdAt: DateTime.utc(2024, 1, 1),
  updatedAt: DateTime.utc(2024, 1, 2),
  animalId: 501,
);

Curator _curator() => Curator(
  id: 9,
  url: 'https://api/curators/9/',
  shelter: '50',
  firstName: 'Ada',
  lastName: 'Lovelace',
  email: 'ada@analytical.engine',
  phoneNumber: '+71111111111',
  address: 'London',
  createdBy: 'admin',
  updatedBy: 'admin',
  createdAt: DateTime.utc(2024, 1, 1),
  updatedAt: DateTime.utc(2024, 1, 2),
);

void main() {
  late _FakeApplicantsClient applicants;
  late _FakeCuratorsClient curators;
  late StaffApiAdapter adapter;

  setUp(() {
    applicants = _FakeApplicantsClient();
    curators = _FakeCuratorsClient();
    adapter = StaffApiAdapter(applicants, curators);
  });

  group('applicants', () {
    test('listApplicants unwraps results, maps to DTO, passes search + shelter', () async {
      applicants.listPage = PaginatedApplicantList(results: [_applicant()]);

      final list = await adapter.listApplicants(search: 'grace', shelterId: 50);

      expect(list, hasLength(1));
      expect(list.single.id, 7);
      expect(list.single.firstName, 'Grace');
      expect(list.single.contactDetails, 'tg:@grace');
      expect(applicants.lastSearch, 'grace');
      expect(applicants.lastShelterId, 50);
    });

    test('getApplicant maps a single record', () async {
      final dto = await adapter.getApplicant(7, shelterId: 50);
      expect(dto.id, 7);
      expect(dto.email, 'grace@navy.mil');
      expect(applicants.lastId, 7);
    });

    test('createApplicant posts a body carrying the write fields + shelter', () async {
      await adapter.createApplicant(
        const ApplicantWriteDto(
          shelter: 50,
          firstName: 'Grace',
          lastName: 'Hopper',
          phoneNumber: '+70000000000',
          email: 'grace@navy.mil',
          contactDetails: 'tg:@grace',
        ),
        shelterId: 50,
      );

      final body = applicants.lastBody!;
      expect(body.firstName, 'Grace');
      expect(body.phoneNumber, '+70000000000');
      expect(body.contactDetails, 'tg:@grace');
      expect(body.shelter, 50);
      expect(applicants.lastShelterId, 50);
    });

    test('updateApplicant carries the id both in path and body', () async {
      await adapter.updateApplicant(
        7,
        const ApplicantWriteDto(id: 7, shelter: 50, firstName: 'Grace', lastName: 'Hopper', phoneNumber: '+7'),
        shelterId: 50,
      );

      expect(applicants.lastId, 7);
      expect(applicants.lastBody!.id, 7);
    });
  });

  group('curators', () {
    test('listCurators unwraps results and maps to DTO', () async {
      curators.listPage = PaginatedCuratorList(results: [_curator()]);

      final list = await adapter.listCurators(search: 'ada', shelterId: 50);

      expect(list, hasLength(1));
      expect(list.single.id, 9);
      expect(list.single.address, 'London');
      expect(curators.lastSearch, 'ada');
      expect(curators.lastShelterId, 50);
    });

    test('createCurator posts a body with shelter as a string', () async {
      await adapter.createCurator(
        const CuratorWriteDto(
          shelter: '50',
          firstName: 'Ada',
          lastName: 'Lovelace',
          phoneNumber: '+71111111111',
          address: 'London',
        ),
        shelterId: 50,
      );

      final body = curators.lastBody!;
      expect(body.firstName, 'Ada');
      expect(body.address, 'London');
      expect(body.shelter, '50');
    });

    test('updateCurator carries the id in path and body', () async {
      await adapter.updateCurator(
        9,
        const CuratorWriteDto(
          id: 9,
          shelter: '50',
          firstName: 'Ada',
          lastName: 'Lovelace',
          phoneNumber: '+7',
          address: 'X',
        ),
        shelterId: 50,
      );

      expect(curators.lastId, 9);
      expect(curators.lastBody!.id, 9);
    });
  });

  group('write DTO toJson', () {
    test('ApplicantWriteDto serializes snake_case and omits nulls', () {
      final json = const ApplicantWriteDto(firstName: 'A', lastName: 'B', phoneNumber: '+7').toJson();
      expect(json['first_name'], 'A');
      expect(json['phone_number'], '+7');
      expect(json.containsKey('id'), isFalse);
      expect(json.containsKey('email'), isFalse);
    });

    test('CuratorWriteDto serializes snake_case and omits nulls', () {
      final json = const CuratorWriteDto(firstName: 'A', lastName: 'B', phoneNumber: '+7', address: 'X').toJson();
      expect(json['first_name'], 'A');
      expect(json['address'], 'X');
      expect(json.containsKey('id'), isFalse);
    });
  });
}
