import 'package:core/api.dart';
import 'package:applicants/applicants.dart';
import 'package:injectable/injectable.dart';

import 'package:app_services/src/service/auth/auth_service.dart';

/// DI-модуль фичи «Заявители/кураторы»: собирает data-слой модуля поверх
/// стабильного [StaffApiPort] (зарегистрирован в AcitsApiRegister) и мостит порт
/// текущего приюта к [AuthService]. Наружу отдаёт домен — [StaffRepository];
/// UI-фича резолвит его, а не конкретную реализацию. Зеркалит паттерн
/// animals_register.dart / animals_port_bridges.dart.
@module
abstract class ApplicantsRegister {
  @Singleton(as: StaffRepository)
  StaffRepositoryImpl staffRepository(ApplicantsShelterProvider shelterProvider, StaffApiPort port) =>
      StaffRepositoryImpl(shelterProvider, port);

  /// Тонкая обёртка над репозиторием для generic-поиска модуля media
  /// (он рвёт метод в коллбэк и не умеет разворачивать Result).
  @singleton
  StaffService staffService(StaffRepository repository) => StaffService(repository);
}

/// Текущий приют из [AuthService] для скоупинга записей staff-репозитория.
@Injectable(as: ApplicantsShelterProvider)
class AuthServiceApplicantsShelter implements ApplicantsShelterProvider {
  const AuthServiceApplicantsShelter(this._authService);

  final AuthService _authService;

  @override
  int? get shelterId => _authService.currentShelterId;
}
