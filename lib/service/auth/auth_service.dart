import 'package:injectable/injectable.dart';

import 'package:acits_flutter/api/openapi.swagger.dart';

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

  Future<TokenRefresh?> refreshToken() async {
    final request = TokenRefresh(access: _access, refresh: _refresh);
    final result = await _acitsClient.apiTokenRefreshPost(body: request);
    if (result.body != null) {
      _access = result.body?.access;
      _refresh = result.body?.refresh;
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
}

class NotAuthorizedException implements Exception {
  NotAuthorizedException({this.message});

  final String? message;

  @override
  String toString() {
    return message ?? super.toString();
  }
}

class MesssagedException implements Exception {
  MesssagedException({this.message});

  final String? message;

  @override
  String toString() {
    return message ?? super.toString();
  }
}
