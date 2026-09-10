/// App-internal resource barrel: localization config ([L10n]), app strings
/// ([StringConst]), and lottie asset paths ([LottieRes]). The icomoon icon font
/// ([IconRes]) lives in ui_kit (package-scoped) — re-exported for convenience.
library;

export 'package:ui_kit/ui_kit.dart' show IconRes;
export 'l10n.dart';
export 'lottie.dart';
export 'strings.dart';
