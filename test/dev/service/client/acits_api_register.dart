import 'package:core/api.dart';
import 'package:network/network.dart';
import 'package:util/util.dart';
import 'package:dio/dio.dart';
import 'package:flutter_alice/alice.dart';
import 'package:injectable/injectable.dart';

import 'package:app_services/app_services.dart';
import '../../di/di_container.dart';
import '../shared_pref/debug_preference_storage.dart';

/// Dev-вариант нового API-стека (base Dio + acits_api адаптеры).
///
/// Зеркалит [AcitsApiRegister] (prod), но: baseUrl оборачивается в CORS-прокси
/// (web) и debug-baseUrl из настроек, а трафик виден в Alice. Сетевой прокси
/// (Charles) покрыт глобальным `HttpOverrides.global` (dev main.dart), поэтому
/// явный IOClient тут не нужен — dio его подхватывает автоматически.
@module
abstract class AcitsApiRegisterDev {
  @dev
  @Named('acitsApi')
  Dio createAcitsApiDio(
    TokenStore tokenStore,
    TokenRefresher refresher,
    SessionInvalidator sessionInvalidator,
    LocaleProvider localeProvider,
    Env env,
    DebugPreferenceStorage ps,
  ) {
    final dio = createDio(
      tokenStore: tokenStore,
      refresher: refresher,
      sessionInvalidator: sessionInvalidator,
      localeProvider: localeProvider,
    );
    dio.options.baseUrl = UrlCorsProxy.wrapBase(ps.baseUrl ?? env.apiUrl);
    dio.interceptors.add(getIt<Alice>().getDioInterceptor());
    return dio;
  }

  @dev
  @Named('acitsApiGuest')
  Dio createAcitsApiGuestDio(Env env, DebugPreferenceStorage ps) {
    final dio = Dio(
      BaseOptions(
        baseUrl: UrlCorsProxy.wrapBase(ps.baseUrl ?? env.apiUrl),
        connectTimeout: const Duration(milliseconds: 30000),
        receiveTimeout: const Duration(milliseconds: 30000),
        sendTimeout: const Duration(milliseconds: 30000),
      ),
    );
    dio.interceptors.add(getIt<Alice>().getDioInterceptor());
    return dio;
  }

  @dev
  AnimalsClient animalsClient(@Named('acitsApi') Dio dio) => AnimalsClient(dio);

  @dev
  AnimalApiPort animalApiPort(@Named('acitsApi') Dio dio, AnimalsClient client) => AnimalApiAdapter(client, dio);

  @dev
  @Named('acitsApiTokenAuthed')
  TokenClient tokenClientAuthed(@Named('acitsApi') Dio dio) => TokenClient(dio);

  @dev
  UsersClient usersClient(@Named('acitsApi') Dio dio) => UsersClient(dio);

  @dev
  SheltersClient sheltersClient(@Named('acitsApiGuest') Dio dio) => SheltersClient(dio);

  @dev
  UsersRegistrationClient usersRegistrationClient(@Named('acitsApiGuest') Dio dio) => UsersRegistrationClient(dio);

  @dev
  AuthApiPort authApiPort(
    @Named('acitsApiGuest') Dio guestDio,
    @Named('acitsApiTokenAuthed') TokenClient authedTokenClient,
    UsersClient usersClient,
    SheltersClient guestSheltersClient,
    UsersRegistrationClient guestRegistrationClient,
  ) => AuthApiAdapter(
    guestDio: guestDio,
    authedTokenClient: authedTokenClient,
    usersClient: usersClient,
    guestSheltersClient: guestSheltersClient,
    guestRegistrationClient: guestRegistrationClient,
  );

  // ── prescriptions + drugs slice ─────────────────────────────────────────────

  @dev
  PrescriptionsClient prescriptionsClient(@Named('acitsApi') Dio dio) => PrescriptionsClient(dio);

  @dev
  @Named('acitsApiSheltersAuthed')
  SheltersClient sheltersClientAuthed(@Named('acitsApi') Dio dio) => SheltersClient(dio);

  @dev
  PrescriptionApiPort prescriptionApiPort(
    @Named('acitsApi') Dio dio,
    PrescriptionsClient prescriptionsClient,
    @Named('acitsApiSheltersAuthed') SheltersClient sheltersClient,
  ) => PrescriptionApiAdapter(dio, prescriptionsClient, sheltersClient);

  // ── animal notes slice ──────────────────────────────────────────────────────

  @dev
  AnimalNotesApiPort animalNotesApiPort(@Named('acitsApi') Dio dio, AnimalsClient client) =>
      AnimalNotesApiAdapter(dio, client);

  // ── staff slice (applicants + curators) ─────────────────────────────────────

  @dev
  ApplicantsClient applicantsClient(@Named('acitsApi') Dio dio) => ApplicantsClient(dio);

  @dev
  CuratorsClient curatorsClient(@Named('acitsApi') Dio dio) => CuratorsClient(dio);

  @dev
  StaffApiPort staffApiPort(ApplicantsClient applicants, CuratorsClient curators) =>
      StaffApiAdapter(applicants, curators);

  // ── profile slice (/users/me/) ──────────────────────────────────────────────

  @dev
  ProfileApiPort profileApiPort(@Named('acitsApi') Dio dio, UsersClient usersClient) =>
      ProfileApiAdapter(dio, usersClient);

  // ── config slice (values-for-selection + animal attributes) ─────────────────

  @dev
  SelectionApiPort selectionApiPort(@Named('acitsApi') Dio dio, AnimalsClient client) =>
      SelectionApiAdapter(dio, client);
}
