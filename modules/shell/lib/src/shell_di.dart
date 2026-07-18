import 'package:injectable/injectable.dart';

export 'shell_di.module.dart';

/// Micro-package DI entrypoint for `shell`.
///
/// A consumer's `@InjectableInit` cannot scan a dependency's injectable classes,
/// so the shell's router-service `@injectable` impls (the six `*RouterServiceImpl`
/// + `SplashNavigatorImpl`) are compiled into the generated `ShellPackageModule`
/// (subclass of injectable's `MicroPackageModule`, emitted to
/// `shell_di.module.dart`). The app's `@InjectableInit` references it via
/// `externalPackageModulesAfter: [ExternalModule(ShellPackageModule)]`, which
/// calls `ShellPackageModule().init(gh)` with the app's own `GetItHelper` — so
/// the app's `environmentFilter` (prod vs dev) still selects registrations
/// exactly as when these classes lived in `lib/navigation`.
@InjectableInit.microPackage()
// ignore: unused_element
void _initShellMicroPackage() {}
