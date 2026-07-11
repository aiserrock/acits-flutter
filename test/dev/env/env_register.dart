import 'package:acits_flutter/domain/env.dart';
import 'package:injectable/injectable.dart';

/// Регистрация окружения в зависимоcти от flavor
@module
@dev
abstract class EnvDevRegistrer {
  // Контур окружений (app-frontend/app-backend):
  //   prod    → https://app.acits.ru
  //   stage   → https://stage.app.acits.ru
  //   dev-N   → https://dev-N.app.acits.ru (N = 0..3)
  // dev-флейвор по умолчанию стартует со stage; переключение на любой контур —
  // в debug-экране (см. AcitsEnvUrls / _domainUrlList).
  @dev
  Env createEnv() => Env(AcitsEnvUrls.stage);
}
