// Порты, от которых зависят интерцепторы. Инъектятся снаружи — сам base
// не тянет GetIt/injectable и не знает про конкретный AuthService.

abstract interface class TokenStore {
  String? get accessToken;
}

abstract interface class TokenRefresher {
  /// Обновляет токен и возвращает новый access. `null` — сервер отверг refresh-токен,
  /// сессия закончена. Бросает, если до ответа сервера дело не дошло (нет сети,
  /// таймаут, 5xx) — сессия при этом остаётся.
  Future<String?> refresh();
}

abstract interface class SessionInvalidator {
  void invalidate();
}

abstract interface class LocaleProvider {
  String get locale;
}
