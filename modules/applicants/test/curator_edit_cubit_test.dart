import 'package:acits_core/acits_core.dart';
import 'package:acits_domain/acits_domain.dart';
import 'package:applicants/applicants.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockStaffService extends Mock implements StaffService {}

void main() {
  late MockStaffService service;

  setUpAll(() => registerFallbackValue(const Curator(firstName: '', lastName: '', phoneNumber: '', address: '')));

  setUp(() => service = MockStaffService());

  const draft = Curator(firstName: 'Ada', lastName: 'Lovelace', phoneNumber: '+7', address: 'London');
  const loaded = Curator(id: 9, firstName: 'Grace', lastName: 'Hopper', phoneNumber: '+1', address: 'NY');

  group('create mode (no id)', () {
    test('initial state is empty content, no load performed', () {
      final cubit = CuratorEditCubit(service);
      expect(cubit.isEdit, isFalse);
      expect(cubit.state, isA<DataContent<Curator>>());
      expect(cubit.state.valueOrNull?.address, '');
      verifyNever(() => service.fetchCuratorById(id: any(named: 'id')));
    });

    test('submit creates curator and returns the saved entity', () async {
      when(() => service.createCurator(curator: any(named: 'curator'))).thenAnswer((_) async => draft);
      final cubit = CuratorEditCubit(service);

      final result = await cubit.submit(draft);

      expect(result, draft);
      verify(() => service.createCurator(curator: draft)).called(1);
      expect(cubit.state, isA<DataContent<Curator>>());
    });

    test('submit failure emits error and returns null', () async {
      when(() => service.createCurator(curator: any(named: 'curator'))).thenThrow(Exception('boom'));
      final cubit = CuratorEditCubit(service);

      final result = await cubit.submit(draft);

      expect(result, isNull);
      expect(cubit.state, isA<DataError<Curator>>());
    });
  });

  group('edit mode (id given)', () {
    test('loads curator by id on construction', () async {
      when(() => service.fetchCuratorById(id: 9)).thenAnswer((_) async => loaded);
      final cubit = CuratorEditCubit(service, curatorId: 9);
      expect(cubit.isEdit, isTrue);

      await Future<void>.delayed(Duration.zero);

      expect(cubit.state.valueOrNull, loaded);
      verify(() => service.fetchCuratorById(id: 9)).called(1);
    });

    test('submit updates curator', () async {
      when(() => service.fetchCuratorById(id: 9)).thenAnswer((_) async => loaded);
      when(
        () => service.updateCurator(
          id: any(named: 'id'),
          curator: any(named: 'curator'),
        ),
      ).thenAnswer((_) async => loaded);
      final cubit = CuratorEditCubit(service, curatorId: 9);
      await Future<void>.delayed(Duration.zero);

      final result = await cubit.submit(loaded);

      expect(result, loaded);
      verify(() => service.updateCurator(id: 9, curator: loaded)).called(1);
    });

    test('load failure emits error state', () async {
      when(() => service.fetchCuratorById(id: 9)).thenThrow(Exception('boom'));
      final cubit = CuratorEditCubit(service, curatorId: 9);

      await Future<void>.delayed(Duration.zero);

      expect(cubit.state, isA<DataError<Curator>>());
    });
  });
}
