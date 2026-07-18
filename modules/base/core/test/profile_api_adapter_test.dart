// Parity spike for the profile endpoint group (/users/me/).
//
// me/updateMe map onto the typed UsersClient; change-password goes through the
// raw Dio to preserve the exact chopper body (no `id`). These tests prove the
// mapping and the change-password wire shape.
import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:core/api.dart';
import 'package:core/api/src/profile_client_barrel.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';

class _StubHttpAdapter implements HttpClientAdapter {
  RequestOptions? lastRequest;
  Object? lastRequestData;

  @override
  Future<ResponseBody> fetch(
    RequestOptions options,
    Stream<Uint8List>? requestStream,
    Future<void>? cancelFuture,
  ) async {
    lastRequest = options;
    lastRequestData = options.data;
    return ResponseBody.fromString(
      jsonEncode(const {'id': 1}),
      200,
      headers: {
        Headers.contentTypeHeader: [Headers.jsonContentType],
      },
    );
  }

  @override
  void close({bool force = false}) {}
}

class _FakeUsersClient implements UsersClient {
  UserSerializers user = _user();
  int? lastShelterId;
  UserSerializers? lastBody;

  @override
  Future<UserSerializers> v1UsersMeRetrieve({int? xCurrentShelter}) async {
    lastShelterId = xCurrentShelter;
    return user;
  }

  @override
  Future<UserSerializers> v1UsersMeUpdate({required UserSerializers body, int? xCurrentShelter}) async {
    lastBody = body;
    lastShelterId = xCurrentShelter;
    return body;
  }

  @override
  dynamic noSuchMethod(Invocation invocation) => throw UnimplementedError('${invocation.memberName} unused');
}

UserSerializers _user() => UserSerializers(
  id: 1,
  username: 'grace',
  firstName: 'Grace',
  lastName: 'Hopper',
  fathersName: 'Murray',
  fullName: 'Grace Hopper',
  email: 'grace@navy.mil',
  phoneNumber: '+70000000000',
  address: 'Arlington',
  dateJoined: DateTime.utc(2020, 1, 1),
  isVerified: true,
  isOfferSigned: false,
);

void main() {
  late _StubHttpAdapter stub;
  late _FakeUsersClient users;
  late ProfileApiAdapter adapter;

  setUp(() {
    stub = _StubHttpAdapter();
    final dio = Dio(BaseOptions(baseUrl: 'https://api.acits.ru'))..httpClientAdapter = stub;
    users = _FakeUsersClient();
    adapter = ProfileApiAdapter(dio, users);
  });

  test('me maps the profile and passes the shelter header', () async {
    final dto = await adapter.me(shelterId: 50);

    expect(dto.id, 1);
    expect(dto.username, 'grace');
    expect(dto.fullName, 'Grace Hopper');
    expect(dto.fathersName, 'Murray');
    expect(dto.phoneNumber, '+70000000000');
    expect(dto.isVerified, isTrue);
    expect(users.lastShelterId, 50);
  });

  test('updateMe echoes the whole record back through the body', () async {
    final dto = await adapter.updateMe(
      UserWriteDto(
        id: 1,
        username: 'grace',
        firstName: 'Grace',
        lastName: 'Hopper',
        fullName: 'Grace Hopper',
        email: 'grace@navy.mil',
        dateJoined: DateTime.utc(2020, 1, 1),
        isVerified: true,
        fathersName: 'Murray',
        phoneNumber: '+7',
      ),
      shelterId: 50,
    );

    expect(dto.firstName, 'Grace');
    expect(users.lastBody!.username, 'grace');
    expect(users.lastBody!.fullName, 'Grace Hopper');
    expect(users.lastShelterId, 50);
  });

  test('changePassword posts old/new/re_password with no id, plus shelter header', () async {
    await adapter.changePassword('old-pass', 'new-pass', shelterId: 50);

    expect(stub.lastRequest!.method, 'PUT');
    expect(stub.lastRequest!.path, '/api/v1/users/me/change_password/');
    final body = stub.lastRequestData as Map<String, dynamic>;
    expect(body['old_password'], 'old-pass');
    expect(body['password'], 'new-pass');
    expect(body['re_password'], 'new-pass');
    expect(body.containsKey('id'), isFalse);
    expect(stub.lastRequest!.headers['x-current-shelter'], 50);
  });
}
