import 'package:util/util.dart';
import 'package:core/domain.dart';
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
  const role = CurrentShelterRole(currentShelterId: 1, role: 'ADMIN', canEdit: true, canDelete: true);

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

  group('PickShelterCubit — list opened by URL (no list anywhere)', () {
    test('loads the list itself: loading first, then the shelters', () async {
      when(() => auth.shelterList).thenReturn(const []);
      when(() => auth.getShelterList()).thenAnswer((_) async => const Ok(shelters));

      final cubit = build(autoSelectSingle: true);
      expect(cubit.state.status.isLoading, isTrue);

      await Future<void>.delayed(Duration.zero);
      expect(cubit.state.results, shelters);
      expect(cubit.state.status.isLoading, isFalse);
      expect(cubit.state.status.hasError, isFalse);
    });

    test('a failed load shows the error state and retry loads again', () async {
      when(() => auth.shelterList).thenReturn(const []);
      when(() => auth.getShelterList()).thenAnswer((_) async => const Err(AuthFailure()));

      final cubit = build(autoSelectSingle: true);
      await Future<void>.delayed(Duration.zero);
      expect(cubit.state.status, const DataError<Object>(AuthFailure()));

      when(() => auth.getShelterList()).thenAnswer((_) async => const Ok(shelters));
      cubit.retry();
      await Future<void>.delayed(Duration.zero);
      expect(cubit.state.results, shelters);
      expect(cubit.state.status.hasError, isFalse);
      verify(() => auth.getShelterList()).called(2);
    });

    test('a passed or session list does not trigger a load', () async {
      when(() => auth.shelterList).thenReturn(shelters);
      build(autoSelectSingle: true);
      build(autoSelectSingle: true, shelterList: shelters);
      verifyNever(() => auth.getShelterList());
    });
  });

  group('PickShelterCubit — pickShelter', () {
    test('applies shelter + config and returns true on success', () async {
      when(() => auth.shelterList).thenReturn(const []);
      when(() => auth.setCurrentShelter(1)).thenAnswer((_) async => Ok(role));
      when(() => config.initConfig(currentShelterId: 1)).thenAnswer((_) async => const Ok(null));

      final cubit = build(autoSelectSingle: false, shelterList: shelters);
      final ok = await cubit.pickShelter(0);

      expect(ok, isTrue);
      verify(() => auth.setCurrentShelter(1)).called(1);
      verify(() => config.initConfig(currentShelterId: 1)).called(1);
    });

    test('returns false and emits error status when apply fails', () async {
      when(() => auth.shelterList).thenReturn(const []);
      when(() => auth.setCurrentShelter(1)).thenAnswer((_) async => const Err(NoInternet()));

      final cubit = build(autoSelectSingle: false, shelterList: shelters);
      final ok = await cubit.pickShelter(0);

      expect(ok, isFalse);
      expect(cubit.state.status, const DataError<Object>(NoInternet()));
      verifyNever(() => config.initConfig(currentShelterId: any(named: 'currentShelterId')));
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
      when(() => auth.setCurrentShelter(1)).thenAnswer((_) async => Ok(role));
      when(() => config.initConfig(currentShelterId: 1)).thenAnswer((_) async => const Ok(null));

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
