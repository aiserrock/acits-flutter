import 'package:acits_core/acits_core.dart';
import 'package:acits_domain/acits_domain.dart';
import 'package:applicants/applicants.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockStaffService extends Mock implements StaffService {}

void main() {
  late MockStaffService service;

  setUpAll(
    () => registerFallbackValue(const Applicant(firstName: '', lastName: '', phoneNumber: '')),
  );

  setUp(() => service = MockStaffService());

  const draft = Applicant(firstName: 'Grace', lastName: 'Hopper', phoneNumber: '+7');
  const loaded = Applicant(id: 7, firstName: 'Ada', lastName: 'Lovelace', phoneNumber: '+1');

  group('create mode (no id)', () {
    test('initial state is empty content, no load performed', () {
      final cubit = ApplicantEditCubit(service);
      expect(cubit.isEdit, isFalse);
      expect(cubit.state, isA<DataContent<Applicant>>());
      expect(cubit.state.valueOrNull?.firstName, '');
      verifyNever(() => service.fetchApplicantById(id: any(named: 'id')));
    });

    test('submit creates applicant and returns the saved entity', () async {
      when(
        () => service.createApplicant(applicant: any(named: 'applicant')),
      ).thenAnswer((_) async => draft);
      final cubit = ApplicantEditCubit(service);

      final result = await cubit.submit(draft);

      expect(result, draft);
      verify(() => service.createApplicant(applicant: draft)).called(1);
      expect(cubit.state, isA<DataContent<Applicant>>());
    });

    test('submit failure emits error and returns null', () async {
      when(
        () => service.createApplicant(applicant: any(named: 'applicant')),
      ).thenThrow(Exception('boom'));
      final cubit = ApplicantEditCubit(service);

      final result = await cubit.submit(draft);

      expect(result, isNull);
      expect(cubit.state, isA<DataError<Applicant>>());
    });
  });

  group('edit mode (id given)', () {
    test('loads applicant by id on construction', () async {
      when(() => service.fetchApplicantById(id: 7)).thenAnswer((_) async => loaded);
      final cubit = ApplicantEditCubit(service, applicantId: 7);
      expect(cubit.isEdit, isTrue);

      await Future<void>.delayed(Duration.zero);

      expect(cubit.state.valueOrNull, loaded);
      verify(() => service.fetchApplicantById(id: 7)).called(1);
    });

    test('submit updates applicant', () async {
      when(() => service.fetchApplicantById(id: 7)).thenAnswer((_) async => loaded);
      when(
        () => service.updateApplicant(
          id: any(named: 'id'),
          applicant: any(named: 'applicant'),
        ),
      ).thenAnswer((_) async => loaded);
      final cubit = ApplicantEditCubit(service, applicantId: 7);
      await Future<void>.delayed(Duration.zero);

      final result = await cubit.submit(loaded);

      expect(result, loaded);
      verify(() => service.updateApplicant(id: 7, applicant: loaded)).called(1);
    });

    test('load failure emits error state', () async {
      when(() => service.fetchApplicantById(id: 7)).thenThrow(Exception('boom'));
      final cubit = ApplicantEditCubit(service, applicantId: 7);

      await Future<void>.delayed(Duration.zero);

      expect(cubit.state, isA<DataError<Applicant>>());
    });
  });
}
