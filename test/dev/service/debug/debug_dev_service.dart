import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:talker_flutter/talker_flutter.dart';

import 'package:acits_flutter/service/debug/debug_service.dart';
import 'package:acits_flutter/util/logger/app_bloc_observer.dart';
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

  /// Видимость плавающей debug-кнопки (по образцу a production app):
  /// скрывается на время открытого debug-экрана и по long-press на кнопке.
  final _buttonVisibility = StreamController<bool>.broadcast();

  Stream<bool> get debugButtonStream => _buttonVisibility.stream;

  void showDebugButton() => _buttonVisibility.add(true);

  void hideDebugButton() => _buttonVisibility.add(false);

  /// Открыть экран отладки. Кнопка скрывается на время экрана и
  /// возвращается после его закрытия (pop).
  @override
  void openDebugScreen() {
    final navigator = getIt<GlobalKey<NavigatorState>>();
    hideDebugButton();
    navigator.currentState
        ?.push(MaterialPageRoute<void>(builder: (_) => const DebugScreen()))
        .whenComplete(showDebugButton);
  }

  set proxyUrl(String? proxyUrl) {
    _storage.proxy = proxyUrl;
  }

  String? get proxyUrl => _storage.proxy;

  set domainUrl(String? domainUrl) {
    // Обрезаем хвостовые '/', иначе chopper склеит baseUrl + '/api/...' в
    // '//api/...' (Mockoon это глотает, но в логах/URL выглядит криво).
    _storage.baseUrl = domainUrl?.replaceAll(RegExp(r'/+$'), '');
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
    // Заставка применения поверх всего — кладётся в Stack внутри RestartWidget
    // (не через Overlay, т.к. debug-экран уже закрыт и Overlay-контекста нет).
    // RestartWidget.current стабилен между reset/init DI.
    RestartWidget.showOverlay(const ApplyingOverlay());

    // Небольшая пауза, чтобы заставка успела отрисоваться и была видна.
    await Future<void>.delayed(const Duration(milliseconds: 900));

    await getIt.reset();
    await initDevDi();

    // getIt.reset() пересоздал Talker — переустанавливаем bloc-observer на новый
    // инстанс, иначе логи cubit'ов уходили бы в уничтоженный старый Talker.
    Bloc.observer = createAppBlocObserver(getIt<Talker>());

    // Полный рестарт дерева виджетов: все BlocProvider (LoginBloc и др.)
    // пересоздаются и берут СВЕЖИЙ AuthService/клиенты из getIt. Заодно убирает
    // заставку (новое дерево строится без неё). Без рестарта старые блоки держали
    // бы прежний AuthService (старый хост+токен) → логин на один контур, а
    // refresh/shelters — на другой.
    RestartWidget.restartApp();
  }

  /// Показать снекбар снизу о том, что для применения прокси нужен ПОЛНЫЙ ручной
  /// перезапуск приложения (закрыть и открыть заново).
  ///
  /// Прокси ставится глобально (`HttpOverrides.global`) при старте процесса —
  /// мягкий рестарт дерева его не применяет, нужен свежий процесс.
  void showRestartRequired([String message = 'Прокси изменён — перезапустите приложение вручную (закрыть и открыть)']) {
    final messenger = getIt<GlobalKey<ScaffoldMessengerState>>().currentState;
    messenger
      ?..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(content: Text(message), duration: const Duration(seconds: 6), behavior: SnackBarBehavior.floating),
      );
  }
}
