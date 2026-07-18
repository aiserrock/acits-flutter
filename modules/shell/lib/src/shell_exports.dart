/// Internal god-barrel for shell screens — the in-package successor of the app's
/// old `lib/export.dart`. Shell presentation/widget files import this one barrel
/// to get assets, theme, lottie, the shared LocaleKeys, the personal/core domain
/// re-exports, and the common collection/localization helpers. Kept `src`-private:
/// the public shell surface (`createAppRouter`, screens) lives in `shell.dart`.
library;

export 'package:collection/collection.dart';
export 'package:core/domain.dart' show Applicant, Curator;
export 'package:easy_localization/easy_localization.dart';
// Data-state + version + CORS-proxy helpers (previously reached via the app's
// `util/util.dart` re-export inside `export.dart`).
export 'package:util/util.dart'
    show
        AppVersion,
        DataState,
        DataLoading,
        DataContent,
        DataError,
        DataStateBuilder,
        DataStateConsumer,
        SafeEmit,
        UrlCorsProxy;
// Shared LocaleKeys (single source for app + feature modules) lives in `l10n`.
export 'package:l10n/l10n.dart';
// Заметки/комментарии животного — доменные сущности из модуля personal.
export 'package:personal/personal.dart' show AnimalNote, AnimalNoteFile;
// Theme lives in ui_kit; AppColors/AppColorsX must be ONE type across app +
// migrated modules so `context.appColors` resolves the same ThemeExtension.
export 'package:ui_kit/ui_kit.dart' show AppTheme, AppColors, AppColorsX;

// App assets + app-internal resources moved into the shell.
export '../gen/assets.gen.dart';
export '../res/icon.dart';
export '../res/lottie.dart';
export '../util/ui.dart' show proceedOnNextFrame;
