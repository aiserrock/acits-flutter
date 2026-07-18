import 'package:core/api.dart';
import 'package:animals/animals.dart' show AnimalRepository;
import 'package:injectable/injectable.dart';
import 'package:prescriptions/prescriptions.dart';

import 'package:app_services/src/service/auth/auth_service.dart';
import 'package:app_services/src/service/config/config_service.dart';

/// DI-модуль фичи «Назначения»: собирает [PrescriptionService] модуля поверх
/// стабильного [PrescriptionApiPort] (зарегистрирован в AcitsApiRegister) и
/// мостит порты модуля к сервисам приложения (приют, имена типов, загрузка
/// животного). Зеркалит паттерн applicants_register.dart / animals_port_bridges.dart.
@module
abstract class PrescriptionsRegister {
  @singleton
  PrescriptionService prescriptionService(
    PrescriptionApiPort port,
    PrescriptionsShelterProvider shelterProvider,
    PrescriptionTypeLabels typeLabels,
  ) => PrescriptionService(port, shelterProvider, typeLabels);
}

/// Текущий приют из [AuthService] для скоупинга запросов назначений.
@Injectable(as: PrescriptionsShelterProvider)
class AuthServicePrescriptionsShelter implements PrescriptionsShelterProvider {
  const AuthServicePrescriptionsShelter(this._authService);

  final AuthService _authService;

  @override
  int? get shelterId => _authService.currentShelterId;
}

/// Человекочитаемые имена типов назначений из серверного конфига
/// ([ConfigService]). [ensureLoaded] прогревает конфиг типов, если он ещё не
/// загружен (как раньше делал `PrescriptionService` через `getTypeValues`).
@Injectable(as: PrescriptionTypeLabels)
class ConfigServicePrescriptionTypeLabels implements PrescriptionTypeLabels {
  const ConfigServicePrescriptionTypeLabels(this._configService);

  final ConfigService _configService;

  @override
  String? nameForWire(String? wire) => _configService.getMyTypeName(wire);

  @override
  Future<void> ensureLoaded() async {
    if (_configService.typeValues == null) {
      await _configService.getTypeValues();
    }
  }
}

/// Загрузка лёгкой ссылки на животное через [AnimalRepository] (модуль animals)
/// — порт вместо прямой module→module зависимости между назначениями и животными.
@Injectable(as: PrescriptionAnimalLoader)
class AnimalRepositoryPrescriptionAnimalLoader implements PrescriptionAnimalLoader {
  const AnimalRepositoryPrescriptionAnimalLoader(this._repository, this._authService);

  final AnimalRepository _repository;
  final AuthService _authService;

  @override
  Future<PrescriptionAnimalRef?> loadById(int animalId) async {
    final result = await _repository.getById(animalId, shelterId: _authService.currentShelterId);
    return result.fold(
      (_) => null,
      (animal) => PrescriptionAnimalRef(id: animal.id, name: animal.name, thumbUrl: animal.thumb),
    );
  }
}
