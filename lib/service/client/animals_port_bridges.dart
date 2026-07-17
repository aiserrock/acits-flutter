import 'package:animals/animals.dart';
import 'package:collection/collection.dart';
import 'package:injectable/injectable.dart';

import 'package:acits_flutter/gen/api/openapi.enums.swagger.dart';
import 'package:acits_flutter/service/auth/auth_service.dart';
import 'package:acits_flutter/service/config/config_service.dart';

/// Мосты между портами модуля `animals` и сервисами приложения. Модуль не знает
/// про [AuthService]/[ConfigService]; эти адаптеры инъектятся в его UI/bloc.
/// Зеркалит паттерн auth_port_bridges.dart.

/// Текущий приют из [AuthService] для скоупинга списка (`x-current-shelter`).
@Injectable(as: CurrentShelterProvider)
class AuthServiceCurrentShelter implements CurrentShelterProvider {
  const AuthServiceCurrentShelter(this._authService);

  final AuthService _authService;

  @override
  int? get shelterId => _authService.currentShelterId;
}

/// Права редактирования/удаления из роли пользователя в текущем приюте.
@Injectable(as: AnimalPermissions)
class AuthServiceAnimalPermissions implements AnimalPermissions {
  const AuthServiceAnimalPermissions(this._authService);

  final AuthService _authService;

  @override
  bool get canEdit => _authService.shelterRole?.canEdit ?? false;

  @override
  bool get canDelete => _authService.shelterRole?.canDelete ?? false;
}

/// Человекочитаемые названия статусов из серверного конфига ([ConfigService]).
/// Доменный [AnimalStatus] резолвится в [Status69fEnum] по wire-значению.
@Injectable(as: AnimalStatusLabels)
class ConfigServiceAnimalStatusLabels implements AnimalStatusLabels {
  const ConfigServiceAnimalStatusLabels(this._configService);

  final ConfigService _configService;

  @override
  String? label(AnimalStatus status) {
    final wire = status.wire;
    if (wire == null) return null;
    final enumValue = Status69fEnum.values.firstWhereOrNull((e) => e.value == wire);
    return enumValue == null ? null : _configService.getStatus131Name(enumValue);
  }
}
