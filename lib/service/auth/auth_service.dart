import 'package:core/core.dart';
import 'package:auth/auth.dart' show AuthSessionApi, AdminRegistrationInput, WorkerRegistrationInput, WorkerRole;
import 'package:collection/collection.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:injectable/injectable.dart';

import 'package:di/di.dart';
import 'package:acits_flutter/navigation/app_router.dart';
import 'package:acits_flutter/service/auth/auth_repository.dart';
import 'package:acits_flutter/service/auth/email_confirm_repository.dart';
import 'package:acits_flutter/service/shared_pref/preference_storage.dart';
import 'package:acits_flutter/util/logger/log.dart';

const _shelterListDefaultLenght = 25;

/// Сервис авторизации / регистрации.
///
/// Сессионный держатель приложения: токены, список приютов, текущая роль. API
/// вызовы идут через стабильный [AuthApiPort] (core api) — сгенерированные
/// chopper/retrofit типы сюда не протекают. Наружу отдаёт доменные сущности
/// ([Shelter]/[CurrentShelterRole]); ошибки маппит в существующие исключения
/// приложения, чтобы не переписывать catch у вызывающих сторон.
@singleton
class AuthService extends ChangeNotifier implements AuthSessionApi {
  AuthService(this._authApi, this._authRepository, this._confirmRepository, this._preferenceStorage);

  final AuthApiPort _authApi;
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

  List<Shelter> _shelterList = const [];

  CurrentShelterRole? _shelterRole;

  String? get access => _access;

  @override
  List<Shelter> get shelterList => _shelterList;

  CurrentShelterRole? get shelterRole => _shelterRole;

  int? get currentShelterId => _shelterRole?.currentShelterId;

  Shelter? get currentShelter => _shelterList.firstWhereOrNull((shelter) => shelter.id == currentShelterId);

  Future<TokenRefreshDto?> refreshToken({String? refresh}) async {
    final usedRefresh = refresh ?? _refresh;
    try {
      final result = await _authApi.refresh(usedRefresh, _access);
      _access = result.access;
      // Бэкенд (SimpleJWT без ROTATE_REFRESH_TOKENS) на refresh возвращает
      // refresh=null — старый токен остаётся валидным. Пишем новый только если
      // сервер его прислал, иначе сохраняем использованный. Иначе `?? _refresh`
      // на холодном старте (где _refresh ещё не подтянут из хранилища) затирал
      // refreshKey в secure storage → автовход работал ровно один раз.
      final newRefresh = result.refresh ?? usedRefresh;
      if (newRefresh != null && newRefresh != _refresh) _refresh = newRefresh;
      Log.info('Token refreshed');
      return result;
    } on DioException catch (e) {
      Log.warning('Token refresh failed (status=${e.response?.statusCode})');
      return null;
    }
  }

  @override
  Future<TokenPairDto?> login(String? login, String? pass) async {
    Log.info('Login attempt: username=$login');
    try {
      final result = await _authApi.login(login ?? '', pass ?? '');
      _access = result.access;
      _refresh = result.refresh;
      Log.info('Login success: username=$login');
      return result;
    } on DioException catch (e) {
      Log.warning('Login failed (status=${e.response?.statusCode}): username=$login');
      final message = _errorBody(e)?.toString();
      switch (e.response?.statusCode) {
        case 401:
          throw NotAuthorizedException(message: message);
        default:
          throw MessagedException(message: message);
      }
    }
  }

  @override
  Future<List<Shelter>> getShelterList() async {
    try {
      final result = await _authApi.myShelters();
      _shelterList = result.map(_toShelter).toList(growable: false);
      return _shelterList;
    } on DioException catch (e) {
      throw MessagedException(error: _errorBody(e));
    }
  }

  @override
  Future<CurrentShelterRole?> setCurrentShelter(int shelterId) async {
    Log.info('Set current shelter: id=$shelterId');
    try {
      final result = await _authApi.setCurrentShelter(shelterId);
      _shelterRole = _toRole(result);
      // Запоминаем приют для автовхода без экрана выбора при следующем старте.
      _preferenceStorage.currentShelterId = shelterId;
      return _shelterRole;
    } on DioException catch (e) {
      throw MessagedException(error: _errorBody(e));
    }
  }

  /// Восстановить ранее выбранный приют из хранилища (для автовхода).
  ///
  /// Возвращает true, если сохранённый id есть и роль по нему успешно получена.
  /// При ошибке (приют удалён/недоступен) — false, вызывающая сторона уходит на
  /// экран выбора приюта, а не падает.
  @override
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
    _access = _refresh = null;
    _shelterList = const [];
    _shelterRole = null;
    _authRepository.clearRefresh();
    _preferenceStorage.currentShelterId = null;
    notifyListeners();
    getIt<GoRouter>().go(AppRoutes.login);
  }

  /// Попробовать обновить авторизацию из прошлой сессии если срок
  /// действия токена не истек
  @override
  Future<bool> tryRefreshLastAuth() async {
    final oldRefresh = _refresh ?? await _authRepository.refresh;
    if (oldRefresh == null) return false;
    return await refreshToken(refresh: oldRefresh).then((value) => value != null).catchError((e) => false);
  }

  /// Список всех доступных приютов
  Future<List<Shelter>> getAllShelterList({
    int limit = _shelterListDefaultLenght,
    int offset = 0,
    String? searchRequest,
  }) async {
    try {
      final result = await _authApi.allShelters(limit: limit, offset: offset, search: searchRequest);
      _shelterList = result.map(_toShelter).toList(growable: false);
      return _shelterList;
    } on DioException catch (e) {
      throw MessagedException(error: _errorBody(e));
    }
  }

  /// Зарегистрировать новый приют и админа в нем
  @override
  Future<bool> registrationAdmin(AdminRegistrationInput input) async {
    try {
      await _authApi.registerAdmin(
        UserAdminWriteDto(
          email: input.email,
          password: input.password,
          rePassword: input.password,
          firstName: input.firstName,
          lastName: input.lastName,
          fathersName: input.fathersName,
          phoneNumber: input.phoneNumber,
          address: '',
          isOfferSigned: true,
          shelter: ShelterWriteDto(
            name: input.shelterName,
            country: input.country,
            city: input.city,
            region: input.region,
          ),
        ),
      );
      return true;
    } on DioException catch (e) {
      throw MessagedException(error: _errorBody(e));
    }
  }

  /// Зарегистрировать нового пользователя
  @override
  Future<bool> registrationCustomer(WorkerRegistrationInput input) async {
    try {
      await _authApi.registerWorker(
        UserWorkerWriteDto(
          shelter: input.shelterId,
          email: input.email,
          password: input.password,
          rePassword: input.password,
          firstName: input.firstName,
          lastName: input.lastName,
          fathersName: '',
          phoneNumber: '',
          address: '',
          isOfferSigned: true,
          role: input.role == WorkerRole.worker ? 'WORKER' : 'GUEST',
        ),
      );
      return true;
    } on DioException catch (e) {
      throw MessagedException(error: _errorBody(e));
    }
  }

  /// Подтвердить электронную почту при регистрации
  @override
  Future<void> confirmEmail(String email) => _confirmRepository.confirmEmail(email);

  Shelter _toShelter(ShelterShortDto d) => Shelter(id: d.id, name: d.name);

  CurrentShelterRole _toRole(CurrentShelterDto d) => CurrentShelterRole(
    currentShelterId: d.currentShelter,
    role: d.currentShelterUserRole,
    canEdit: d.isUserCanEdit,
    canDelete: d.isUserCanDelete,
  );

  /// Тело ответа-ошибки dio в человекочитаемом виде (как раньше `result.error`).
  Object? _errorBody(DioException e) => e.response?.data ?? e.message;
}
