/// App-composition services for ACITS: the session/config/animal services,
/// storage + HTTP client register modules, module port bridges, and the
/// document/share platform code (io/web conditional imports).
///
/// These are the classes the app shell and DI wire together. The `@module` /
/// `@injectable` / `@singleton` registrations here are contributed to the app's
/// get_it via the generated [AppServicesPackageModule] micro-package (see
/// `app_services_di.dart`) — a consumer's `@InjectableInit` cannot scan a
/// dependency's injectables, so they are exposed as an external module instead.
///
/// NO dependency on the app shell / router tree: context-less navigation
/// (logout / deep link) resolves [Routes] from `package:navigation` and a
/// registered `GoRouter` from get_it, never `package:acits_flutter/...`.
library;

// Session / config / domain services.
export 'src/service/auth/auth_service.dart';
export 'src/service/auth/auth_repository.dart';
export 'src/service/auth/email_confirm_repository.dart';
export 'src/service/config/config_service.dart';
export 'src/service/animal/animal_service.dart';
export 'src/service/debug/debug_service.dart';
export 'src/service/link_handler/deep_link_service.dart';
export 'src/service/file/file_service.dart';
export 'src/service/file/file_repository.dart';

// Storage.
export 'src/service/shared_pref/preference_storage.dart';
export 'src/service/theme/theme_storage.dart';

// Environment (app-config).
export 'src/domain/env.dart';

// Document export / share platform surface (used by feature registers here and
// available to the shell).
export 'src/service/document/doc_exporter/doc_exporter.dart';
export 'src/service/document/pdfjs_ready/pdfjs_ready.dart';

// Log facade (own copy of the Talker facade, mirroring each feature module's
// local util/log.dart — keeping it out of the shared `util` barrel avoids an
// ambiguous `Log` import in modules that already define their own).
export 'src/log.dart';

// DI micro-package: the generated external module the app pulls into its
// @InjectableInit via externalPackageModules.
export 'app_services_di.dart';
