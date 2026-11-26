import 'package:util/util.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:personal/personal.dart';

class MockPersonalRepository extends Mock implements PersonalRepository {}

UserProfile _profile() => UserProfile(
  id: 1,
  username: 'grace',
  firstName: 'Grace',
  lastName: 'Hopper',
  fullName: 'Grace Hopper',
  email: 'g@n.mil',
  dateJoined: DateTime.utc(2020),
  isVerified: true,
);

void main() {
  late MockPersonalRepository repository;

  setUpAll(() {
    registerFallbackValue(_profile());
  });

  setUp(() {
    repository = MockPersonalRepository();
  });

  test('load emits content and returns the loaded user', () async {
    when(() => repository.fetchPersonal(force: any(named: 'force'))).thenAnswer((_) async => Ok(_profile()));

    final cubit = PersonalCubit(repository);
    final user = await cubit.load();

    expect(user?.id, 1);
    expect(cubit.state.data, isA<DataContent<UserProfile>>());
    expect(cubit.state.data.valueOrNull?.fullName, 'Grace Hopper');
    await cubit.close();
  });

  test('load emits the Failure and returns null on failure', () async {
    when(() => repository.fetchPersonal(force: any(named: 'force'))).thenAnswer((_) async => const Err(NoInternet()));

    final cubit = PersonalCubit(repository);
    final user = await cubit.load();

    expect(user, isNull);
    expect(cubit.state.data, isA<DataError<UserProfile>>());
    expect((cubit.state.data as DataError<UserProfile>).error, isA<NoInternet>());
    await cubit.close();
  });

  test('submit sends changed fields and lands on content', () async {
    when(() => repository.fetchPersonal(force: any(named: 'force'))).thenAnswer((_) async => Ok(_profile()));
    when(() => repository.changePersonal(any())).thenAnswer((_) async => Ok(_profile().copyWith(firstName: 'Ada')));

    final cubit = PersonalCubit(repository);
    await cubit.load();

    await cubit.submit(firstName: 'Ada', lastName: 'Hopper', fathersName: '', phoneNumber: '+7', email: 'g@n.mil');

    expect(cubit.state.data, isA<DataContent<UserProfile>>());
    expect(cubit.state.data.valueOrNull?.firstName, 'Ada');
    verify(() => repository.changePersonal(any())).called(1);
    await cubit.close();
  });

  test('submit emits the Failure when the repository fails', () async {
    when(() => repository.fetchPersonal(force: any(named: 'force'))).thenAnswer((_) async => Ok(_profile()));
    when(() => repository.changePersonal(any())).thenAnswer((_) async => const Err(ServerFailure(500, 'boom')));

    final cubit = PersonalCubit(repository);
    await cubit.load();

    await cubit.submit(firstName: 'Ada', lastName: 'Hopper', fathersName: '', phoneNumber: '+7', email: 'g@n.mil');

    expect(cubit.state.data, isA<DataError<UserProfile>>());
    expect((cubit.state.data as DataError<UserProfile>).error, const ServerFailure(500, 'boom'));
    await cubit.close();
  });
}
