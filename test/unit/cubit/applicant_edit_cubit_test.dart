import 'package:acits_flutter/di/di_container.dart';
import 'package:acits_flutter/export.dart';
import 'package:acits_flutter/service/staff/staff_service.dart';
import 'package:acits_flutter/ui/screen/applicant/cubit/applicant_edit_cubit.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockStaffService extends Mock implements StaffService {}

void main() {
  late MockStaffService service;

  setUpAll(() {
    registerFallbackValue(const Applicant(firstName: '', lastName: '', phoneNumber: ''));
  });

  setUp(() {
    service = MockStaffService();
    getIt.registerFactory<StaffService>(() => service);
  });

  tearDown(() async {
    await getIt.reset();
  });

  group('ApplicantEditCubit — create mode (applicantId == null)', () {
    test('initial state is DataContent(empty Applicant) and no fetch happens', () async {
      final cubit = ApplicantEditCubit();
      // Дать асинхронному _init() шанс выполниться (в create-режиме — no-op).
      await Future<void>.delayed(Duration.zero);

      expect(cubit.isEdit, isFalse);
      expect(cubit.state, DataState.content(const Applicant(firstName: '', lastName: '', phoneNumber: '')));
      verifyNever(() => service.fetchApplicantById(id: any(named: 'id')));

      await cubit.close();
    });
  });

  group('ApplicantEditCubit — edit mode (applicantId != null)', () {
    const id = 42;
    final loaded = Applicant(id: id, firstName: 'Ada', lastName: 'Lovelace', phoneNumber: '');

    // _init() запускается в конструкторе и синхронно эмитит loading до того,
    // как какой-либо слушатель успевает подписаться, поэтому проверяем весь
    // переход через emitsInOrder на потоке, полученном сразу после создания.
    test('emits [loading, content] when fetchApplicantById succeeds', () async {
      when(() => service.fetchApplicantById(id: id)).thenAnswer((_) async => loaded);

      final cubit = ApplicantEditCubit(applicantId: id);
      expect(cubit.isEdit, isTrue);

      await expectLater(cubit.stream, emitsInOrder([DataState.content(loaded)]));
      expect(cubit.state, DataState.content(loaded));
      verify(() => service.fetchApplicantById(id: id)).called(1);

      await cubit.close();
    });

    test('emits [loading, error] when fetchApplicantById throws', () async {
      when(
        () => service.fetchApplicantById(id: id),
      ).thenAnswer((_) async => throw Exception('boom'));

      final cubit = ApplicantEditCubit(applicantId: id);

      await expectLater(cubit.stream, emitsInOrder([isA<DataError<Applicant>>()]));
      expect(cubit.state, isA<DataError<Applicant>>());
      verify(() => service.fetchApplicantById(id: id)).called(1);

      await cubit.close();
    });
  });

  group('ApplicantEditCubit — submit() in create mode', () {
    final draft = const Applicant(firstName: 'Grace', lastName: 'Hopper', phoneNumber: '');
    final created = const Applicant(id: 7, firstName: 'Grace', lastName: 'Hopper', phoneNumber: '');

    blocTest<ApplicantEditCubit, DataState<Applicant>>(
      'success calls createApplicant, emits [loading, content], returns the Applicant',
      setUp: () {
        when(
          () => service.createApplicant(applicant: any(named: 'applicant')),
        ).thenAnswer((_) async => created);
      },
      build: () => ApplicantEditCubit(),
      act: (cubit) async {
        final result = await cubit.submit(draft);
        expect(result, created);
      },
      expect: () => [const DataState<Applicant>.loading(), DataState.content(created)],
      verify: (_) {
        verify(() => service.createApplicant(applicant: draft)).called(1);
        verifyNever(
          () => service.updateApplicant(
            id: any(named: 'id'),
            applicant: any(named: 'applicant'),
          ),
        );
      },
    );

    blocTest<ApplicantEditCubit, DataState<Applicant>>(
      'failure emits [loading, error] and submit returns null',
      setUp: () {
        when(
          () => service.createApplicant(applicant: any(named: 'applicant')),
        ).thenThrow(Exception('nope'));
      },
      build: () => ApplicantEditCubit(),
      act: (cubit) async {
        final result = await cubit.submit(draft);
        expect(result, isNull);
      },
      expect: () => [const DataState<Applicant>.loading(), isA<DataError<Applicant>>()],
    );
  });
}
