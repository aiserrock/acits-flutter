import 'package:injectable/injectable.dart';
import 'package:talker_flutter/talker_flutter.dart';

import 'package:acits_flutter/util/logger/app_logger.dart';

/// Talker для DEV-флейвора: включён ВСЕГДА, в том числе в release-web на
/// GitHub Pages — это сборка для разработчиков, логи и debug-меню должны
/// работать. Prod-флейвор регистрирует свой Talker (enabled только в debug,
/// см. [AppLoggerModule]).
@module
abstract class LoggerRegisterDev {
  @singleton
  @dev
  Talker talker() => createAppTalker(enabled: true);
}
