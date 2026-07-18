/// Low-level infra shared across the app: [Result]/[Failure], Dio client +
/// interceptors, AppTask startup pipeline, platform-service ports, [DataState],
/// and pure shared utilities (validators, safe-emit, app version, date/URL).
///
/// This barrel is the public API of the package. `base` depends on nothing
/// internal — everything (api/domain/features) may depend on it.
library;

export 'src/failure/failure.dart';
export 'src/network/auth_interceptor.dart';
export 'src/network/dio_factory.dart';
export 'src/network/header_interceptor.dart';
export 'src/network/ports.dart';
export 'src/network/seams.dart';
export 'src/platform/document_export_service.dart';
export 'src/platform/photo_upload_service.dart';
export 'src/platform/platform_ports.dart';
export 'src/result/result.dart';
export 'src/state/data_state.dart';
export 'src/task/app_task.dart';
export 'src/util/app_version.dart';
export 'src/util/bloc_ext.dart';
export 'src/util/datetime_format.dart';
export 'src/util/url_cors_proxy.dart';
export 'src/util/validator.dart';
