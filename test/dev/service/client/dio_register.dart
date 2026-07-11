import 'package:dio/dio.dart';
import 'package:flutter_alice/alice.dart';
import 'package:injectable/injectable.dart';

import '../../di/di_container.dart';

@module
abstract class DioRegisterDev {
  @dev
  Dio createDioClient() {
    final options = BaseOptions(
      connectTimeout: const Duration(milliseconds: 30000),
      receiveTimeout: const Duration(milliseconds: 30000),
      sendTimeout: const Duration(milliseconds: 30000),
    );
    // Alice HTTP-инспектор (dev): dio-трафик (файлы, email-confirm) виден в
    // debug-меню → «HTTP». LogInterceptor оставлен для консольного вывода.
    return Dio(options)
      ..interceptors.add(LogInterceptor())
      ..interceptors.add(getIt<Alice>().getDioInterceptor());
  }
}
