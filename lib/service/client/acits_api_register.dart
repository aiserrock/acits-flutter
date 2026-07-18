import 'package:core/api.dart';
import 'package:base/base.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import 'package:acits_flutter/domain/env.dart';

/// DI-модуль НОВОГО API-стека (base Dio + acits_api адаптер).
///
/// Регистрируется рядом с chopper и пока никем не потребляется — фичи не
/// мигрированы. Цель Step 7: базис существует и резолвится в get_it до того, как
/// его начнут использовать. Именованный инстанс `@Named('acitsApi')` не
/// конфликтует с существующим `@prod Dio` (см. dio_register.dart).
@module
abstract class AcitsApiRegister {
  /// Единый сконфигурированный Dio для нового клиента: интерцепторы
  /// auth/header из base, порты — мосты к AuthService/ConfigService
  /// (см. auth_port_bridges.dart). baseUrl берём из того же [Env], что и chopper.
  @prod
  @Named('acitsApi')
  Dio createAcitsApiDio(
    TokenStore tokenStore,
    TokenRefresher refresher,
    SessionInvalidator sessionInvalidator,
    LocaleProvider localeProvider,
    Env env,
  ) {
    final dio = createDio(
      tokenStore: tokenStore,
      refresher: refresher,
      sessionInvalidator: sessionInvalidator,
      localeProvider: localeProvider,
    );
    dio.options.baseUrl = env.apiUrl;
    return dio;
  }

  /// Гостевой Dio для нового клиента: БЕЗ auth-интерцептора (логин/регистрация/
  /// список всех приютов). Зеркалит chopper `@Named('guest')`. baseUrl — из [Env].
  @prod
  @Named('acitsApiGuest')
  Dio createAcitsApiGuestDio(Env env) {
    final dio = Dio(
      BaseOptions(
        baseUrl: env.apiUrl,
        connectTimeout: const Duration(milliseconds: 30000),
        receiveTimeout: const Duration(milliseconds: 30000),
        sendTimeout: const Duration(milliseconds: 30000),
      ),
    );
    return dio;
  }

  /// Сгенерированный retrofit-клиент поверх нового Dio.
  @prod
  AnimalsClient animalsClient(@Named('acitsApi') Dio dio) => AnimalsClient(dio);

  /// Адаптер поверх сгенерированного клиента — реализует стабильный порт
  /// [AnimalApiPort]. Возвращаем как порт, чтобы будущие фичи резолвили
  /// [AnimalApiPort], а не конкретный адаптер.
  @prod
  AnimalApiPort animalApiPort(@Named('acitsApi') Dio dio, AnimalsClient client) => AnimalApiAdapter(client, dio);

  // ── auth slice ─────────────────────────────────────────────────────────────

  @prod
  @Named('acitsApiTokenAuthed')
  TokenClient tokenClientAuthed(@Named('acitsApi') Dio dio) => TokenClient(dio);

  @prod
  @Named('acitsApiTokenGuest')
  TokenClient tokenClientGuest(@Named('acitsApiGuest') Dio dio) => TokenClient(dio);

  @prod
  UsersClient usersClient(@Named('acitsApi') Dio dio) => UsersClient(dio);

  @prod
  SheltersClient sheltersClient(@Named('acitsApiGuest') Dio dio) => SheltersClient(dio);

  @prod
  UsersRegistrationClient usersRegistrationClient(@Named('acitsApiGuest') Dio dio) => UsersRegistrationClient(dio);

  @prod
  AuthApiPort authApiPort(
    @Named('acitsApiTokenGuest') TokenClient guestTokenClient,
    @Named('acitsApiTokenAuthed') TokenClient authedTokenClient,
    UsersClient usersClient,
    SheltersClient guestSheltersClient,
    UsersRegistrationClient guestRegistrationClient,
  ) => AuthApiAdapter(
    guestTokenClient: guestTokenClient,
    authedTokenClient: authedTokenClient,
    usersClient: usersClient,
    guestSheltersClient: guestSheltersClient,
    guestRegistrationClient: guestRegistrationClient,
  );

  // ── prescriptions + drugs slice ─────────────────────────────────────────────

  @prod
  PrescriptionsClient prescriptionsClient(@Named('acitsApi') Dio dio) => PrescriptionsClient(dio);

  /// Каталог лекарств (`/shelter/drugs/`) требует авторизации — в отличие от
  /// гостевого [SheltersClient] для auth-слайса. Отдельный инстанс на authed Dio.
  @prod
  @Named('acitsApiSheltersAuthed')
  SheltersClient sheltersClientAuthed(@Named('acitsApi') Dio dio) => SheltersClient(dio);

  @prod
  PrescriptionApiPort prescriptionApiPort(
    @Named('acitsApi') Dio dio,
    PrescriptionsClient prescriptionsClient,
    @Named('acitsApiSheltersAuthed') SheltersClient sheltersClient,
  ) => PrescriptionApiAdapter(dio, prescriptionsClient, sheltersClient);

  // ── animal notes slice ──────────────────────────────────────────────────────

  @prod
  AnimalNotesApiPort animalNotesApiPort(@Named('acitsApi') Dio dio, AnimalsClient client) =>
      AnimalNotesApiAdapter(dio, client);

  // ── staff slice (applicants + curators) ─────────────────────────────────────

  @prod
  ApplicantsClient applicantsClient(@Named('acitsApi') Dio dio) => ApplicantsClient(dio);

  @prod
  CuratorsClient curatorsClient(@Named('acitsApi') Dio dio) => CuratorsClient(dio);

  @prod
  StaffApiPort staffApiPort(ApplicantsClient applicants, CuratorsClient curators) =>
      StaffApiAdapter(applicants, curators);

  // ── profile slice (/users/me/) ──────────────────────────────────────────────

  @prod
  ProfileApiPort profileApiPort(@Named('acitsApi') Dio dio, UsersClient usersClient) =>
      ProfileApiAdapter(dio, usersClient);

  // ── config slice (values-for-selection + animal attributes) ─────────────────

  @prod
  SelectionApiPort selectionApiPort(@Named('acitsApi') Dio dio, AnimalsClient client) =>
      SelectionApiAdapter(dio, client);
}
