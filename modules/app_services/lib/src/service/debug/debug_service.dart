import 'package:auth/auth.dart' show AuthDebugHook;
import 'package:injectable/injectable.dart';

@singleton
@prod
/// Сервис отладки приложения
class DebugService implements AuthDebugHook {
  /// Признак dev-флейвора. В prod-реализации — `false`; dev-реализация
  /// (`DebugDevService`) оверрайдит на `true`. Работает в любом build-режиме
  /// (profile/release тоже), поэтому даёт гейтить dev-only фичи (напр. роут
  /// UI Kit Gallery) без завязки на `kDebugMode`.
  bool get isDevFlavor => false;

  /// открыть экран отладки
  @override
  void openDebugScreen() {
    /// Попытка входа в дебаг экран на проде
  }
}
