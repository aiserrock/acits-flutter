import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

@module
abstract class DioRegister {
  @prod
  Dio createDioClient() {
    final options = BaseOptions(
      connectTimeout: const Duration(milliseconds: 30000),
      receiveTimeout: const Duration(milliseconds: 30000),
      sendTimeout: const Duration(milliseconds: 30000),
    );
    return Dio(options);
  }
}
