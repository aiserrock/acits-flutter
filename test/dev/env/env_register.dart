import 'package:acits_flutter/domain/env.dart';
import 'package:injectable/injectable.dart';

/// Регистрация окружения в зависимоcти от flavor
@module
@dev
abstract class EnvDevRegistrer {
  @dev
  Env createEnv() => Env('https://andx2.tplinkdns.com/cors/https://dev.acits.ru');
}
