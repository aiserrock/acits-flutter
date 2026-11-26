import 'package:get_it/get_it.dart';

/// Единый service-locator приложения (`GetIt.instance`). Пакет `di` владеет только
/// инстансом и ни от чего внутреннего не зависит; регистрации (@InjectableInit)
/// собирает приложение — `lib/di/` для prod и `test/dev/di/` для dev.
final getIt = GetIt.instance;
