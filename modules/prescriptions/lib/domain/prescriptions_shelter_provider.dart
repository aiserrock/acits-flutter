/// Порт текущего приюта для модуля «Назначения».
///
/// [PrescriptionService] скоупит запросы по текущему приюту (`x-current-shelter`
/// в запросах, `shelter` в write-DTO через порт), но модуль не знает про
/// `AuthService` приложения — корень мостит этот порт к
/// `AuthService.currentShelterId` (паттерн из applicants_register.dart /
/// animals_port_bridges.dart).
abstract interface class PrescriptionsShelterProvider {
  /// Id текущего выбранного приюта (или null, если не выбран).
  int? get shelterId;
}
