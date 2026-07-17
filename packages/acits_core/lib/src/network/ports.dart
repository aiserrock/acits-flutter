// Порты, от которых зависят интерцепторы. Инъектятся снаружи — сам acits_core
// не тянет GetIt/injectable и не знает про конкретный AuthService.

abstract interface class TokenStore {
  String? get accessToken;
}

abstract interface class TokenRefresher {
  /// Обновляет токен. Возвращает новый access или null, если refresh не удался.
  Future<String?> refresh();
}

abstract interface class SessionInvalidator {
  void invalidate();
}

abstract interface class LocaleProvider {
  String get locale;
}
