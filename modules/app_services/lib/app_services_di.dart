import 'package:injectable/injectable.dart';

export 'app_services_di.module.dart';

/// Micro-package DI entrypoint for `app_services`.
///
/// A consumer's `@InjectableInit` cannot scan a dependency's injectable classes,
/// so all `@module` / `@injectable` / `@singleton` registrations in this package
/// are compiled into the generated `AppServicesPackageModule` (subclass of
/// injectable's `MicroPackageModule`, emitted to `app_services_di.module.dart`).
/// The app's own `@InjectableInit` references it via
/// `externalPackageModulesAfter: [ExternalModule(AppServicesPackageModule)]`,
/// which calls `AppServicesPackageModule().init(gh)` with the app's own
/// `GetItHelper` — so the app's `environmentFilter` (prod vs dev) still selects
/// the right registrations, exactly as when these classes lived in `lib/service`.
@InjectableInit.microPackage()
// ignore: unused_element
void _initAppServicesMicroPackage() {}
