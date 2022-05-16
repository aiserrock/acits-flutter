import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

@module
abstract class DioRegister {
  Dio createDioClient() {
    final options = BaseOptions(
      connectTimeout: 30000,
      receiveTimeout: 30000,
      sendTimeout: 30000,
    );
    return Dio(options);
  }
}
