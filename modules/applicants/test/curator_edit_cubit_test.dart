import 'package:util/util.dart';
import 'package:core/domain.dart';
import 'package:applicants/applicants.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockStaffRepository extends Mock implements StaffRepository {}

void main() {
  late MockStaffRepository repository;

  setUpAll(() => registerFallbackValue(const Curator(firstName: '', lastName: '', phoneNumber: '', address: '')));

  setUp(() => repository = MockStaffRepository());

  const draft = Curator(firstName: 'Ada', lastName: 'Lovelace', phoneNumber: '+7', address: 'London');
  const loaded = Curator(id: 9, firstName: 'Grace', lastName: 'Hopper', phoneNumber: '+1', address: 'NY');

  group('create mode (no id)', () {
    test('initial state is empty content, no load performed', () {
      final cubit = CuratorEditCubit(repository);
      expect(cubit.isEdit, isFalse);
      expect(cubit.state, isA<DataContent<Curator>>());
      expect(cubit.state.valueOrNull?.address, '');
      verifyNever(() => repository.getCuratorById(any()));
    });

    test('submit creates curator and returns the saved entity', () async {
      when(() => repository.createCurator(any())).thenAnswer((_) async => const Ok(draft));
      final cubit = CuratorEditCubit(repository);

      final result = await cubit.submit(draft);

      expect(result, draft);
      verify(() => repository.createCurator(draft)).called(1);
      expect(cubit.state, isA<DataContent<Curator>>());
    });

    test('submit failure emits error with the Failure and returns null', () async {
      when(() => repository.createCurator(any())).thenAnswer((_) async => const Err(ServerFailure(500)));
      final cubit = CuratorEditCubit(repository);

      final result = await cubit.submit(draft);

      expect(result, isNull);
      expect(cubit.state, isA<DataError<Curator>>());
      expect((cubit.state as DataError<Curator>).error, const ServerFailure(500));
    });
  });

  group('edit mode (id given)', () {
    test('loads curator by id on construction', () async {
      when(() => repository.getCuratorById(9)).thenAnswer((_) async => const Ok(loaded));
      final cubit = CuratorEditCubit(repository, curatorId: 9);
      expect(cubit.isEdit, isTrue);

      await Future<void>.delayed(Duration.zero);

      expect(cubit.state.valueOrNull, loaded);
      verify(() => repository.getCuratorById(9)).called(1);
    });

    test('submit updates curator', () async {
      when(() => repository.getCuratorById(9)).thenAnswer((_) async => const Ok(loaded));
      when(() => repository.updateCurator(any(), any())).thenAnswer((_) async => const Ok(loaded));
      final cubit = CuratorEditCubit(repository, curatorId: 9);
      await Future<void>.delayed(Duration.zero);

      final result = await cubit.submit(loaded);

      expect(result, loaded);
      verify(() => repository.updateCurator(9, loaded)).called(1);
    });

    test('load failure emits error state', () async {
      when(() => repository.getCuratorById(9)).thenAnswer((_) async => const Err(NoInternet()));
      final cubit = CuratorEditCubit(repository, curatorId: 9);

      await Future<void>.delayed(Duration.zero);

      expect(cubit.state, isA<DataError<Curator>>());
      expect((cubit.state as DataError<Curator>).error, isA<NoInternet>());
    });
  });
}
