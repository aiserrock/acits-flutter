import 'package:injectable/injectable.dart';

import 'package:acits_flutter/api/openapi.swagger.dart';
import 'package:acits_flutter/domain/exception.dart';

@singleton
class AuthService {
  AuthService(
    this._acitsClient,
    @Named('guest') this._acitsGuestClient,
  );

  final Openapi _acitsClient;
  final Openapi _acitsGuestClient;
  String? _access;
  String? _refresh;

  String? get access => _access;

  PaginatedShelterShortSerializersList? _shelterList;

  UserCurrentShelterSerializers? _shelterRole;

  UserCurrentShelterSerializers? get shelterRole => _shelterRole;

  String? get currentShelterId => _shelterRole?.currentShelter?.toString();

  Future<TokenRefresh?> refreshToken() async {
    final request = TokenRefresh(access: _access, refresh: _refresh);
    final result = await _acitsClient.apiTokenRefreshPost(body: request);
    if (result.body != null) {
      _access = result.body?.access;
      _refresh = result.body?.refresh ?? _refresh;
      return result.body;
    }
  }

  Future<TokenObtainPair?> login(
    String? login,
    String? pass,
  ) async {
    final request = TokenObtainPair(username: login, password: pass);
    final result = await _acitsGuestClient.apiTokenPost(body: request);
    if (result.body != null) {
      _access = result.body?.access;
      _refresh = result.body?.refresh;
      return result.body;
    }
    if (result.error != null) {
      switch (result.base.statusCode) {
        case 401:
          throw NotAuthorizedException(message: result.error.toString());
        default:
          throw MesssagedException(message: result.error.toString());
      }
    }
  }

  Future<PaginatedShelterShortSerializersList?> getShelterList() async {
    final result = await _acitsClient.apiV1UsersMeSheltersGet();
    if (result.body != null) {
      _shelterList = result.body;
      return _shelterList;
    }
    throw MesssagedException(error: result.error);
  }

  Future<UserCurrentShelterSerializers?> setCurrentShelter(int shelterId) async {
    final result =
        await _acitsClient.apiV1UsersMeSheltersCurrentGet(xCurrentShelter: shelterId.toString());
    if (result.body != null) {
      _shelterRole = result.body;
      return _shelterRole;
    }
    throw MesssagedException(error: result.error);
  }
}
