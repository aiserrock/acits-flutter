import 'package:acits_core/acits_core.dart';
import 'package:acits_domain/acits_domain.dart';
import 'package:auth/auth.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockAuthSessionApi extends Mock implements AuthSessionApi {}

class MockConfigInitializer extends Mock implements AuthConfigInitializer {}

void main() {
  late MockAuthSessionApi auth;
  late MockConfigInitializer config;

  setUp(() {
    auth = MockAuthSessionApi();
    config = MockConfigInitializer();
  });

  const shelters = [Shelter(id: 1, name: 'Alpha'), Shelter(id: 2, name: 'Beta')];

  PickShelterCubit build({required bool autoSelectSingle, List<Shelter>? shelterList}) => PickShelterCubit(
    authService: auth,
    configService: config,
    autoSelectSingle: autoSelectSingle,
    shelterList: shelterList,
  );

  group('PickShelterCubit — initial state', () {
    test('uses the passed shelter list', () {
      when(() => auth.shelterList).thenReturn(const []);
      final cubit = build(autoSelectSingle: false, shelterList: shelters);
      expect(cubit.state.results, shelters);
    });

    test('falls back to AuthSessionApi.shelterList when none passed', () {
      when(() => auth.shelterList).thenReturn(shelters);
      final cubit = build(autoSelectSingle: false);
      expect(cubit.state.results, shelters);
    });
  });

  group('PickShelterCubit — pickShelter', () {
    test('applies shelter + config and returns true on success', () async {
      when(() => auth.shelterList).thenReturn(const []);
      when(() => auth.setCurrentShelter(1)).thenAnswer((_) async {});
      when(() => config.initConfig(currentShelterId: 1)).thenAnswer((_) async {});

      final cubit = build(autoSelectSingle: false, shelterList: shelters);
      final ok = await cubit.pickShelter(0);

      expect(ok, isTrue);
      verify(() => auth.setCurrentShelter(1)).called(1);
      verify(() => config.initConfig(currentShelterId: 1)).called(1);
    });

    test('returns false and emits error status when apply fails', () async {
      when(() => auth.shelterList).thenReturn(const []);
      when(() => auth.setCurrentShelter(1)).thenThrow(MessagedException(message: 'boom'));

      final cubit = build(autoSelectSingle: false, shelterList: shelters);
      final ok = await cubit.pickShelter(0);

      expect(ok, isFalse);
      expect(cubit.state.status, isA<DataError<Object>>());
    });

    test('out-of-range index is a no-op', () async {
      when(() => auth.shelterList).thenReturn(const []);
      final cubit = build(autoSelectSingle: false, shelterList: shelters);
      expect(await cubit.pickShelter(5), isFalse);
      verifyNever(() => auth.setCurrentShelter(any()));
    });
  });

  group('PickShelterCubit — maybeAutoSelectSingle', () {
    test('auto-selects when exactly one shelter and flag on', () async {
      when(() => auth.shelterList).thenReturn(const []);
      when(() => auth.setCurrentShelter(1)).thenAnswer((_) async {});
      when(() => config.initConfig(currentShelterId: 1)).thenAnswer((_) async {});

      final cubit = build(autoSelectSingle: true, shelterList: const [Shelter(id: 1, name: 'Solo')]);
      expect(await cubit.maybeAutoSelectSingle(), isTrue);
      // Idempotent: second call is a no-op.
      expect(await cubit.maybeAutoSelectSingle(), isFalse);
    });

    test('does not auto-select with more than one shelter', () async {
      when(() => auth.shelterList).thenReturn(const []);
      final cubit = build(autoSelectSingle: true, shelterList: shelters);
      expect(await cubit.maybeAutoSelectSingle(), isFalse);
      verifyNever(() => auth.setCurrentShelter(any()));
    });
  });
}
