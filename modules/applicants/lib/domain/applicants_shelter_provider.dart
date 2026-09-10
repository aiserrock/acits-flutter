/// Порт текущего приюта для модуля «Заявители/кураторы».
///
/// `StaffRepositoryImpl` скоупит записи по текущему приюту (`shelter` в write-DTO,
/// `x-current-shelter` в запросах), но модуль не знает про `AuthService`
/// приложения — корень мостит этот порт к `AuthService.currentShelterId`
/// (паттерн из animals_port_bridges.dart / auth_port_bridges.dart).
abstract interface class ApplicantsShelterProvider {
  /// Id текущего выбранного приюта (или null, если не выбран).
  int? get shelterId;
}
