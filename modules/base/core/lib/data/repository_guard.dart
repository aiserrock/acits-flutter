import 'package:dio/dio.dart';
import 'package:util/util.dart';

/// Runs a repository body and converts anything it throws into a typed
/// [Failure], so repositories can return `Result` without each one restating
/// the same dio-exception mapping.
///
/// Belongs to the data layer by contract: it is the seam where transport
/// exceptions stop and `Result` begins. Nothing above a repository should
/// need it.
Future<Result<Failure, T>> guard<T>(Future<T> Function() body) async {
  try {
    return Ok(await body());
  } on DioException catch (e) {
    return Err(mapDioException(e));
  } on FormatException {
    return const Err(ParseFailure());
  } catch (_) {
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
      return ServerFailure(code ?? 0, e.response?.statusMessage);
    case DioExceptionType.badCertificate:
    case DioExceptionType.cancel:
    case DioExceptionType.unknown:
      return const UnknownFailure();
  }
}
