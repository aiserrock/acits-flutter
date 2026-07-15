import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:injectable/injectable.dart';

import 'package:acits_flutter/util/logger/log.dart';

const _themeModeKey = 'theme_mode';

/// Персист выбранного [ThemeMode] в аппаратном хранилище.
///
/// Хранит `ThemeMode.index` строкой. При отсутствии/повреждении значения
/// возвращает [ThemeMode.system] — дефолт первого запуска.
@injectable
class ThemeStorage {
  ThemeStorage(this._secureStorage);

  final FlutterSecureStorage _secureStorage;

  /// Прочитать сохранённый режим темы. Дефолт — [ThemeMode.system].
  Future<ThemeMode> read() async {
    final raw = await _secureStorage.read(key: _themeModeKey);
    final index = int.tryParse(raw ?? '');
    if (index == null || index < 0 || index >= ThemeMode.values.length) {
      return ThemeMode.system;
    }
    return ThemeMode.values[index];
  }

  /// Сохранить выбранный режим темы.
  Future<void> write(ThemeMode mode) {
    Log.debug('Theme mode stored: ${mode.name}');
    return _secureStorage.write(key: _themeModeKey, value: mode.index.toString());
  }
}
