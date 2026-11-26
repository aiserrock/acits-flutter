import 'package:core/core.dart';
import 'package:core/data.dart';
import 'package:auth/auth.dart' show AuthSessionApi, AdminRegistrationInput, WorkerRegistrationInput, WorkerRole;
import 'package:collection/collection.dart';
import 'package:dio/dio.dart';
import 'package:material_ui/material_ui.dart';
import 'package:go_router/go_router.dart';
import 'package:injectable/injectable.dart';

import 'package:di/di.dart';
import 'package:navigation/navigation.dart';
import 'package:app_services/src/service/auth/auth_repository.dart';
import 'package:app_services/src/service/auth/email_confirm_repository.dart';
import 'package:app_services/src/service/shared_pref/preference_storage.dart';
import 'package:app_services/src/log.dart';

const _shelterListDefaultLenght = 25;

/// Сервис авторизации / регистрации.
///
/// Сессионный держатель приложения: токены, список приютов, текущая роль. API
/// вызовы идут через стабильный [AuthApiPort] (core api) — сгенерированные
/// chopper/retrofit типы сюда не протекают. Наружу отдаёт доменные сущности
/// ([Shelter]/[CurrentShelterRole]) в `Result<Failure, T>`, как репозитории фич.
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

  final _sessionListeners = <void Function(int? shelterId)>[];

  /// Called with the shelter id when a shelter becomes current and with `null`
  /// on logout. Crash and error reports use it to tie events to the session.
  void addSessionListener(void Function(int? shelterId) listener) => _sessionListeners.add(listener);

  void _notifySession(int? shelterId) {
    for (final listener in List.of(_sessionListeners)) {
      listener(shelterId);
    }
  }

  Shelter? get currentShelter => _shelterList.firstWhereOrNull((shelter) => shelter.id == currentShelterId);

  /// Обновляет пару токенов и возвращает новый access. `null` — сервер отверг
  /// refresh-токен; сетевой сбой пробрасывается (контракт `TokenRefresher`).
  Future<String?> refreshToken({String? refresh}) async {
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
      return result.access;
    } on DioException catch (e) {
      final status = e.response?.statusCode;
      Log.warning('Token refresh failed (status=$status)');
      // 400/401/403 — сервер отверг refresh-токен. Сеть, таймаут и 5xx пробрасываем:
      // сессия жива, разлогинивать пользователя нельзя.
      if (status == 400 || status == 401 || status == 403) return null;
      rethrow;
    }
  }

  @override
  Future<Result<Failure, void>> login(String? login, String? pass) {
    Log.info('Login attempt: username=$login');
    return _guard<void>('Login', () async {
      final result = await _authApi.login(login ?? '', pass ?? '');
      _access = result.access;
      _refresh = result.refresh;
      Log.info('Login success: username=$login');
    });
  }

  @override
  Future<Result<Failure, List<Shelter>>> getShelterList() {
    return _guard('Get shelter list', () async {
      final result = await _authApi.myShelters();
      _shelterList = result.map(_toShelter).toList(growable: false);
      return _shelterList;
    });
  }

  @override
  Future<Result<Failure, CurrentShelterRole>> setCurrentShelter(int shelterId) {
    Log.info('Set current shelter: id=$shelterId');
    return _guard('Set current shelter', () async {
      final role = _toRole(await _authApi.setCurrentShelter(shelterId));
      _shelterRole = role;
      // Запоминаем приют для автовхода без экрана выбора при следующем старте.
      _preferenceStorage.currentShelterId = shelterId;
      _notifySession(role.currentShelterId);
      return role;
    });
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
    return (await setCurrentShelter(savedId)).isOk;
  }

  void logout() {
    Log.info('Logout');
    _access = _refresh = null;
    _shelterList = const [];
    _shelterRole = null;
    _authRepository.clearRefresh();
    _preferenceStorage.currentShelterId = null;
    _notifySession(null);
    notifyListeners();
    getIt<GoRouter>().go(Routes.login);
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
  Future<Result<Failure, List<Shelter>>> getAllShelterList({
    int limit = _shelterListDefaultLenght,
    int offset = 0,
    String? searchRequest,
  }) {
    return _guard('Get all shelters', () async {
      final result = await _authApi.allShelters(limit: limit, offset: offset, search: searchRequest);
      _shelterList = result.map(_toShelter).toList(growable: false);
      return _shelterList;
    });
  }

  /// Зарегистрировать новый приют и админа в нем
  @override
  Future<Result<Failure, void>> registrationAdmin(AdminRegistrationInput input) {
    return _guard<void>('Register admin', () async {
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
    });
  }

  /// Зарегистрировать нового пользователя
  @override
  Future<Result<Failure, void>> registrationCustomer(WorkerRegistrationInput input) {
    return _guard<void>('Register worker', () async {
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
    });
  }

  @override
  Future<Result<Failure, void>> requestPasswordReset(String email) {
    Log.info('Password reset requested');
    return _guard<void>('Request password reset', () => _authApi.requestPasswordReset(email.trim()));
  }

  /// Подтвердить электронную почту при регистрации
  @override
  Future<Result<Failure, void>> confirmEmail(String email) => _confirmRepository.confirmEmail(email);

  Shelter _toShelter(ShelterShortDto d) => Shelter(id: d.id, name: d.name);

  CurrentShelterRole _toRole(CurrentShelterDto d) => CurrentShelterRole(
    currentShelterId: d.currentShelter,
    role: d.currentShelterUserRole,
    canEdit: d.isUserCanEdit,
    canDelete: d.isUserCanDelete,
  );

  /// Транспортные исключения заканчиваются здесь: наружу уходит [Failure].
  Future<Result<Failure, T>> _guard<T>(String action, Future<T> Function() body) =>
      guard(body, onError: (e, s) => Log.warning('$action failed', e, s));
}
