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

/// Who is calling the API: sent with every request so the backend can tell
/// client versions apart (minimum supported version, staged deprecations).
/// A value returned empty is not sent.
abstract interface class ClientInfoProvider {
  /// Marketing version, e.g. `1.2.0`; empty when it could not be read.
  String get version;

  /// Build number shared by all stores; empty when it could not be read.
  String get buildNumber;

  /// `android` or `ios`; empty on platforms that must not send the headers.
  String get platform;
}
