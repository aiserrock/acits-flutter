import 'package:core/api.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:personal/personal.dart';
import 'package:util/util.dart';

class MockProfileApiPort extends Mock implements ProfileApiPort {}

class MockShelterProvider extends Mock implements PersonalShelterProvider {}

UserDto _dto() => UserDto(
  id: 1,
  username: 'grace',
  firstName: 'Grace',
  lastName: 'Hopper',
  fullName: 'Grace Hopper',
  email: 'g@n.mil',
  dateJoined: DateTime.utc(2020),
  isVerified: true,
  fathersName: 'Murray',
  phoneNumber: '+7',
);

UserProfile _profile() => UserProfile(
  id: 1,
  username: 'grace',
  firstName: 'Grace',
  lastName: 'Hopper',
  fullName: 'Grace Hopper',
  email: 'g@n.mil',
  dateJoined: DateTime.utc(2020),
  isVerified: true,
  fathersName: 'Murray',
  phoneNumber: '+7',
);

DioException _dioError() => DioException(
  requestOptions: RequestOptions(path: '/'),
  type: DioExceptionType.badResponse,
  response: Response(
    requestOptions: RequestOptions(path: '/'),
    data: 'boom',
    statusCode: 400,
    statusMessage: 'boom',
  ),
);

void main() {
  late MockProfileApiPort port;
  late MockShelterProvider shelter;
  late PersonalRepository repository;

  setUpAll(() {
    registerFallbackValue(
      UserWriteDto(
        id: 0,
        username: '',
        firstName: '',
        lastName: '',
        fullName: '',
        email: '',
        dateJoined: DateTime.utc(2020),
        isVerified: false,
      ),
    );
  });

  setUp(() {
    port = MockProfileApiPort();
    shelter = MockShelterProvider();
    when(() => shelter.shelterId).thenReturn(50);
    when(() => shelter.addLogoutListener(any())).thenReturn(null);
    when(() => shelter.removeLogoutListener(any())).thenReturn(null);
    repository = PersonalRepositoryImpl(port, shelter);
  });

  test('fetchPersonal maps DTO→UserProfile and caches it', () async {
    when(() => port.me(shelterId: any(named: 'shelterId'))).thenAnswer((_) async => _dto());

    final result = await repository.fetchPersonal(force: true);
    expect(result.isOk, isTrue);
    final user = result.valueOrNull!;
    expect(user.fullName, 'Grace Hopper');
    expect(user.fathersName, 'Murray');

    // Second call (not forced) hits the cache — port is called only once.
    await repository.fetchPersonal();
    verify(() => port.me(shelterId: 50)).called(1);
  });

  test('changePersonal sends a write DTO built from the profile', () async {
    when(() => port.updateMe(any(), shelterId: any(named: 'shelterId'))).thenAnswer((_) async => _dto());

    final result = await repository.changePersonal(_profile());
    expect(result.isOk, isTrue);

    final captured = verify(() => port.updateMe(captureAny(), shelterId: 50)).captured.single as UserWriteDto;
    expect(captured.id, 1);
    expect(captured.username, 'grace');
    expect(captured.fullName, 'Grace Hopper');
  });

  test('changePass delegates to the port', () async {
    when(() => port.changePassword(any(), any(), shelterId: any(named: 'shelterId'))).thenAnswer((_) async {});

    final result = await repository.changePass('old', 'new');
    expect(result.isOk, isTrue);

    verify(() => port.changePassword('old', 'new', shelterId: 50)).called(1);
  });

  test('fetchPersonal maps DioException onto a typed Failure', () async {
    when(() => port.me(shelterId: any(named: 'shelterId'))).thenThrow(_dioError());

    final result = await repository.fetchPersonal(force: true);

    expect(result.isErr, isTrue);
    expect(result.failureOrNull, const ServerFailure(400, 'boom'));
  });

  test('changePass maps a 401 onto AuthFailure', () async {
    when(() => port.changePassword(any(), any(), shelterId: any(named: 'shelterId'))).thenThrow(
      DioException(
        requestOptions: RequestOptions(path: '/'),
        type: DioExceptionType.badResponse,
        response: Response(requestOptions: RequestOptions(path: '/'), statusCode: 401),
      ),
    );

    final result = await repository.changePass('old', 'new');

    expect(result.isErr, isTrue);
    expect(result.failureOrNull, isA<AuthFailure>());
  });

  test('a failed fetch does not poison the cache', () async {
    when(() => port.me(shelterId: any(named: 'shelterId'))).thenThrow(_dioError());

    await repository.fetchPersonal(force: true);
    // Кеш пуст — второй (не форсированный) вызов снова идёт в порт.
    await repository.fetchPersonal();

    verify(() => port.me(shelterId: 50)).called(2);
  });
}
