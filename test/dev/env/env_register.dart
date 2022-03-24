import 'package:acits_flutter/domain/env.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../di/di_container.dart';

/// Регистрация окружения в зависимоcти от flavor
@module
@dev
abstract class EnvDevRegistrer {
  @dev
  Env createEnv() => Env('https://dev.acits.ru');
}
