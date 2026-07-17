import 'package:acits_api/acits_api.dart';
import 'package:acits_core/acits_core.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import 'package:acits_flutter/domain/env.dart';

/// DI-модуль НОВОГО API-стека (acits_core Dio + acits_api адаптер).
///
/// Регистрируется рядом с chopper и пока никем не потребляется — фичи не
/// мигрированы. Цель Step 7: базис существует и резолвится в get_it до того, как
/// его начнут использовать. Именованный инстанс `@Named('acitsApi')` не
/// конфликтует с существующим `@prod Dio` (см. dio_register.dart).
@module
abstract class AcitsApiRegister {
  /// Единый сконфигурированный Dio для нового клиента: интерцепторы
  /// auth/header из acits_core, порты — мосты к AuthService/ConfigService
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

  /// Сгенерированный retrofit-клиент поверх нового Dio.
  @prod
  AnimalsClient animalsClient(@Named('acitsApi') Dio dio) => AnimalsClient(dio);

  /// Адаптер поверх сгенерированного клиента — реализует стабильный порт
  /// [AnimalApiPort]. Возвращаем как порт, чтобы будущие фичи резолвили
  /// [AnimalApiPort], а не конкретный адаптер.
  @prod
  AnimalApiPort animalApiPort(AnimalsClient client) => AnimalApiAdapter(client);
}
