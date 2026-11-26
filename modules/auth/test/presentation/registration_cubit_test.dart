import 'package:core/domain.dart';
import 'package:util/util.dart';
import 'package:auth/auth.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockAuthSessionApi extends Mock implements AuthSessionApi {}

const _admin = AdminRegistrationInput(
  email: 'a@b.c',
  password: 'p',
  firstName: 'A',
  lastName: 'B',
  shelterName: 'S',
  country: 'RU',
  city: 'M',
);

const _worker = WorkerRegistrationInput(
  email: 'a@b.c',
  password: 'p',
  firstName: 'A',
  lastName: 'B',
  role: WorkerRole.worker,
  shelterId: 3,
);

void main() {
  late MockAuthSessionApi auth;

  setUpAll(() {
    registerFallbackValue(_admin);
    registerFallbackValue(_worker);
  });

  setUp(() {
    auth = MockAuthSessionApi();
  });

  RegistrationCubit build() => RegistrationCubit(authService: auth);

  group('RegistrationCubit — state flags', () {
    test('setShelter stores the picked shelter', () {
      final cubit = build();
      cubit.setShelter(const Shelter(id: 7, name: 'Gamma'));
      expect(cubit.state.shelter, const Shelter(id: 7, name: 'Gamma'));
    });

    test('onCustomerRoleChanged updates role', () {
      final cubit = build();
      cubit.onCustomerRoleChanged(CustomerRole.guest);
      expect(cubit.state.role, CustomerRole.guest);
    });

    test('onTabChanged resets policy agreement', () {
      final cubit = build();
      cubit.togglePersonData();
      expect(cubit.state.agreedToPolicy, isTrue);
      cubit.onTabChanged(1);
      expect(cubit.state.tabIndex, 1);
      expect(cubit.state.agreedToPolicy, isFalse);
    });
  });

  group('RegistrationCubit — submitAdmin', () {
    test('returns Ok and toggles submitting on success', () async {
      when(() => auth.registrationAdmin(any())).thenAnswer((_) async => const Ok(null));
      final cubit = build();
      expect((await cubit.submitAdmin(_admin))?.isOk, isTrue);
      expect(cubit.state.submitting, isFalse);
      verify(() => auth.registrationAdmin(_admin)).called(1);
    });

    test('returns the failure and clears submitting when the server refuses', () async {
      const refusal = ServerFailure(400, 'email: already registered');
      when(() => auth.registrationAdmin(any())).thenAnswer((_) async => const Err(refusal));
      final cubit = build();
      expect((await cubit.submitAdmin(_admin))?.failureOrNull, refusal);
      expect(cubit.state.submitting, isFalse);
    });
  });

  group('RegistrationCubit — submitCustomer', () {
    test('returns Ok on success', () async {
      when(() => auth.registrationCustomer(any())).thenAnswer((_) async => const Ok(null));
      final cubit = build();
      expect((await cubit.submitCustomer(_worker))?.isOk, isTrue);
      verify(() => auth.registrationCustomer(_worker)).called(1);
    });

    test('returns the failure when the request does not reach the server', () async {
      when(() => auth.registrationCustomer(any())).thenAnswer((_) async => const Err(NoInternet()));
      final cubit = build();
      expect((await cubit.submitCustomer(_worker))?.failureOrNull, const NoInternet());
      expect(cubit.state.submitting, isFalse);
    });
  });
}
