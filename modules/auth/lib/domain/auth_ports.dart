/// Порт открытия debug-экрана из формы логина (long-press по кнопке входа).
/// Приложение реализует его своим `DebugService` (no-op в проде).
abstract interface class AuthDebugHook {
  void openDebugScreen();
}

/// Порт обработки deep-link'ов на экране входа (reset-пароль/подтверждение).
/// Приложение реализует его своим `DeepLinkService`.
abstract interface class AuthDeepLinkHandler {
  /// Начальная ссылка сброса, если приложение открыто по deep-link'у.
  String? getResetInitLink();

  /// Обработать полученную ссылку.
  void onLinkHandle(String link);
}

/// Порт конфигурации приюта: загрузить справочники после выбора приюта
/// (типы значений / атрибуты животных). Приложение реализует его
/// `ConfigService`. Также помечает завершение онбординга (первый запуск).
abstract interface class AuthConfigInitializer {
  /// Первый ли это запуск приложения (показывать онбординг).
  bool get isFirstLaunch;

  /// Загрузить конфиг для выбранного приюта [currentShelterId].
  Future<void> initConfig({int? currentShelterId});

  /// Пометить, что онбординг пройден (первый запуск завершён).
  void setFirstLaunch();
}
