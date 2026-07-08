import 'package:acits_flutter/domain/env.dart';
import 'package:injectable/injectable.dart';

/// Регистрация окружения в зависимоcти от flavor
@module
@dev
abstract class EnvDevRegistrer {
  // Было: 'https://andx2.tplinkdns.com/cors/https://dev.acits.ru' — запросы шли
  // через личный CORS-прокси прошлого разработчика (`andx2.tplinkdns.com`,
  // сейчас недоступен), а хост `dev.acits.ru` не резолвится в DNS. Из-за этого
  // dev-сборка не могла достучаться до бэкенда («нет интернета»).
  // Направляем dev на рабочий контур напрямую, без прокси. Замените на реальный
  // адрес dev-бэкенда, когда он появится.
  @dev
  Env createEnv() => Env('https://app.acits.ru');
}
