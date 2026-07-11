import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

import 'package:acits_flutter/service/debug/debug_service.dart';
import 'package:acits_flutter/util/restart_widget.dart';

import '../../di/di_container.dart';
import '../../ui/debug_screen/applying_overlay.dart';
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

  /// Пересоздаёт окружение (DI + всё дерево виджетов), показывая заставку
  /// «Применение…» на тёмном фоне. Используется при смене контура/custom-URL.
  ///
  /// Заставка живёт до рестарта дерева, который её уничтожает вместе со старым
  /// Overlay — отдельно скрывать не нужно.
  Future<void> reloadApp() async {
    // Берём context ДО reset (после reset navigatorKey пересоздаётся и старый
    // становится невалидным).
    final context = getIt<GlobalKey<NavigatorState>>().currentContext;

    // Заставка применения поверх всего.
    if (context != null && context.mounted) {
      ApplyingOverlay.show(context);
    }
    // Небольшая пауза, чтобы заставка успела отрисоваться и была видна.
    await Future<void>.delayed(const Duration(milliseconds: 900));

    await getIt.reset();
    await initDevDi();

    // Полный рестарт дерева виджетов: все BlocProvider (LoginBloc и др.)
    // пересоздаются и берут СВЕЖИЙ AuthService/клиенты из getIt. Без этого
    // старые блоки держали бы прежний AuthService (старый хост + токен),
    // из-за чего логин уходил на один контур, а refresh/shelters — на другой.
    if (context != null && context.mounted) {
      RestartWidget.restartApp(context);
    }
  }

  /// Показать штатное уведомление внизу экрана о том, что для применения
  /// настройки нужен ПОЛНЫЙ ручной перезапуск приложения (закрыть и открыть).
  ///
  /// Нужно для proxy: он ставится в `HttpOverrides`/`HttpClient` при создании
  /// клиента, и мягкий рестарт дерева (reloadApp) его не всегда подхватывает —
  /// системному прокси нужен свежий процесс. Показываем долго-живущий SnackBar.
  void showRestartRequired([
    String message = 'Прокси изменён — перезапустите приложение вручную (закрыть и открыть)',
  ]) {
    final messenger = getIt<GlobalKey<ScaffoldMessengerState>>().currentState;
    messenger
      ?..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(message),
          duration: const Duration(seconds: 10),
          behavior: SnackBarBehavior.floating,
          action: SnackBarAction(label: 'OK', onPressed: messenger.hideCurrentSnackBar),
        ),
      );
  }
}
