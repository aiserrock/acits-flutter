/// Порт текущего приюта. Список животных скоупится по приюту (`x-current-shelter`),
/// но модуль не знает про AuthService приложения — корень мостит этот порт к
/// `AuthService.currentShelterId` (паттерн из auth_port_bridges.dart).
abstract interface class CurrentShelterProvider {
  /// Id текущего выбранного приюта (или null, если не выбран).
  int? get shelterId;
}
