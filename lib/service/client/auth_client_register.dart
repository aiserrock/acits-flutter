import 'package:chopper/chopper.dart';
import 'package:injectable/injectable.dart';

import 'package:acits_flutter/export.dart';
import 'package:acits_flutter/domain/env.dart';
import 'package:acits_flutter/service/client/auth_interceptor.dart';
import 'package:acits_flutter/service/client/header_inteceptor.dart';

@module
abstract class ClientRegister {
  // ВНИМАНИЕ: не добавлять сюда HttpLoggingInterceptor — в prod он пишет
  // заголовки (в т.ч. `Authorization: Bearer <token>`) и тела запросов в
  // системный лог устройства. Логирование запросов — только в dev-клиенте
  // (см. test/dev/service/client/).
  @prod
  Openapi createClient(AuthInterceptor authInterceptor, HeaderInterceptor headerInterceptor, Env env) {
    final chopper = ChopperClient(
      baseUrl: Uri.parse(env.apiUrl),
      interceptors: [headerInterceptor],
      authenticator: authInterceptor,
      converter: $JsonSerializableConverter(),
    );
    final client = Openapi.create(client: chopper);
    return client;
  }

  @prod
  @Named('guest')
  Openapi createGuestClient(Env env) {
    final chopper = ChopperClient(baseUrl: Uri.parse(env.apiUrl), converter: $JsonSerializableConverter());
    final client = Openapi.create(client: chopper);
    return client;
  }
}
