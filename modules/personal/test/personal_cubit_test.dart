import 'package:base/base.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:personal/personal.dart';

class MockPersonalService extends Mock implements PersonalService {}

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
  late MockPersonalService service;

  setUpAll(() {
    registerFallbackValue(_profile());
  });

  setUp(() {
    service = MockPersonalService();
  });

  test('load emits content and returns the loaded user', () async {
    when(() => service.fetchPersonal(force: any(named: 'force'))).thenAnswer((_) async => _profile());

    final cubit = PersonalCubit(service);
    final user = await cubit.load();

    expect(user?.id, 1);
    expect(cubit.state.data, isA<DataContent<UserProfile>>());
    expect(cubit.state.data.valueOrNull?.fullName, 'Grace Hopper');
    await cubit.close();
  });

  test('load emits error and returns null on failure', () async {
    when(() => service.fetchPersonal(force: any(named: 'force'))).thenThrow(Exception('boom'));

    final cubit = PersonalCubit(service);
    final user = await cubit.load();

    expect(user, isNull);
    expect(cubit.state.data, isA<DataError<UserProfile>>());
    await cubit.close();
  });

  test('submit sends changed fields and lands on content', () async {
    when(() => service.fetchPersonal(force: any(named: 'force'))).thenAnswer((_) async => _profile());
    when(() => service.changePersonal(any())).thenAnswer((_) async => _profile().copyWith(firstName: 'Ada'));

    final cubit = PersonalCubit(service);
    await cubit.load();

    await cubit.submit(firstName: 'Ada', lastName: 'Hopper', fathersName: '', phoneNumber: '+7', email: 'g@n.mil');

    expect(cubit.state.data, isA<DataContent<UserProfile>>());
    expect(cubit.state.data.valueOrNull?.firstName, 'Ada');
    verify(() => service.changePersonal(any())).called(1);
    await cubit.close();
  });
}
