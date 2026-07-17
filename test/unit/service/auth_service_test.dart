import 'package:acits_api/acits_api.dart';
import 'package:acits_domain/acits_domain.dart';
import 'package:acits_flutter/domain/registration_input.dart';
import 'package:acits_flutter/service/auth/auth_repository.dart';
import 'package:acits_flutter/service/auth/auth_service.dart';
import 'package:acits_flutter/service/auth/email_confirm_repository.dart';
import 'package:acits_flutter/service/shared_pref/preference_storage.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockAuthApiPort extends Mock implements AuthApiPort {}

class MockAuthRepository extends Mock implements AuthRepository {}

class MockEmailConfirmRepository extends Mock implements EmailConfirmRepository {}

class MockPreferenceStorage extends Mock implements PreferenceStorage {}

DioException _dio(int status) => DioException(
  requestOptions: RequestOptions(path: '/'),
  response: Response(
    requestOptions: RequestOptions(path: '/'),
    statusCode: status,
    data: 'err',
  ),
  type: DioExceptionType.badResponse,
);

void main() {
  late MockAuthApiPort api;
  late MockAuthRepository authRepo;
  late MockEmailConfirmRepository confirmRepo;
  late MockPreferenceStorage prefs;
  late AuthService service;

  setUpAll(() {
    registerFallbackValue(
      const UserAdminWriteDto(
        email: '',
        password: '',
        rePassword: '',
        firstName: '',
        lastName: '',
        isOfferSigned: true,
        shelter: ShelterWriteDto(name: '', country: '', city: ''),
      ),
    );
    registerFallbackValue(
      const UserWorkerWriteDto(
        email: '',
        password: '',
        rePassword: '',
        firstName: '',
        lastName: '',
        role: 'GUEST',
        isOfferSigned: true,
      ),
    );
  });

  setUp(() {
    api = MockAuthApiPort();
    authRepo = MockAuthRepository();
    confirmRepo = MockEmailConfirmRepository();
    prefs = MockPreferenceStorage();
    when(() => authRepo.setRefresh(any())).thenAnswer((_) async {});
    service = AuthService(api, authRepo, confirmRepo, prefs);
  });

  group('login', () {
    test('stores tokens and returns pair on success', () async {
      when(() => api.login('u', 'p')).thenAnswer((_) async => const TokenPairDto(access: 'a', refresh: 'r'));
      final result = await service.login('u', 'p');
      expect(result?.access, 'a');
      expect(service.access, 'a');
    });

    test('maps 401 to NotAuthorizedException', () async {
      when(() => api.login(any(), any())).thenThrow(_dio(401));
      await expectLater(service.login('u', 'p'), throwsA(isA<NotAuthorizedException>()));
    });

    test('maps other errors to MessagedException', () async {
      when(() => api.login(any(), any())).thenThrow(_dio(500));
      await expectLater(service.login('u', 'p'), throwsA(isA<MessagedException>()));
    });
  });

  group('getShelterList', () {
    test('maps ShelterShortDto list to Shelter entities and caches them', () async {
      when(
        () => api.myShelters(),
      ).thenAnswer((_) async => const [ShelterShortDto(id: 1, name: 'Alpha'), ShelterShortDto(id: 2, name: 'Beta')]);
      final result = await service.getShelterList();
      expect(result, const [Shelter(id: 1, name: 'Alpha'), Shelter(id: 2, name: 'Beta')]);
      expect(service.shelterList, result);
    });
  });

  group('setCurrentShelter', () {
    test('maps CurrentShelterDto to CurrentShelterRole and remembers id', () async {
      when(() => api.setCurrentShelter(5)).thenAnswer(
        (_) async => const CurrentShelterDto(
          currentShelter: 5,
          currentShelterUserRole: 'WORKER',
          isUserCanEdit: true,
          isUserCanDelete: false,
        ),
      );
      final role = await service.setCurrentShelter(5);
      expect(role, const CurrentShelterRole(currentShelterId: 5, role: 'WORKER', canEdit: true, canDelete: false));
      expect(service.currentShelterId, 5);
      verify(() => prefs.currentShelterId = 5).called(1);
    });
  });

  group('currentShelter', () {
    test('resolves the current shelter entity from the cached list', () async {
      when(() => api.myShelters()).thenAnswer((_) async => const [ShelterShortDto(id: 5, name: 'Cur')]);
      when(() => api.setCurrentShelter(5)).thenAnswer(
        (_) async => const CurrentShelterDto(
          currentShelter: 5,
          currentShelterUserRole: 'WORKER',
          isUserCanEdit: false,
          isUserCanDelete: false,
        ),
      );
      await service.getShelterList();
      await service.setCurrentShelter(5);
      expect(service.currentShelter, const Shelter(id: 5, name: 'Cur'));
    });
  });

  group('registration', () {
    test('registrationAdmin maps input to a write DTO and returns true', () async {
      when(() => api.registerAdmin(any())).thenAnswer(
        (_) async => const UserAdminDto(id: 1, firstName: 'A', lastName: 'B', email: 'a@b.c', isOfferSigned: true),
      );
      final ok = await service.registrationAdmin(
        const AdminRegistrationInput(
          email: 'a@b.c',
          password: 'p',
          firstName: 'A',
          lastName: 'B',
          shelterName: 'S',
          country: 'RU',
          city: 'M',
        ),
      );
      expect(ok, isTrue);

      final captured = verify(() => api.registerAdmin(captureAny())).captured.single as UserAdminWriteDto;
      expect(captured.email, 'a@b.c');
      expect(captured.rePassword, 'p');
      expect(captured.shelter.name, 'S');
    });

    test('registrationCustomer maps role and shelter id onto the write DTO', () async {
      when(() => api.registerWorker(any())).thenAnswer(
        (_) async =>
            const UserWorkerDto(firstName: 'A', lastName: 'B', email: 'a@b.c', role: 'WORKER', isOfferSigned: true),
      );
      final ok = await service.registrationCustomer(
        const WorkerRegistrationInput(
          email: 'a@b.c',
          password: 'p',
          firstName: 'A',
          lastName: 'B',
          role: WorkerRole.worker,
          shelterId: 3,
        ),
      );
      expect(ok, isTrue);

      final captured = verify(() => api.registerWorker(captureAny())).captured.single as UserWorkerWriteDto;
      expect(captured.role, 'WORKER');
      expect(captured.shelter, 3);
    });
  });
}
