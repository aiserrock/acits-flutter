import 'package:acits_domain/acits_domain.dart';
import 'package:acits_flutter/di/di_container.dart';
import 'package:acits_flutter/domain/exception.dart';
import 'package:acits_flutter/service/auth/auth_service.dart';
import 'package:acits_flutter/service/config/config_service.dart';
import 'package:acits_flutter/ui/screen/auth/cubit/pick_shelter_cubit.dart';
import 'package:acits_flutter/util/data_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockAuthService extends Mock implements AuthService {}

class MockConfigService extends Mock implements ConfigService {}

void main() {
  late MockAuthService auth;
  late MockConfigService config;

  setUp(() {
    auth = MockAuthService();
    config = MockConfigService();
    getIt.registerFactory<AuthService>(() => auth);
    getIt.registerFactory<ConfigService>(() => config);
  });

  tearDown(() async => getIt.reset());

  const shelters = [Shelter(id: 1, name: 'Alpha'), Shelter(id: 2, name: 'Beta')];

  group('PickShelterCubit — initial state', () {
    test('uses the passed shelter list', () {
      when(() => auth.shelterList).thenReturn(const []);
      final cubit = PickShelterCubit(autoSelectSingle: false, shelterList: shelters);
      expect(cubit.state.results, shelters);
    });

    test('falls back to AuthService.shelterList when none passed', () {
      when(() => auth.shelterList).thenReturn(shelters);
      final cubit = PickShelterCubit(autoSelectSingle: false);
      expect(cubit.state.results, shelters);
    });
  });

  group('PickShelterCubit — pickShelter', () {
    test('applies shelter + config and returns true on success', () async {
      when(() => auth.shelterList).thenReturn(const []);
      when(() => auth.setCurrentShelter(1)).thenAnswer(
        (_) async => const CurrentShelterRole(
          currentShelterId: 1,
          role: 'ADMIN',
          canEdit: true,
          canDelete: true,
        ),
      );
      when(() => config.initConfig(currentShelterId: 1)).thenAnswer((_) async {});

      final cubit = PickShelterCubit(autoSelectSingle: false, shelterList: shelters);
      final ok = await cubit.pickShelter(0);

      expect(ok, isTrue);
      verify(() => auth.setCurrentShelter(1)).called(1);
      verify(() => config.initConfig(currentShelterId: 1)).called(1);
    });

    test('returns false and emits error status when apply fails', () async {
      when(() => auth.shelterList).thenReturn(const []);
      when(() => auth.setCurrentShelter(1)).thenThrow(MessagedException(message: 'boom'));

      final cubit = PickShelterCubit(autoSelectSingle: false, shelterList: shelters);
      final ok = await cubit.pickShelter(0);

      expect(ok, isFalse);
      expect(cubit.state.status, isA<DataError<Object>>());
    });

    test('out-of-range index is a no-op', () async {
      when(() => auth.shelterList).thenReturn(const []);
      final cubit = PickShelterCubit(autoSelectSingle: false, shelterList: shelters);
      expect(await cubit.pickShelter(5), isFalse);
      verifyNever(() => auth.setCurrentShelter(any()));
    });
  });

  group('PickShelterCubit — maybeAutoSelectSingle', () {
    test('auto-selects when exactly one shelter and flag on', () async {
      when(() => auth.shelterList).thenReturn(const []);
      when(() => auth.setCurrentShelter(1)).thenAnswer(
        (_) async => const CurrentShelterRole(
          currentShelterId: 1,
          role: 'ADMIN',
          canEdit: true,
          canDelete: true,
        ),
      );
      when(() => config.initConfig(currentShelterId: 1)).thenAnswer((_) async {});

      final cubit = PickShelterCubit(
        autoSelectSingle: true,
        shelterList: const [Shelter(id: 1, name: 'Solo')],
      );
      expect(await cubit.maybeAutoSelectSingle(), isTrue);
      // Idempotent: second call is a no-op.
      expect(await cubit.maybeAutoSelectSingle(), isFalse);
    });

    test('does not auto-select with more than one shelter', () async {
      when(() => auth.shelterList).thenReturn(const []);
      final cubit = PickShelterCubit(autoSelectSingle: true, shelterList: shelters);
      expect(await cubit.maybeAutoSelectSingle(), isFalse);
      verifyNever(() => auth.setCurrentShelter(any()));
    });
  });
}
