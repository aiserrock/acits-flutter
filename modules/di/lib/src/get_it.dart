import 'package:get_it/get_it.dart';

/// Единый service-locator приложения. Все модули и app-сервисы регистрируются в
/// этот singleton (`GetIt.instance`), поэтому владелец инстанса живёт в пакете
/// `di`, а конкретную регистрацию (@InjectableInit) держит приложение — оно
/// одно видит и модули, и собственные `lib/service/*` классы для сканирования.
final getIt = GetIt.instance;
