import 'package:acits_flutter/domain/env.dart';
import 'package:injectable/injectable.dart';

/// Регистрация окружения в зависимоcти от flavor
@module
@dev
abstract class EnvDevRegistrer {
  // Было: 'https://andx2.tplinkdns.com/cors/https://dev.acits.ru' — запросы шли
  // через личный CORS-прокси прошлого разработчика (`andx2.tplinkdns.com`,
  // сейчас недоступен), а хост `dev.acits.ru` не резолвится в DNS.
  // Рабочий dev-контур — `dev-01.app.acits.ru` (алиас `dev-1.app.acits.ru`).
  @dev
  Env createEnv() => Env('https://dev-01.app.acits.ru');
}
