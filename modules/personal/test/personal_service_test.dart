import 'package:core/api.dart';
import 'package:core/domain.dart' show MessagedException;
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:personal/personal.dart';

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
  response: Response(
    requestOptions: RequestOptions(path: '/'),
    data: 'boom',
    statusCode: 400,
  ),
);

void main() {
  late MockProfileApiPort port;
  late MockShelterProvider shelter;
  late PersonalService service;

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
    service = PersonalService(port, shelter);
  });

  test('fetchPersonal maps DTO→UserProfile and caches it', () async {
    when(() => port.me(shelterId: any(named: 'shelterId'))).thenAnswer((_) async => _dto());

    final user = await service.fetchPersonal(force: true);
    expect(user, isA<UserProfile>());
    expect(user.fullName, 'Grace Hopper');
    expect(user.fathersName, 'Murray');

    // Second call (not forced) hits the cache — port is called only once.
    await service.fetchPersonal();
    verify(() => port.me(shelterId: 50)).called(1);
  });

  test('changePersonal sends a write DTO built from the profile', () async {
    when(() => port.updateMe(any(), shelterId: any(named: 'shelterId'))).thenAnswer((_) async => _dto());

    await service.changePersonal(_profile());

    final captured = verify(() => port.updateMe(captureAny(), shelterId: 50)).captured.single as UserWriteDto;
    expect(captured.id, 1);
    expect(captured.username, 'grace');
    expect(captured.fullName, 'Grace Hopper');
  });

  test('changePass delegates to the port', () async {
    when(() => port.changePassword(any(), any(), shelterId: any(named: 'shelterId'))).thenAnswer((_) async {});

    await service.changePass('old', 'new');

    verify(() => port.changePassword('old', 'new', shelterId: 50)).called(1);
  });

  test('fetchPersonal wraps DioException into MessagedException', () async {
    when(() => port.me(shelterId: any(named: 'shelterId'))).thenThrow(_dioError());
    expect(service.fetchPersonal(force: true), throwsA(isA<MessagedException>()));
  });
}
