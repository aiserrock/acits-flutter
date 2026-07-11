class Env {
  Env(this.apiUrl, {this.proxy});

  final String apiUrl;

  /// Optional proxy IP:PORT
  /// will be conveted to 'PROXY 192.168.0.102:9090'
  /// for http client .findProxy
  final String? proxy;
}

/// Базовые URL контуров бэкенда (app-frontend/app-backend).
///
/// Единый источник адресов окружений:
///   prod    → https://app.acits.ru
///   stage   → https://stage.app.acits.ru
///   dev-N   → https://dev-N.app.acits.ru (N = 0..3)
///
/// prod-флейвор ходит на [prod], dev-флейвор по умолчанию на [stage];
/// в dev можно переключиться на любой контур из [all] через debug-экран.
abstract class AcitsEnvUrls {
  static const prod = 'https://app.acits.ru';
  static const stage = 'https://stage.app.acits.ru';

  /// Номера доступных dev-контуров (dev-0 .. dev-3).
  static const devIndexes = [0, 1, 2, 3];

  static String dev(int n) => 'https://dev-$n.app.acits.ru';

  /// Все контуры для ручного переключения в dev-режиме
  /// (prod, stage, затем dev-0..3).
  static final List<String> all = [prod, stage, ...devIndexes.map(dev)];
}
