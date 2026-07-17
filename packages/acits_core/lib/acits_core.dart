/// Cross-cutting core: [Result]/[Failure], Dio client + interceptors,
/// AppTask startup pipeline, and platform-service ports.
///
/// This barrel is the public API of the package.
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
export 'src/task/app_task.dart';
