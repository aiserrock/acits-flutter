import 'package:acits_flutter/di/di_container.dart';
import 'package:acits_flutter/service/auth/auth_service.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  setUpAll(
    () {
      initDi();
    },
  );

  testLogin();

  group('refresh token', () {
    setUp(
      () async {
        await _preLogin();
      },
    );
    testRefresh();
  });
}

Future<void> testLogin() async {
  return test(
    'login',
    () async {
      final _service = getIt<AuthService>();
      final result = await _service.login(
        'test_user_2',
        'user10000',
      );
      print(result?.access);
      expect(
        result?.access != null,
        true,
        reason: 'Didn\'t have token',
      );
    },
  );
}

Future<void> testRefresh() async {
  return test(
    'refresh token',
    () async {
      final _service = getIt<AuthService>();
      final result = await _service.refreshToken();
      print(result?.access);
      expect(
        _service.access != null,
        true,
        reason: 'Didn\'t have token after refresh',
      );
    },
  );
}

Future<void> _preLogin() async {
  final _service = getIt<AuthService>();
  final result = await _service.login(
    'test_user_2',
    'user10000',
  );
}
