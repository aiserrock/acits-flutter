import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:injectable/injectable.dart';

import 'package:acits_flutter/di/di_container.dart';
import 'package:acits_flutter/navigation/app_router.dart';
import 'package:acits_flutter/service/auth/auth_repository.dart';
import 'package:acits_flutter/service/auth/email_confirm_repository.dart';
import 'package:acits_flutter/domain/exception.dart';
import 'package:acits_flutter/export.dart';

const _shelterListDefaultLenght = 25;

/// Сервис авторизации / регистрации
@singleton
class AuthService extends ChangeNotifier {
  AuthService(
    this._acitsClient,
    @Named('guest') this._acitsGuestClient,
    this._authRepository,
    this._confirmRepository,
  );

  final Openapi _acitsClient;
  final Openapi _acitsGuestClient;
  final AuthRepository _authRepository;
  final EmailConfirmRepository _confirmRepository;

  String? _access;
  String? _refreshValue;

  String? get _refresh => _refreshValue;

  set _refresh(String? token) {
    _refreshValue = token;
    _authRepository.setRefresh(token);
  }

  PaginatedShelterShortSerializersList? _shelterList;

  UserCurrentShelterSerializers? _shelterRole;

  String? get access => _access;

  PaginatedShelterShortSerializersList? get shelterList => _shelterList;

  UserCurrentShelterSerializers? get shelterRole => _shelterRole;

  String? get currentShelterId => _shelterRole?.currentShelter?.toString();

  ShelterShortSerializers? get currentShelter => _shelterList?.results?.firstWhereOrNull(
    (shelter) => shelter.id.toString() == currentShelterId,
  );

  Future<TokenRefresh?> refreshToken({String? refresh}) async {
    final request = TokenRefresh(access: _access, refresh: refresh ?? _refresh);
    final result = await _acitsClient.apiTokenRefreshPost(body: request);
    if (result.body != null) {
      _access = result.body?.access;
      _refresh = result.body?.refresh ?? _refresh;
      return result.body;
    }
    return null;
  }

  Future<TokenObtainPair?> login(String? login, String? pass) async {
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
    return null;
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
    final result = await _acitsClient.apiV1UsersMeSheltersCurrentGet(
      xCurrentShelter: shelterId.toString(),
    );
    if (result.body != null) {
      _shelterRole = result.body;
      return _shelterRole;
    }
    throw MessagedException(error: result.error);
  }

  void logout() {
    _access = _refresh = _shelterList = _shelterRole = null;
    notifyListeners();
    getIt<GoRouter>().go(AppRoutes.login);
  }

  /// Попробовать обновить авторизацию из прошлой сессии если срок
  /// действия токена не истек
  Future<bool> tryRefreshLastAuth() async {
    if (_refresh != null) return false;
    final oldRefresh = await _authRepository.refresh;
    if (oldRefresh == null) return false;
    return await refreshToken(
      refresh: oldRefresh,
    ).then((value) => value is TokenRefresh).catchError((e) => false);
  }

  /// Список всех доступных приютов
  Future<PaginatedShelterShortSerializersList?> getAllShelterList({
    int limit = _shelterListDefaultLenght,
    int offset = 0,
    String? searchRequest,
  }) async {
    final result = await _acitsGuestClient.apiV1SheltersGet(
      limit: limit,
      offset: offset,
      search: searchRequest,
    );

    if (result.body != null) {
      _shelterList = result.body;
      return _shelterList;
    }
    throw MessagedException(error: result.error ?? result.bodyString);
  }

  /// Зарегистрировать новый приют и админа в нем
  Future<UserShelterAdminSerializers?> registrationAdmin(UserShelterAdminSerializers admin) async {
    final result = await _acitsGuestClient.apiV1UsersAdminRegisterPost(body: admin);

    if (result.body != null) {
      return result.body;
    }
    throw MessagedException(error: result.error ?? result.bodyString);
  }

  /// Зарегистрировать нового пользователя
  Future<UserShelterWorkerSerializers?> registrationCustomer(
    UserShelterWorkerSerializers customer,
  ) async {
    final result = await _acitsGuestClient.apiV1UsersWorkerRegisterPost(
      body: customer.copyWith(role: roleEnumToJson(customer.role as RoleEnum)),
    );

    if (result.body != null) {
      return result.body;
    }
    throw MessagedException(error: result.error ?? result.bodyString);
  }

  /// Подтвердить электронную почту при регистрации
  Future<void> confirmEmail(String email) => _confirmRepository.confirmEmail(email);
}
