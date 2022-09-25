import 'package:acits_flutter/domain/env.dart';
import 'package:injectable/injectable.dart';

/// Регистрация окружения в зависимоcти от flavor
@module
@dev
abstract class EnvDevRegistrer {
  @dev
  Env createEnv() => Env('http://andx2.tplinkdns.com:8085/https://dev.acits.ru');
}
