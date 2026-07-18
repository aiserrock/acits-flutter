import 'package:util/util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:di/di.dart';
import 'package:app_services/app_services.dart';

/// Держит текущий [ThemeMode] приложения (System/Light/Dark) и персистит выбор.
///
/// Состояние — сам enum [ThemeMode]: асинхронного контента для отображения нет,
/// переключателю нужен только текущий режим. Дефолт до загрузки — system.
class ThemeCubit extends Cubit<ThemeMode> {
  ThemeCubit() : _storage = getIt<ThemeStorage>(), super(ThemeMode.system) {
    _load();
  }

  final ThemeStorage _storage;

  Future<void> _load() async {
    final mode = await _storage.read();
    Log.debug('ThemeCubit loaded mode: ${mode.name}');
    safeEmit(mode);
  }

  /// Сменить режим темы: применяется мгновенно и сохраняется в хранилище.
  Future<void> setMode(ThemeMode mode) async {
    if (mode == state) return;
    safeEmit(mode);
    await _storage.write(mode);
  }
}
