import 'package:core/api.dart';
import 'package:network/network.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import 'package:app_services/src/domain/env.dart';

/// DI-модуль API-стека: сконфигурированный Dio + адаптеры портов из `core/api`.
///
/// Единственный клиент приложения. Инстансы именованные (`@Named('acitsApi')` и
/// `@Named('acitsApiGuest')`), потому что гостевой ходит без auth-интерцептора.
@module
abstract class AcitsApiRegister {
  /// Единый сконфигурированный Dio для нового клиента: интерцепторы
  /// auth/header из base, порты — мосты к AuthService/ConfigService
  /// (см. auth_port_bridges.dart). baseUrl — из [Env].
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
  /// список всех приютов). baseUrl — из [Env].
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
  UsersClient usersClient(@Named('acitsApi') Dio dio) => UsersClient(dio);

  @prod
  SheltersClient sheltersClient(@Named('acitsApiGuest') Dio dio) => SheltersClient(dio);

  @prod
  UsersRegistrationClient usersRegistrationClient(@Named('acitsApiGuest') Dio dio) => UsersRegistrationClient(dio);

  @prod
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
