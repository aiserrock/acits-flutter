import 'dart:async';
import 'dart:io';

import 'package:chopper/chopper.dart';
import 'package:injectable/injectable.dart';

import 'package:acits_flutter/di/di_container.dart';
import 'package:acits_flutter/service/auth/auth_service.dart';


@injectable
class AuthInterceptor implements Authenticator {
  @override
  FutureOr<Request?> authenticate(
    Request request,
    Response response, [
    Request? _,
  ]) async {
    if (response.statusCode == HttpStatus.unauthorized) {
      final authService = getIt<AuthService>();
      final token = await authService.refreshToken().then((value) => value?.access);
      if (token != null) {
        return request.copyWith(
            headers: request.headers..addAll({'authorization': 'Bearer $token'}));
      }
    } else {
      return null;
    }
    return null;
  }
}
