import 'package:core/core.dart';
import 'package:applicants/applicants.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:util/util.dart';

class MockStaffApiPort extends Mock implements StaffApiPort {}

class MockShelterProvider extends Mock implements ApplicantsShelterProvider {}

ApplicantDto _applicantDto() => ApplicantDto(
  id: 7,
  url: 'u',
  shelter: 50,
  firstName: 'Grace',
  lastName: 'Hopper',
  email: 'g@n.mil',
  phoneNumber: '+7',
  contactDetails: 'tg',
  createdBy: 'a',
  updatedBy: 'a',
  createdAt: DateTime.utc(2024),
  updatedAt: DateTime.utc(2024),
);

CuratorDto _curatorDto() => CuratorDto(
  id: 9,
  url: 'u',
  shelter: '50',
  firstName: 'Ada',
  lastName: 'Lovelace',
  email: 'a@e.io',
  phoneNumber: '+7',
  address: 'London',
  createdBy: 'a',
  updatedBy: 'a',
  createdAt: DateTime.utc(2024),
  updatedAt: DateTime.utc(2024),
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
  late MockStaffApiPort port;
  late MockShelterProvider shelter;
  late StaffRepository repository;

  setUpAll(() {
    registerFallbackValue(const ApplicantWriteDto(firstName: '', lastName: '', phoneNumber: ''));
    registerFallbackValue(const CuratorWriteDto(firstName: '', lastName: '', phoneNumber: '', address: ''));
  });

  setUp(() {
    port = MockStaffApiPort();
    shelter = MockShelterProvider();
    when(() => shelter.shelterId).thenReturn(50);
    repository = StaffRepositoryImpl(shelter, port);
  });

  group('applicants', () {
    test('listApplicants maps DTO→domain entity inside Ok', () async {
      when(
        () => port.listApplicants(
          search: any(named: 'search'),
          limit: any(named: 'limit'),
          offset: any(named: 'offset'),
          shelterId: any(named: 'shelterId'),
        ),
      ).thenAnswer((_) async => [_applicantDto()]);

      final result = await repository.listApplicants(searchRequest: 'g');

      expect(result.isOk, isTrue);
      final list = result.valueOrNull!;
      expect(list, hasLength(1));
      expect(list.single, isA<Applicant>());
      expect(list.single.id, 7);
      expect(list.single.fullName, 'Grace Hopper');
      expect(list.single.contactDetails, 'tg');
    });

    test('createApplicant builds a write DTO scoped by the current shelter', () async {
      when(
        () => port.createApplicant(any(), shelterId: any(named: 'shelterId')),
      ).thenAnswer((_) async => _applicantDto());

      final result = await repository.createApplicant(
        const Applicant(firstName: 'Grace', lastName: 'Hopper', phoneNumber: '+7'),
      );

      expect(result.isOk, isTrue);
      final captured =
          verify(() => port.createApplicant(captureAny(), shelterId: 50)).captured.single as ApplicantWriteDto;
      expect(captured.firstName, 'Grace');
      expect(captured.shelter, 50);
    });

    test('listApplicants maps a bad-response DioException to Err(ServerFailure)', () async {
      when(
        () => port.listApplicants(
          search: any(named: 'search'),
          limit: any(named: 'limit'),
          offset: any(named: 'offset'),
          shelterId: any(named: 'shelterId'),
        ),
      ).thenThrow(_dioError());

      final result = await repository.listApplicants();

      expect(result.isErr, isTrue);
      expect(result.failureOrNull, isA<ServerFailure>());
      expect((result.failureOrNull! as ServerFailure).code, 400);
    });

    test('getApplicantById maps a 401 to Err(AuthFailure)', () async {
      when(() => port.getApplicant(any(), shelterId: any(named: 'shelterId'))).thenThrow(_dioError(statusCode: 401));

      final result = await repository.getApplicantById(7);

      expect(result.failureOrNull, isA<AuthFailure>());
    });
  });

  group('curators', () {
    test('listCurators maps DTO→domain entity inside Ok', () async {
      when(
        () => port.listCurators(
          search: any(named: 'search'),
          limit: any(named: 'limit'),
          offset: any(named: 'offset'),
          shelterId: any(named: 'shelterId'),
        ),
      ).thenAnswer((_) async => [_curatorDto()]);

      final result = await repository.listCurators();

      expect(result.isOk, isTrue);
      final curator = result.valueOrNull!.single;
      expect(curator, isA<Curator>());
      expect(curator.address, 'London');
      expect(curator.fullName, 'Ada Lovelace');
    });

    test('updateCurator sends the id + shelter as string', () async {
      when(
        () => port.updateCurator(any(), any(), shelterId: any(named: 'shelterId')),
      ).thenAnswer((_) async => _curatorDto());

      final result = await repository.updateCurator(
        9,
        const Curator(id: 9, firstName: 'Ada', lastName: 'Lovelace', phoneNumber: '+7', address: 'London'),
      );

      expect(result.isOk, isTrue);
      final captured =
          verify(() => port.updateCurator(9, captureAny(), shelterId: 50)).captured.single as CuratorWriteDto;
      expect(captured.id, 9);
      expect(captured.shelter, '50');
      expect(captured.address, 'London');
    });

    test('createCurator maps a connection error to Err(NoInternet)', () async {
      when(() => port.createCurator(any(), shelterId: any(named: 'shelterId'))).thenThrow(
        DioException(
          requestOptions: RequestOptions(path: '/'),
          type: DioExceptionType.connectionError,
        ),
      );

      final result = await repository.createCurator(
        const Curator(firstName: 'Ada', lastName: 'Lovelace', phoneNumber: '+7', address: 'London'),
      );

      expect(result.failureOrNull, isA<NoInternet>());
    });
  });

  group('StaffService thin wrapper (media search adapter)', () {
    test('fetchApplicants unwraps Ok to a plain list', () async {
      when(
        () => port.listApplicants(
          search: any(named: 'search'),
          limit: any(named: 'limit'),
          offset: any(named: 'offset'),
          shelterId: any(named: 'shelterId'),
        ),
      ).thenAnswer((_) async => [_applicantDto()]);

      final list = await StaffService(repository).fetchApplicants(searchRequest: 'g');

      expect(list, hasLength(1));
      expect(list.single.id, 7);
    });

    // The wrapper must NOT swallow the failure: SearchBloc catches it and shows
    // a retry stub. An empty list would read as "nothing found" and would also
    // latch isReachedMax, ending pagination for the rest of the session.
    test('fetchCurators throws the Failure so the search screen can show it', () async {
      when(
        () => port.listCurators(
          search: any(named: 'search'),
          limit: any(named: 'limit'),
          offset: any(named: 'offset'),
          shelterId: any(named: 'shelterId'),
        ),
      ).thenThrow(_dioError());

      await expectLater(StaffService(repository).fetchCurators(), throwsA(isA<Failure>()));
    });
  });
}
