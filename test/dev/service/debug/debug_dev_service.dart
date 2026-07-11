import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:injectable/injectable.dart';

import 'package:acits_flutter/navigation/app_router.dart';
import 'package:acits_flutter/service/debug/debug_service.dart';

import '../../di/di_container.dart';
import '../../ui/debug_screen/debug_screen.dart';
import '../shared_pref/debug_preference_storage.dart';

/// Сервис отладки приложения
@Singleton(as: DebugService)
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

  set proxyEnabled(bool value) {
    _storage.proxyEnabled = value;
  }

  bool get proxyEnabled => _storage.proxyEnabled;

  set customUrl(String? url) {
    _storage.customUrl = url;
  }

  String? get customUrl => _storage.customUrl;

  Future<void> reloadApp() async {
    await getIt.reset();
    await initDevDi();
    getIt<GoRouter>().go(AppRoutes.onboarding);
  }

  /// Показать штатное уведомление внизу экрана о том, что для применения
  /// настройки нужен перезапуск приложения, с кнопкой немедленного рестарта.
  ///
  /// Используется для настроек, применяемых только при старте (proxy — ставится
  /// в HttpClient при создании клиента).
  void showRestartRequired([String message = 'Настройки изменены, нужен перезапуск']) {
    final messenger = getIt<GlobalKey<ScaffoldMessengerState>>().currentState;
    messenger
      ?..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(message),
          duration: const Duration(seconds: 8),
          action: SnackBarAction(label: 'Перезапустить', onPressed: reloadApp),
        ),
      );
  }
}
