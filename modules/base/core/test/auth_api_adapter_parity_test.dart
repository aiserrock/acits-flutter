// Parity spike for the auth endpoint group.
//
// Proves the swagger_parser auth adapter's output matches the app's chopper
// client shape: the SAME wire JSON the app parses into token/shelter/current-
// shelter/register models is parsed by the generated models here and mapped,
// field-for-field, onto OUR generator-agnostic auth DTOs. Also proves paginated
// shelter envelopes are unwrapped to their `results` list and that our write
// DTOs serialise onto the generated write models.
import 'package:core/api.dart';
import 'package:core/api/src/auth_client_barrel.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';

/// Fake guest Dio — captures the login POST and returns a fixed token pair,
/// mirroring the `/api/token/` response (only access/refresh).
class _FakeGuestDio implements Dio {
  _FakeGuestDio({this.tokenResponse = const {'access': 'acc', 'refresh': 'ref'}});

  final Map<String, dynamic> tokenResponse;
  String? lastPath;
  Object? lastData;

  @override
  Future<Response<T>> post<T>(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    lastPath = path;
    lastData = data;
    return Response<T>(
      requestOptions: RequestOptions(path: path),
      data: tokenResponse as T,
    );
  }

  @override
  dynamic noSuchMethod(Invocation invocation) =>
      throw UnimplementedError('${invocation.memberName} not used');
}

/// Fake generated token client — returns models parsed from wire fixtures.
class _FakeTokenClient implements TokenClient {
  _FakeTokenClient({this.refreshResult});

  final TokenRefresh? refreshResult;

  TokenRefresh? lastRefreshBody;

  @override
  Future<TokenObtainPair> tokenCreate({required TokenObtainPair body, int? xCurrentShelter}) =>
      throw UnimplementedError('login uses a raw Dio POST, not tokenCreate');

  @override
  Future<TokenRefresh> tokenRefreshCreate({
    required TokenRefresh body,
    int? xCurrentShelter,
  }) async {
    lastRefreshBody = body;
    return refreshResult!;
  }

  @override
  dynamic noSuchMethod(Invocation invocation) =>
      throw UnimplementedError('${invocation.memberName} not used');
}

class _FakeUsersClient implements UsersClient {
  _FakeUsersClient({this.shelters, this.current});

  final PaginatedShelterShortSerializersList? shelters;
  final UserCurrentShelterSerializers? current;

  int? lastCurrentShelterId;

  @override
  Future<PaginatedShelterShortSerializersList> v1UsersMeSheltersList({
    int? xCurrentShelter,
    int? limit,
    int? offset,
  }) async => shelters!;

  @override
  Future<UserCurrentShelterSerializers> v1UsersMeSheltersCurrentRetrieve({
    int? xCurrentShelter,
  }) async {
    lastCurrentShelterId = xCurrentShelter;
    return current!;
  }

  @override
  dynamic noSuchMethod(Invocation invocation) =>
      throw UnimplementedError('${invocation.memberName} not used');
}

class _FakeSheltersClient implements SheltersClient {
  _FakeSheltersClient(this.page);

  final PaginatedShelterShortSerializersList page;

  int? lastLimit;
  int? lastOffset;
  String? lastSearch;

  @override
  Future<PaginatedShelterShortSerializersList> v1SheltersList({
    int? xCurrentShelter,
    int? limit,
    int? offset,
    String? search,
  }) async {
    lastLimit = limit;
    lastOffset = offset;
    lastSearch = search;
    return page;
  }

  @override
  dynamic noSuchMethod(Invocation invocation) =>
      throw UnimplementedError('${invocation.memberName} not used');
}

class _FakeRegistrationClient implements UsersRegistrationClient {
  _FakeRegistrationClient({this.admin, this.worker});

  final UserShelterAdminSerializers? admin;
  final UserShelterWorkerSerializers? worker;

  UserShelterAdminSerializers? lastAdminBody;
  UserShelterWorkerSerializers? lastWorkerBody;

  @override
  Future<UserShelterAdminSerializers> v1UsersAdminRegisterCreate({
    required UserShelterAdminSerializers body,
    int? xCurrentShelter,
  }) async {
    lastAdminBody = body;
    return admin!;
  }

  @override
  Future<UserShelterWorkerSerializers> v1UsersWorkerRegisterCreate({
    required UserShelterWorkerSerializers body,
    int? xCurrentShelter,
  }) async {
    lastWorkerBody = body;
    return worker!;
  }

  @override
  dynamic noSuchMethod(Invocation invocation) =>
      throw UnimplementedError('${invocation.memberName} not used');
}

AuthApiAdapter _adapter({
  _FakeGuestDio? guestDio,
  _FakeTokenClient? authedToken,
  _FakeUsersClient? users,
  _FakeSheltersClient? shelters,
  _FakeRegistrationClient? registration,
}) => AuthApiAdapter(
  guestDio: guestDio ?? _FakeGuestDio(),
  authedTokenClient: authedToken ?? _FakeTokenClient(),
  usersClient: users ?? _FakeUsersClient(),
  guestSheltersClient: shelters ?? _FakeSheltersClient(PaginatedShelterShortSerializersList()),
  guestRegistrationClient: registration ?? _FakeRegistrationClient(),
);

void main() {
  group('AuthApiAdapter parity — login', () {
    test(
      'raw POST /api/token/ sends only credentials, maps access/refresh onto TokenPairDto',
      () async {
        // Response body has ONLY access/refresh (no username/password — write-only);
        // the raw POST path avoids the generated TokenObtainPair.fromJson null-cast crash.
        final dio = _FakeGuestDio(tokenResponse: const {'access': 'acc', 'refresh': 'ref'});
        final result = await _adapter(guestDio: dio).login('john', 'secret');

        expect(result, const TokenPairDto(access: 'acc', refresh: 'ref'));
        expect(dio.lastPath, '/api/token/');
        expect(dio.lastData, {'username': 'john', 'password': 'secret'});
      },
    );

    test('tolerates a token response missing fields (null → empty)', () async {
      final dio = _FakeGuestDio(tokenResponse: const {'access': 'acc'});
      final result = await _adapter(guestDio: dio).login('john', 'secret');
      expect(result, const TokenPairDto(access: 'acc', refresh: ''));
    });
  });

  group('AuthApiAdapter parity — refresh', () {
    test('maps a non-empty refresh through', () async {
      final refresh = TokenRefresh.fromJson({'access': 'new-acc', 'refresh': 'new-ref'});
      final result = await _adapter(
        authedToken: _FakeTokenClient(refreshResult: refresh),
      ).refresh('old', 'old-acc');
      expect(result, const TokenRefreshDto(access: 'new-acc', refresh: 'new-ref'));
    });

    test('surfaces empty refresh as null (SimpleJWT without rotation)', () async {
      final refresh = TokenRefresh.fromJson({'access': 'new-acc', 'refresh': ''});
      final result = await _adapter(
        authedToken: _FakeTokenClient(refreshResult: refresh),
      ).refresh('old', 'old-acc');
      expect(result.access, 'new-acc');
      expect(result.refresh, isNull);
    });
  });

  group('AuthApiAdapter parity — shelters', () {
    test('unwraps my-shelters pagination envelope to ShelterShortDto list', () async {
      final page = PaginatedShelterShortSerializersList.fromJson({
        'count': 2,
        'results': [
          {'id': 1, 'name': 'Alpha'},
          {'id': 2, 'name': 'Beta'},
        ],
      });
      final result = await _adapter(users: _FakeUsersClient(shelters: page)).myShelters();
      expect(result, const [
        ShelterShortDto(id: 1, name: 'Alpha'),
        ShelterShortDto(id: 2, name: 'Beta'),
      ]);
    });

    test('null results envelope maps to empty list', () async {
      final page = PaginatedShelterShortSerializersList.fromJson({'count': 0});
      final result = await _adapter(users: _FakeUsersClient(shelters: page)).myShelters();
      expect(result, isEmpty);
    });

    test('allShelters forwards paging/search args and unwraps results', () async {
      final page = PaginatedShelterShortSerializersList.fromJson({
        'results': [
          {'id': 7, 'name': 'Gamma'},
        ],
      });
      final client = _FakeSheltersClient(page);
      final result = await _adapter(
        shelters: client,
      ).allShelters(limit: 10, offset: 5, search: 'ga');
      expect(result, const [ShelterShortDto(id: 7, name: 'Gamma')]);
      expect(client.lastLimit, 10);
      expect(client.lastOffset, 5);
      expect(client.lastSearch, 'ga');
    });
  });

  group('AuthApiAdapter parity — current shelter', () {
    test(
      'maps current-shelter JSON onto CurrentShelterDto and forwards the shelter id header',
      () async {
        final current = UserCurrentShelterSerializers.fromJson({
          'current_shelter': 42,
          'current_shelter_user_role': 'ADMIN',
          'is_user_can_edit': true,
          'is_user_can_delete': false,
        });
        final client = _FakeUsersClient(current: current);
        final result = await _adapter(users: client).setCurrentShelter(42);
        expect(
          result,
          const CurrentShelterDto(
            currentShelter: 42,
            currentShelterUserRole: 'ADMIN',
            isUserCanEdit: true,
            isUserCanDelete: false,
          ),
        );
        expect(client.lastCurrentShelterId, 42);
      },
    );
  });

  group('AuthApiAdapter parity — register', () {
    test(
      'admin write DTO serialises onto the generated body; response maps to UserAdminDto',
      () async {
        final response = UserShelterAdminSerializers.fromJson({
          'id': 5,
          'first_name': 'Ivan',
          'last_name': 'Ivanov',
          'email': 'ivan@mail.ru',
          'password': 'x',
          're_password': 'x',
          'is_offer_signed': true,
          'shelter': {'id': 9, 'name': 'Shelter', 'country': 'RU', 'city': 'Moscow'},
        });
        final client = _FakeRegistrationClient(admin: response);
        final result = await _adapter(registration: client).registerAdmin(
          const UserAdminWriteDto(
            email: 'ivan@mail.ru',
            password: 'x',
            rePassword: 'x',
            firstName: 'Ivan',
            lastName: 'Ivanov',
            isOfferSigned: true,
            shelter: ShelterWriteDto(name: 'Shelter', country: 'RU', city: 'Moscow', region: 'MO'),
          ),
        );
        expect(result.id, 5);
        expect(result.email, 'ivan@mail.ru');
        // Write body carried through to the generated model.
        expect(client.lastAdminBody!.firstName, 'Ivan');
        expect(client.lastAdminBody!.shelter.name, 'Shelter');
        expect(client.lastAdminBody!.shelter.country, 'RU');
        expect(client.lastAdminBody!.shelter.city, 'Moscow');
        expect(client.lastAdminBody!.shelter.region, 'MO');
      },
    );

    test(
      'worker write DTO maps role string onto the generated enum; response maps to UserWorkerDto',
      () async {
        final response = UserShelterWorkerSerializers.fromJson({
          'first_name': 'Petr',
          'last_name': 'Petrov',
          'email': 'petr@mail.ru',
          'password': 'x',
          're_password': 'x',
          'shelter': 3,
          'role': 'WORKER',
          'is_offer_signed': true,
        });
        final client = _FakeRegistrationClient(worker: response);
        final result = await _adapter(registration: client).registerWorker(
          const UserWorkerWriteDto(
            email: 'petr@mail.ru',
            password: 'x',
            rePassword: 'x',
            firstName: 'Petr',
            lastName: 'Petrov',
            role: 'WORKER',
            shelter: 3,
            isOfferSigned: true,
          ),
        );
        expect(result.email, 'petr@mail.ru');
        expect(result.role, 'WORKER');
        expect(client.lastWorkerBody!.shelter, 3);
        expect(client.lastWorkerBody!.role, RoleEnum.worker);
      },
    );
  });

  group('Auth DTO json round-trips', () {
    test('CurrentShelterDto snake_case round-trip', () {
      final json = {
        'current_shelter': 1,
        'current_shelter_user_role': 'WORKER',
        'is_user_can_edit': false,
        'is_user_can_delete': true,
      };
      expect(CurrentShelterDto.fromJson(json).toJson(), json);
    });

    test('UserWorkerWriteDto omits null fields and keeps snake_case keys', () {
      const dto = UserWorkerWriteDto(
        email: 'a@b.c',
        password: 'p',
        rePassword: 'p',
        firstName: 'A',
        lastName: 'B',
        role: 'GUEST',
        isOfferSigned: true,
      );
      final json = dto.toJson();
      expect(json['first_name'], 'A');
      expect(json['re_password'], 'p');
      expect(json['is_offer_signed'], true);
      expect(json.containsKey('shelter'), isFalse);
      expect(json.containsKey('fathers_name'), isFalse);
    });
  });
}
