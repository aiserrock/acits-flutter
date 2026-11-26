import 'package:core/core.dart';
import 'package:auth/auth.dart';
import 'package:app_services/app_services.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:util/util.dart';
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
    test('stores tokens on success', () async {
      when(() => api.login('u', 'p')).thenAnswer((_) async => const TokenPairDto(access: 'a', refresh: 'r'));
      await service.login('u', 'p');
      expect(service.access, 'a');
    });

    test('wrong credentials (401) become AuthFailure, not an exception', () async {
      when(() => api.login(any(), any())).thenThrow(_dio(401));
      expect((await service.login('u', 'p')).failureOrNull, const AuthFailure());
      expect(service.access, isNull);
    });

    test('a server error becomes ServerFailure carrying the status and body', () async {
      when(() => api.login(any(), any())).thenThrow(_dio(500));
      expect((await service.login('u', 'p')).failureOrNull, const ServerFailure(500, 'err'));
    });

    test('no connection becomes NoInternet', () async {
      when(() => api.login(any(), any())).thenThrow(
        DioException(
          requestOptions: RequestOptions(path: '/'),
          type: DioExceptionType.connectionError,
        ),
      );
      expect((await service.login('u', 'p')).failureOrNull, const NoInternet());
    });
  });

  group('refreshToken', () {
    DioException offline() => DioException(
      requestOptions: RequestOptions(path: '/'),
      type: DioExceptionType.connectionError,
    );

    test('returns the new access token on success', () async {
      when(() => api.refresh('r', any())).thenAnswer((_) async => const TokenRefreshDto(access: 'a2'));
      expect(await service.refreshToken(refresh: 'r'), 'a2');
      expect(service.access, 'a2');
    });

    test('returns null when the server rejects the refresh token', () async {
      when(() => api.refresh('r', any())).thenThrow(_dio(401));
      expect(await service.refreshToken(refresh: 'r'), isNull);
    });

    test('rethrows a network failure instead of reporting the session as ended', () async {
      when(() => api.refresh('r', any())).thenThrow(offline());
      await expectLater(service.refreshToken(refresh: 'r'), throwsA(isA<DioException>()));
    });

    test('rethrows a server error (5xx): the refresh token was not rejected', () async {
      when(() => api.refresh('r', any())).thenThrow(_dio(503));
      await expectLater(service.refreshToken(refresh: 'r'), throwsA(isA<DioException>()));
    });

    test('tryRefreshLastAuth is false without a network and leaves the stored refresh token alone', () async {
      when(() => authRepo.refresh).thenAnswer((_) async => 'r');
      when(() => api.refresh('r', any())).thenThrow(offline());
      expect(await service.tryRefreshLastAuth(), isFalse);
      verifyNever(() => authRepo.clearRefresh());
    });
  });

  group('getShelterList', () {
    test('maps ShelterShortDto list to Shelter entities and caches them', () async {
      when(
        () => api.myShelters(),
      ).thenAnswer((_) async => const [ShelterShortDto(id: 1, name: 'Alpha'), ShelterShortDto(id: 2, name: 'Beta')]);
      final result = (await service.getShelterList()).valueOrNull;
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
      final role = (await service.setCurrentShelter(5)).valueOrNull;
      expect(role, const CurrentShelterRole(currentShelterId: 5, role: 'WORKER', canEdit: true, canDelete: false));
      expect(service.currentShelterId, 5);
      verify(() => prefs.currentShelterId = 5).called(1);
    });

    test('tells session listeners which shelter became current', () async {
      when(() => api.setCurrentShelter(5)).thenAnswer(
        (_) async => const CurrentShelterDto(
          currentShelter: 5,
          currentShelterUserRole: 'WORKER',
          isUserCanEdit: false,
          isUserCanDelete: false,
        ),
      );
      final sessions = <int?>[];
      service.addSessionListener(sessions.add);

      await service.setCurrentShelter(5);

      expect(sessions, [5]);
    });

    test('does not notify session listeners when the shelter cannot be applied', () async {
      when(() => api.setCurrentShelter(5)).thenThrow(_dio(403));
      final sessions = <int?>[];
      service.addSessionListener(sessions.add);

      await service.setCurrentShelter(5);

      expect(sessions, isEmpty);
    });
  });

  group('restoreShelter', () {
    test('is false when the saved shelter can no longer be applied, and does not throw', () async {
      when(() => prefs.currentShelterId).thenReturn(5);
      when(() => api.setCurrentShelter(5)).thenThrow(_dio(403));
      expect(await service.restoreShelter(), isFalse);
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
    test('registrationAdmin maps input to a write DTO and returns Ok', () async {
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
      expect(ok.isOk, isTrue);

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
      expect(ok.isOk, isTrue);

      final captured = verify(() => api.registerWorker(captureAny())).captured.single as UserWorkerWriteDto;
      expect(captured.role, 'WORKER');
      expect(captured.shelter, 3);
    });
  });
}
