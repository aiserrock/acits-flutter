import 'package:acits_domain/acits_domain.dart';
import 'package:auth/auth.dart';
import 'package:auth/ui/registration/cubit/registration_cubit.dart';
import 'package:auth/ui/registration/cubit/registration_state.dart';
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
    test('returns true and toggles submitting on success', () async {
      when(() => auth.registrationAdmin(any())).thenAnswer((_) async => true);
      final cubit = build();
      final ok = await cubit.submitAdmin(_admin);
      expect(ok, isTrue);
      expect(cubit.state.submitting, isFalse);
      verify(() => auth.registrationAdmin(_admin)).called(1);
    });

    test('rethrows and clears submitting on failure', () async {
      when(() => auth.registrationAdmin(any())).thenThrow(MessagedException(message: 'bad'));
      final cubit = build();
      await expectLater(cubit.submitAdmin(_admin), throwsA(isA<MessagedException>()));
      expect(cubit.state.submitting, isFalse);
    });
  });

  group('RegistrationCubit — submitCustomer', () {
    test('returns true on success', () async {
      when(() => auth.registrationCustomer(any())).thenAnswer((_) async => true);
      final cubit = build();
      expect(await cubit.submitCustomer(_worker), isTrue);
      verify(() => auth.registrationCustomer(_worker)).called(1);
    });

    test('rethrows on failure', () async {
      when(() => auth.registrationCustomer(any())).thenThrow(MessagedException(message: 'bad'));
      final cubit = build();
      await expectLater(cubit.submitCustomer(_worker), throwsA(isA<MessagedException>()));
      expect(cubit.state.submitting, isFalse);
    });
  });
}
