import 'package:util/util.dart';
import 'package:dio/dio.dart';

import 'package:{{name.snakeCase()}}/data/data.dart';
import 'package:{{name.snakeCase()}}/domain/domain.dart';

/// Implementation of [{{name.pascalCase()}}Repository]. Here DTOs end: call the data
/// source, unwrap DTO → entity via mappers, catch exceptions → typed [Failure].
/// Only entities in a [Result] leave for the domain/UI.
class {{name.pascalCase()}}RepositoryImpl implements {{name.pascalCase()}}Repository {
  const {{name.pascalCase()}}RepositoryImpl(this._remote);

  final {{name.pascalCase()}}RemoteDataSource _remote;

  @override
  Future<Result<Failure, List<{{name.pascalCase()}}>>> list({int? shelterId}) {
    return _guard(() async {
      final dtos = await _remote.list(shelterId: shelterId);
      return dtos.map((d) => {{name.pascalCase()}}Mapper(d).toEntity()).toList(growable: false);
    });
  }

  @override
  Future<Result<Failure, {{name.pascalCase()}}>> getById(int id, {int? shelterId}) {
    return _guard(() async {
      final dto = await _remote.getById(id, shelterId: shelterId);
      return {{name.pascalCase()}}Mapper(dto).toEntity();
    });
  }

  Future<Result<Failure, T>> _guard<T>(Future<T> Function() body) async {
    try {
      return Ok(await body());
    } on DioException catch (e) {
      return Err(_mapDioException(e));
    } on FormatException {
      return const Err(ParseFailure());
    } catch (_) {
      return const Err(UnknownFailure());
    }
  }

  Failure _mapDioException(DioException e) {
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
}
