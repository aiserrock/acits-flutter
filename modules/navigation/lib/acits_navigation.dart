/// Navigation primitives: route path constants, typed param codecs, and guards.
///
/// NO feature/screen imports by rule — this breaks the app→nav→screen cycle.
/// The GoRouter tree itself is assembled in the root app until enough screens
/// live in feature modules that the root no longer imports screen widgets.
library;

export 'src/auth_guard.dart';
export 'src/param_codec.dart';
export 'src/routes.dart';
