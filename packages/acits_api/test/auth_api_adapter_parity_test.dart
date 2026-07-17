// Parity spike for the auth endpoint group.
//
// Proves the swagger_parser auth adapter's output matches the app's chopper
// client shape: the SAME wire JSON the app parses into token/shelter/current-
// shelter/register models is parsed by the generated models here and mapped,
// field-for-field, onto OUR generator-agnostic auth DTOs. Also proves paginated
// shelter envelopes are unwrapped to their `results` list and that our write
// DTOs serialise onto the generated write models.
import 'package:acits_api/acits_api.dart';
import 'package:acits_api/src/auth_client_barrel.dart';
import 'package:flutter_test/flutter_test.dart';

/// Fake generated token client — returns models parsed from wire fixtures.
class _FakeTokenClient implements TokenClient {
  _FakeTokenClient({this.pair, this.refreshResult});

  final TokenObtainPair? pair;
  final TokenRefresh? refreshResult;

  TokenObtainPair? lastLoginBody;
  TokenRefresh? lastRefreshBody;

  @override
  Future<TokenObtainPair> tokenCreate({required TokenObtainPair body, int? xCurrentShelter}) async {
    lastLoginBody = body;
    return pair!;
  }

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
  _FakeTokenClient? guestToken,
  _FakeTokenClient? authedToken,
  _FakeUsersClient? users,
  _FakeSheltersClient? shelters,
  _FakeRegistrationClient? registration,
}) => AuthApiAdapter(
  guestTokenClient: guestToken ?? _FakeTokenClient(),
  authedTokenClient: authedToken ?? _FakeTokenClient(),
  usersClient: users ?? _FakeUsersClient(),
  guestSheltersClient: shelters ?? _FakeSheltersClient(PaginatedShelterShortSerializersList()),
  guestRegistrationClient: registration ?? _FakeRegistrationClient(),
);

void main() {
  group('AuthApiAdapter parity — login', () {
    test('maps token pair JSON onto TokenPairDto and sends only credentials on the wire', () async {
      final pair = TokenObtainPair.fromJson({
        'username': 'u',
        'password': 'p',
        'access': 'acc',
        'refresh': 'ref',
      });
      final guest = _FakeTokenClient(pair: pair);
      final result = await _adapter(guestToken: guest).login('john', 'secret');

      expect(result, const TokenPairDto(access: 'acc', refresh: 'ref'));
      // The request body carries the credentials; access/refresh stay empty
      // (read-only server-side) so the wire request is username/password.
      expect(guest.lastLoginBody!.username, 'john');
      expect(guest.lastLoginBody!.password, 'secret');
      expect(guest.lastLoginBody!.access, '');
      expect(guest.lastLoginBody!.refresh, '');
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
