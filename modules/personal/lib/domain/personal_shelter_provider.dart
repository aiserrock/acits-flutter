/// Порт текущего приюта + сигнала разлогина для модуля «Личный кабинет».
///
/// [PersonalRepository] скоупит запросы по текущему приюту (`x-current-shelter`) и
/// сбрасывает кеш профиля при разлогине, но модуль не знает про `AuthService`
/// приложения — корень мостит этот порт к `AuthService` (который сам является
/// `ChangeNotifier` и уведомляет о разлогине). Паттерн из
/// applicants_register.dart / prescriptions_register.dart.
abstract interface class PersonalShelterProvider {
  /// Id текущего выбранного приюта (или null, если не выбран).
  int? get shelterId;

  /// Подписаться на разлогин (для сброса кеша профиля).
  void addLogoutListener(void Function() listener);

  /// Отписаться от разлогина.
  void removeLogoutListener(void Function() listener);
}
