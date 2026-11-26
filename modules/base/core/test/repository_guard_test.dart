import 'package:core/data.dart';
import 'package:dio/dio.dart';
// `Timeout` exists both in util (Failure) and in flutter_test.
import 'package:flutter_test/flutter_test.dart' hide Timeout;
import 'package:util/util.dart';

void main() {
  DioException dioError(DioExceptionType type, {int? status, Object? body}) => DioException(
    requestOptions: RequestOptions(path: '/'),
    type: type,
    response: status == null
        ? null
        : Response(
            requestOptions: RequestOptions(path: '/'),
            statusCode: status,
            data: body,
          ),
  );

  test('returns Ok with the value of the body', () async {
    expect((await guard(() async => 42)).valueOrNull, 42);
  });

  test('a typed Failure thrown inside the body passes through unchanged', () async {
    final result = await guard<int>(() async => throw const ForbiddenFailure());
    expect(result.failureOrNull, const ForbiddenFailure());
  });

  test('maps transport errors onto the Failure hierarchy', () async {
    Future<Failure?> failureOf(DioException e) async => (await guard<int>(() async => throw e)).failureOrNull;

    expect(await failureOf(dioError(DioExceptionType.connectionError)), const NoInternet());
    expect(await failureOf(dioError(DioExceptionType.receiveTimeout)), const Timeout());
    expect(await failureOf(dioError(DioExceptionType.badResponse, status: 401)), const AuthFailure());
    expect(await failureOf(dioError(DioExceptionType.badResponse, status: 403)), const ForbiddenFailure());
    expect(
      await failureOf(dioError(DioExceptionType.badResponse, status: 400, body: 'email: taken')),
      const ServerFailure(400, 'email: taken'),
    );
  });

  test('a parsing error becomes ParseFailure and anything else UnknownFailure', () async {
    expect((await guard<int>(() async => throw const FormatException('bad'))).failureOrNull, const ParseFailure());
    expect((await guard<int>(() async => throw StateError('boom'))).failureOrNull, const UnknownFailure());
  });

  test('reports the original error to onError, except for an already typed Failure', () async {
    final seen = <Object>[];
    await guard<int>(() async => throw StateError('boom'), onError: (e, _) => seen.add(e));
    await guard<int>(() async => throw const NoInternet(), onError: (e, _) => seen.add(e));
    expect(seen, hasLength(1));
    expect(seen.single, isA<StateError>());
  });
}
