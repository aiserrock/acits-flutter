/// Dio client + interceptors shared across the app: one configured Dio factory,
/// [AuthInterceptor] (single-flight token refresh via injected [TokenStore] /
/// [TokenRefresher] / [SessionInvalidator] ports), [HeaderInterceptor], and
/// connectivity/logging seams.
///
/// This barrel is the public API of the package. `network` depends on nothing
/// internal — the interceptors' ports are injected from the outside.
library;

export 'src/network/auth_interceptor.dart';
export 'src/network/dio_factory.dart';
export 'src/network/header_interceptor.dart';
export 'src/network/ports.dart';
export 'src/network/seams.dart';
