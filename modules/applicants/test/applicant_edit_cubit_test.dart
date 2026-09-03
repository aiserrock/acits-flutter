import 'package:util/util.dart';
import 'package:core/domain.dart';
import 'package:applicants/applicants.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockStaffRepository extends Mock implements StaffRepository {}

void main() {
  late MockStaffRepository repository;

  setUpAll(() => registerFallbackValue(const Applicant(firstName: '', lastName: '', phoneNumber: '')));

  setUp(() => repository = MockStaffRepository());

  const draft = Applicant(firstName: 'Grace', lastName: 'Hopper', phoneNumber: '+7');
  const loaded = Applicant(id: 7, firstName: 'Ada', lastName: 'Lovelace', phoneNumber: '+1');

  group('create mode (no id)', () {
    test('initial state is empty content, no load performed', () {
      final cubit = ApplicantEditCubit(repository);
      expect(cubit.isEdit, isFalse);
      expect(cubit.state, isA<DataContent<Applicant>>());
      expect(cubit.state.valueOrNull?.firstName, '');
      verifyNever(() => repository.getApplicantById(any()));
    });

    test('submit creates applicant and returns the saved entity', () async {
      when(() => repository.createApplicant(any())).thenAnswer((_) async => const Ok(draft));
      final cubit = ApplicantEditCubit(repository);

      final result = await cubit.submit(draft);

      expect(result, draft);
      verify(() => repository.createApplicant(draft)).called(1);
      expect(cubit.state, isA<DataContent<Applicant>>());
    });

    test('submit failure emits error with the Failure and returns null', () async {
      when(() => repository.createApplicant(any())).thenAnswer((_) async => const Err(ServerFailure(500)));
      final cubit = ApplicantEditCubit(repository);

      final result = await cubit.submit(draft);

      expect(result, isNull);
      expect(cubit.state, isA<DataError<Applicant>>());
      expect((cubit.state as DataError<Applicant>).error, const ServerFailure(500));
    });
  });

  group('edit mode (id given)', () {
    test('loads applicant by id on construction', () async {
      when(() => repository.getApplicantById(7)).thenAnswer((_) async => const Ok(loaded));
      final cubit = ApplicantEditCubit(repository, applicantId: 7);
      expect(cubit.isEdit, isTrue);

      await Future<void>.delayed(Duration.zero);

      expect(cubit.state.valueOrNull, loaded);
      verify(() => repository.getApplicantById(7)).called(1);
    });

    test('submit updates applicant', () async {
      when(() => repository.getApplicantById(7)).thenAnswer((_) async => const Ok(loaded));
      when(() => repository.updateApplicant(any(), any())).thenAnswer((_) async => const Ok(loaded));
      final cubit = ApplicantEditCubit(repository, applicantId: 7);
      await Future<void>.delayed(Duration.zero);

      final result = await cubit.submit(loaded);

      expect(result, loaded);
      verify(() => repository.updateApplicant(7, loaded)).called(1);
    });

    test('load failure emits error state', () async {
      when(() => repository.getApplicantById(7)).thenAnswer((_) async => const Err(NoInternet()));
      final cubit = ApplicantEditCubit(repository, applicantId: 7);

      await Future<void>.delayed(Duration.zero);

      expect(cubit.state, isA<DataError<Applicant>>());
      expect((cubit.state as DataError<Applicant>).error, isA<NoInternet>());
    });
  });
}
