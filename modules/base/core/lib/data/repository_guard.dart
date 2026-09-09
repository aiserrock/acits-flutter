import 'package:dio/dio.dart';
import 'package:util/util.dart';

/// Runs a repository body and converts anything it throws into a typed
/// [Failure], so repositories can return `Result` without each one restating
/// the same dio-exception mapping.
///
/// Belongs to the data layer by contract: it is the seam where transport
/// exceptions stop and `Result` begins. Nothing above a repository should
/// need it.
///
/// This is also the last place the original exception and its stack trace
/// exist — above here only the [Failure] survives, and a bare `const
/// UnknownFailure()` tells a crash report nothing. Pass [onError] to log them.
Future<Result<Failure, T>> guard<T>(
  Future<T> Function() body, {
  void Function(Object error, StackTrace stackTrace)? onError,
}) async {
  try {
    return Ok(await body());
  } on DioException catch (e, s) {
    onError?.call(e, s);
    return Err(mapDioException(e));
  } on FormatException catch (e, s) {
    onError?.call(e, s);
    return const Err(ParseFailure());
  } catch (e, s) {
    onError?.call(e, s);
    return const Err(UnknownFailure());
  }
}

/// Maps a dio transport error onto the [Failure] hierarchy.
Failure mapDioException(DioException e) {
  switch (e.type) {
    case DioExceptionType.connectionTimeout:
    case DioExceptionType.sendTimeout:
    case DioExceptionType.receiveTimeout:
    case DioExceptionType.transformTimeout:
      return const Timeout();
    case DioExceptionType.connectionError:
      return const NoInternet();
    case DioExceptionType.badResponse:
      final code = e.response?.statusCode;
      if (code == 401 || code == 403) return const AuthFailure();
      // Тело ответа несёт причину отказа (валидация DRF: какое поле и почему).
      // statusMessage — только сухая HTTP-фраза («Bad Request»), по которой
      // пользователь не поймёт, что исправить; берём его лишь как запасной.
      final body = e.response?.data;
      return ServerFailure(code ?? 0, body?.toString() ?? e.response?.statusMessage);
    case DioExceptionType.badCertificate:
    case DioExceptionType.cancel:
    case DioExceptionType.unknown:
      return const UnknownFailure();
  }
}
