import 'package:acits_api/acits_api.dart';
import 'package:acits_domain/acits_domain.dart';
import 'package:acits_flutter/domain/exception.dart';
import 'package:acits_flutter/service/auth/auth_service.dart';
import 'package:acits_flutter/service/staff/staff_service.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockStaffApiPort extends Mock implements StaffApiPort {}

class MockAuthService extends Mock implements AuthService {}

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

DioException _dioError() => DioException(
  requestOptions: RequestOptions(path: '/'),
  response: Response(
    requestOptions: RequestOptions(path: '/'),
    data: 'boom',
    statusCode: 400,
  ),
);

void main() {
  late MockStaffApiPort port;
  late MockAuthService auth;
  late StaffService service;

  setUpAll(() {
    registerFallbackValue(const ApplicantWriteDto(firstName: '', lastName: '', phoneNumber: ''));
    registerFallbackValue(const CuratorWriteDto(firstName: '', lastName: '', phoneNumber: '', address: ''));
  });

  setUp(() {
    port = MockStaffApiPort();
    auth = MockAuthService();
    when(() => auth.currentShelterId).thenReturn(50);
    service = StaffService(auth, port);
  });

  group('applicants', () {
    test('fetchApplicants maps DTO→domain entity', () async {
      when(
        () => port.listApplicants(
          search: any(named: 'search'),
          limit: any(named: 'limit'),
          offset: any(named: 'offset'),
          shelterId: any(named: 'shelterId'),
        ),
      ).thenAnswer((_) async => [_applicantDto()]);

      final list = await service.fetchApplicants(searchRequest: 'g');

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

      await service.createApplicant(
        applicant: const Applicant(firstName: 'Grace', lastName: 'Hopper', phoneNumber: '+7'),
      );

      final captured =
          verify(() => port.createApplicant(captureAny(), shelterId: 50)).captured.single as ApplicantWriteDto;
      expect(captured.firstName, 'Grace');
      expect(captured.shelter, 50);
    });

    test('fetchApplicants wraps DioException into MessagedException', () async {
      when(
        () => port.listApplicants(
          search: any(named: 'search'),
          limit: any(named: 'limit'),
          offset: any(named: 'offset'),
          shelterId: any(named: 'shelterId'),
        ),
      ).thenThrow(_dioError());

      expect(service.fetchApplicants(), throwsA(isA<MessagedException>()));
    });
  });

  group('curators', () {
    test('fetchCurators maps DTO→domain entity', () async {
      when(
        () => port.listCurators(
          search: any(named: 'search'),
          limit: any(named: 'limit'),
          offset: any(named: 'offset'),
          shelterId: any(named: 'shelterId'),
        ),
      ).thenAnswer((_) async => [_curatorDto()]);

      final list = await service.fetchCurators();

      expect(list.single, isA<Curator>());
      expect(list.single.address, 'London');
      expect(list.single.fullName, 'Ada Lovelace');
    });

    test('updateCurator sends the id + shelter as string', () async {
      when(
        () => port.updateCurator(any(), any(), shelterId: any(named: 'shelterId')),
      ).thenAnswer((_) async => _curatorDto());

      await service.updateCurator(
        id: 9,
        curator: const Curator(id: 9, firstName: 'Ada', lastName: 'Lovelace', phoneNumber: '+7', address: 'London'),
      );

      final captured =
          verify(() => port.updateCurator(9, captureAny(), shelterId: 50)).captured.single as CuratorWriteDto;
      expect(captured.id, 9);
      expect(captured.shelter, '50');
      expect(captured.address, 'London');
    });
  });
}
