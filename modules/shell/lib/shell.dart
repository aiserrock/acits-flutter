/// App shell for ACITS: the composition screens (root / main / animal detail /
/// animal edit) and the navigation tree — the app's [GoRouter] factory
/// ([createAppRouter]), the `extra` codec, auth-screen bindings, and the six
/// feature router-service impls.
///
/// The shell sits above the feature modules + `app_services` and below the app:
/// the app wires `MaterialApp.router` with the shell's router and top-level
/// [ThemeCubit]. Its router-service `@injectable` impls are contributed to the
/// app's get_it via the generated [ShellPackageModule] micro-package (see
/// `src/shell_di.dart`) — a consumer's `@InjectableInit` cannot scan a
/// dependency's injectables. NO dependency on `package:acits_flutter/...`.
library;

// App composition root (MaterialApp.router + theme + localization + phone frame).
export 'app_scaffold.dart';

// Navigation surface.
export 'navigation/navigation.dart';

// Composition screens.
export 'presentation/presentation.dart';

// Shell widgets + top-level cubits (ThemeCubit is wired above MaterialApp).
export 'widget/widget.dart';

// App-internal resources the app still references (L10n config, strings).
export 'res/res.dart';

// DI micro-package pulled into the app's @InjectableInit via externalPackageModules.
export 'src/shell_di.dart';
