import 'package:acits_flutter/di/di_container.dart';
import 'package:acits_flutter/domain/user_profile.dart';
import 'package:acits_flutter/service/personal/personal_service.dart';
import 'package:acits_flutter/ui/screen/personal_screen/cubit/personal_cubit.dart';
import 'package:acits_flutter/util/data_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

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
    getIt.registerFactory<PersonalService>(() => service);
  });

  tearDown(() async {
    await getIt.reset();
  });

  test('load emits content and returns the loaded user', () async {
    when(() => service.fetchPersonal(force: any(named: 'force'))).thenAnswer((_) async => _profile());

    final cubit = PersonalCubit();
    final user = await cubit.load();

    expect(user?.id, 1);
    expect(cubit.state.data, isA<DataContent<UserProfile>>());
    expect(cubit.state.data.valueOrNull?.fullName, 'Grace Hopper');
    await cubit.close();
  });

  test('load emits error and returns null on failure', () async {
    when(() => service.fetchPersonal(force: any(named: 'force'))).thenThrow(Exception('boom'));

    final cubit = PersonalCubit();
    final user = await cubit.load();

    expect(user, isNull);
    expect(cubit.state.data, isA<DataError<UserProfile>>());
    await cubit.close();
  });

  test('submit sends changed fields and lands on content', () async {
    when(() => service.fetchPersonal(force: any(named: 'force'))).thenAnswer((_) async => _profile());
    when(() => service.changePersonal(any())).thenAnswer((_) async => _profile().copyWith(firstName: 'Ada'));

    final cubit = PersonalCubit();
    await cubit.load();

    await cubit.submit(firstName: 'Ada', lastName: 'Hopper', fathersName: '', phoneNumber: '+7', email: 'g@n.mil');

    expect(cubit.state.data, isA<DataContent<UserProfile>>());
    expect(cubit.state.data.valueOrNull?.firstName, 'Ada');
    verify(() => service.changePersonal(any())).called(1);
    await cubit.close();
  });
}
