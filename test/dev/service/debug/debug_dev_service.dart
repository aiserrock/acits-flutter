import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

import 'package:acits_flutter/service/debug/debug_service.dart';
import 'package:acits_flutter/ui/screen/onboarding/view/onboarding_route.dart';

import '../../di/di_container.dart';
import '../../ui/debug_screen/debug_screen.dart';
import '../shared_pref/debug_preference_storage.dart';

/// Сервис отладки приложения
@Singleton(
  as: DebugService,
)
@dev
class DebugDevService implements DebugService {
  DebugDevService(this._storage);

  final DebugPreferenceStorage _storage;

  /// Открыть экран отладки
  @override
  void openDebugScreen() {
    final navigator = getIt<GlobalKey<NavigatorState>>();
    navigator.currentState?.push(MaterialPageRoute(builder: (_) => const DebugScreen()));
  }

  set proxyUrl(String? proxyUrl) {
    _storage.proxy = proxyUrl;
  }

  String? get proxyUrl => _storage.proxy;

  set domainUrl(String? domainUrl) {
    _storage.baseUrl = domainUrl;
  }

  String? get domainUrl => _storage.baseUrl;

  Future<void> reloadApp() async {
    final navigator = getIt<GlobalKey<NavigatorState>>();
    await getIt.reset();
    navigator.currentState
      ?..popUntil((route) => false)
      ..push(OnboardingRoute());
    await initDevDi();
  }
}
