import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

import 'package:acits_flutter/service/debug/debug_service.dart';
import 'package:acits_flutter/service/shared_pref/preference_storage.dart';
import 'package:acits_flutter/ui/screen/onboarding/onboarding_route.dart';

import '../../di/di_container.dart';
import '../../ui/debug_screen/debug_screen.dart';

/// Сервис отладки приложения
@Singleton(
  as: DebugService,
)
@dev
class DebugDevService implements DebugService {
  DebugDevService(this._storage);

  final PreferenceStorage _storage;

  /// Открыть экран отладки
  @override
  void openDebugScreen() {
    final navigator = getIt<GlobalKey<NavigatorState>>();
    navigator.currentState?.push(MaterialPageRoute(builder: (_) => const DebugScreen()));
  }

  void setProxy(String? proxyUrl) {
    _storage.proxy = proxyUrl;
    reloadApp();
  }

  Future<void> reloadApp() async {
    final navigator = getIt<GlobalKey<NavigatorState>>();
    await getIt.reset();
    navigator.currentState
      ?..popUntil((route) => false)
      ..push(OnboardingRoute());
    await initDevDi();
  }
}
