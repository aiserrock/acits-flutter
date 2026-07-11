import 'package:acits_flutter/domain/env.dart';
import 'package:injectable/injectable.dart';

/// Регистрация окружения в зависимоcти от flavor
@module
@prod
abstract class EnvRegistrer {
  @prod
  Env createEnv() => Env(AcitsEnvUrls.prod);
}
