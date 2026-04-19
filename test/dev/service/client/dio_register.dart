import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

@module
abstract class DioRegisterDev {
  @dev
  Dio createDioClient() {
    final options = BaseOptions(
      connectTimeout: const Duration(milliseconds: 30000),
      receiveTimeout: const Duration(milliseconds: 30000),
      sendTimeout: const Duration(milliseconds: 30000),
    );
    return Dio(options)..interceptors.add(LogInterceptor());
  }
}
