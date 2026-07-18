import 'package:core/api.dart';
import 'package:applicants/applicants.dart';
import 'package:injectable/injectable.dart';

import 'package:app_services/src/service/auth/auth_service.dart';

/// DI-модуль фичи «Заявители/кураторы»: собирает [StaffService] модуля поверх
/// стабильного [StaffApiPort] (зарегистрирован в AcitsApiRegister) и мостит порт
/// текущего приюта к [AuthService]. Зеркалит паттерн animals_register.dart /
/// animals_port_bridges.dart.
@module
abstract class ApplicantsRegister {
  @singleton
  StaffService staffService(ApplicantsShelterProvider shelterProvider, StaffApiPort port) =>
      StaffService(shelterProvider, port);
}

/// Текущий приют из [AuthService] для скоупинга записей staff-сервиса.
@Injectable(as: ApplicantsShelterProvider)
class AuthServiceApplicantsShelter implements ApplicantsShelterProvider {
  const AuthServiceApplicantsShelter(this._authService);

  final AuthService _authService;

  @override
  int? get shelterId => _authService.currentShelterId;
}
