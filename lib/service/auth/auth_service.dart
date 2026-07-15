import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:injectable/injectable.dart';

import 'package:acits_flutter/di/di_container.dart';
import 'package:acits_flutter/navigation/app_router.dart';
import 'package:acits_flutter/service/auth/auth_repository.dart';
import 'package:acits_flutter/service/auth/email_confirm_repository.dart';
import 'package:acits_flutter/service/shared_pref/preference_storage.dart';
import 'package:acits_flutter/domain/exception.dart';
import 'package:acits_flutter/util/logger/log.dart';
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
    this._preferenceStorage,
  );

  final Openapi _acitsClient;
  final Openapi _acitsGuestClient;
  final AuthRepository _authRepository;
  final EmailConfirmRepository _confirmRepository;
  final PreferenceStorage _preferenceStorage;

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

  int? get currentShelterId => _shelterRole?.currentShelter;

  ShelterShortSerializers? get currentShelter =>
      _shelterList?.results?.firstWhereOrNull((shelter) => shelter.id == currentShelterId);

  Future<TokenRefresh?> refreshToken({String? refresh}) async {
    final usedRefresh = refresh ?? _refresh;
    final request = TokenRefresh(access: _access, refresh: usedRefresh);
    final result = await _acitsClient.apiTokenRefreshPost(body: request);
    if (result.body != null) {
      _access = result.body?.access;
      // Бэкенд (SimpleJWT без ROTATE_REFRESH_TOKENS) на refresh возвращает
      // refresh=null — старый токен остаётся валидным. Пишем новый только если
      // сервер его прислал, иначе сохраняем использованный. Иначе `?? _refresh`
      // на холодном старте (где _refresh ещё не подтянут из хранилища) затирал
      // refreshKey в secure storage → автовход работал ровно один раз.
      final newRefresh = result.body?.refresh ?? usedRefresh;
      if (newRefresh != null && newRefresh != _refresh) _refresh = newRefresh;
      Log.info('Token refreshed');
      return result.body;
    }
    Log.warning('Token refresh failed (status=${result.base.statusCode})');
    return null;
  }

  Future<TokenObtainPair?> login(String? login, String? pass) async {
    Log.info('Login attempt: username=$login');
    final request = TokenObtainPair(username: login, password: pass);
    final result = await _acitsGuestClient.apiTokenPost(body: request);
    if (result.body != null) {
      _access = result.body?.access;
      _refresh = result.body?.refresh;
      Log.info('Login success: username=$login');
      return result.body;
    }
    if (result.error != null) {
      Log.warning('Login failed (status=${result.base.statusCode}): username=$login');
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
    Log.info('Set current shelter: id=$shelterId');
    final result = await _acitsClient.apiV1UsersMeSheltersCurrentGet(xCurrentShelter: shelterId);
    if (result.body != null) {
      _shelterRole = result.body;
      // Запоминаем приют для автовхода без экрана выбора при следующем старте.
      _preferenceStorage.currentShelterId = shelterId;
      return _shelterRole;
    }
    throw MessagedException(error: result.error);
  }

  /// Восстановить ранее выбранный приют из хранилища (для автовхода).
  ///
  /// Возвращает true, если сохранённый id есть и роль по нему успешно получена.
  /// При ошибке (приют удалён/недоступен) — false, вызывающая сторона уходит на
  /// экран выбора приюта, а не падает.
  Future<bool> restoreShelter() async {
    final savedId = _preferenceStorage.currentShelterId;
    if (savedId == null) {
      Log.debug('AuthService.restoreShelter: no saved shelter');
      return false;
    }
    Log.info('AuthService.restoreShelter: id=$savedId');
    try {
      final role = await setCurrentShelter(savedId);
      return role != null;
    } catch (e, s) {
      Log.warning('AuthService.restoreShelter failed', e, s);
      return false;
    }
  }

  void logout() {
    Log.info('Logout');
    _access = _refresh = _shelterList = _shelterRole = null;
    _authRepository.clearRefresh();
    _preferenceStorage.currentShelterId = null;
    notifyListeners();
    getIt<GoRouter>().go(AppRoutes.login);
  }

  /// Попробовать обновить авторизацию из прошлой сессии если срок
  /// действия токена не истек
  Future<bool> tryRefreshLastAuth() async {
    final oldRefresh = _refresh ?? await _authRepository.refresh;
    if (oldRefresh == null) return false;
    return await refreshToken(refresh: oldRefresh).then((value) => value is TokenRefresh).catchError((e) => false);
  }

  /// Список всех доступных приютов
  Future<PaginatedShelterShortSerializersList?> getAllShelterList({
    int limit = _shelterListDefaultLenght,
    int offset = 0,
    String? searchRequest,
  }) async {
    final result = await _acitsGuestClient.apiV1SheltersGet(limit: limit, offset: offset, search: searchRequest);

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
  Future<UserShelterWorkerSerializers?> registrationCustomer(UserShelterWorkerSerializers customer) async {
    final result = await _acitsGuestClient.apiV1UsersWorkerRegisterPost(body: customer);

    if (result.body != null) {
      return result.body;
    }
    throw MessagedException(error: result.error ?? result.bodyString);
  }

  /// Подтвердить электронную почту при регистрации
  Future<void> confirmEmail(String email) => _confirmRepository.confirmEmail(email);
}
