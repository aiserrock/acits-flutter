import 'package:acits_flutter/di/di_container.dart';
import 'package:acits_flutter/ui/screen/auth/login_screen_route.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

import 'package:acits_flutter/domain/exception.dart';
import 'package:acits_flutter/export.dart';

@singleton
class AuthService extends ChangeNotifier {
  AuthService(
    this._acitsClient,
    @Named('guest') this._acitsGuestClient,
  );

  final Openapi _acitsClient;
  final Openapi _acitsGuestClient;
  String? _access;
  String? _refresh;

  PaginatedShelterShortSerializersList? _shelterList;

  UserCurrentShelterSerializers? _shelterRole;

  String? get access => _access;

  PaginatedShelterShortSerializersList? get shelterList => _shelterList;

  UserCurrentShelterSerializers? get shelterRole => _shelterRole;

  String? get currentShelterId => _shelterRole?.currentShelter?.toString();

  ShelterShortSerializers? get currentShelter => _shelterList?.results
      ?.firstWhereOrNull((shelter) => shelter.id.toString() == currentShelterId);

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
          throw MessagedException(message: result.error.toString());
      }
    }
  }

  Future<PaginatedShelterShortSerializersList?> getShelterList() async {
    final result = await _acitsClient.apiV1UsersMeSheltersGet();
    if (result.body != null) {
      _shelterList = result.body;
      return _shelterList;
    }
    throw MessagedException(error: result.error);
  }

  Future<UserCurrentShelterSerializers?> setCurrentShelter(int shelterId) async {
    final result =
        await _acitsClient.apiV1UsersMeSheltersCurrentGet(xCurrentShelter: shelterId.toString());
    if (result.body != null) {
      _shelterRole = result.body;
      return _shelterRole;
    }
    throw MessagedException(error: result.error);
  }

  void logout() {
    _access = _refresh = _shelterList = _shelterRole = null;
    notifyListeners();
    getIt<GlobalKey<NavigatorState>>().currentState
      ?..popUntil((route) => false)
      ..push(LoginScreenRoute());
  }
}
