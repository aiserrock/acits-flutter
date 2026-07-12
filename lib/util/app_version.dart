import 'package:flutter/foundation.dart';
import 'package:package_info_plus/package_info_plus.dart';

/// Версия приложения (номер версии + билда) из pubspec/нативных метаданных.
///
/// Значение читается один раз при старте ([load]) и кэшируется, чтобы UI мог
/// показывать его синхронно (например, в тексте под формой логина или в AppBar).
/// Работает на всех платформах, включая web (данные подставляются сборкой).
abstract final class AppVersion {
  static String _version = '';
  static String _buildNumber = '';

  /// Загрузить версию из [PackageInfo]. Вызывается один раз в `main()` до
  /// запуска приложения. Ошибки проглатываются — версия не критична для UI.
  static Future<void> load() async {
    try {
      final info = await PackageInfo.fromPlatform();
      _version = info.version;
      _buildNumber = info.buildNumber;
    } catch (_) {
      // Метаданные недоступны (редкий кейс) — оставляем пустые строки.
    }
  }

  /// Короткая метка вида `v0.7.0 (20)`. Пустая строка, если [load] не отработал.
  static String get label {
    if (_version.isEmpty) return '';
    return _buildNumber.isEmpty ? 'v$_version' : 'v$_version ($_buildNumber)';
  }

  /// Режим сборки Flutter: `debug` / `profile` / `release`.
  static String get buildMode {
    if (kReleaseMode) return 'release';
    if (kProfileMode) return 'profile';
    return 'debug';
  }

  /// Метка версии + режим сборки: `v0.7.0 (20) · debug`.
  static String get labelWithMode {
    final v = label;
    return v.isEmpty ? buildMode : '$v · $buildMode';
  }
}
