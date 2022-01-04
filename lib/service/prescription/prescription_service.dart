import 'package:acits_flutter/domain/exception.dart';
import 'package:acits_flutter/service/config/config_service.dart';
import 'package:injectable/injectable.dart';

import 'package:acits_flutter/api/openapi.swagger.dart';
import 'package:acits_flutter/util/util.dart';

import 'package:acits_flutter/service/auth/auth_service.dart';

@singleton
class PrescriptionService {
  PrescriptionService(
    this._acitsClient,
    this._authService,
    this._configService,
  );

  final Openapi _acitsClient;
  final AuthService _authService;
  final ConfigService _configService;

  Future<PaginatedPrescriptionExecutionTodayList?>
      fetchTodayPrescriptionList() async {
    if (_configService.typeValues == null) {
      await _configService.getTypeValues();
    }
    final time = DateTime.now();
    final from = DateTime(time.year, time.month, time.day);
    final to = from.add(const Duration(days: 1));
    final result = await _acitsClient.apiV1PrescriptionsExecutionsGet(
      xCurrentShelter: _authService.currentShelterId,
      from: from.toIso8601String(),
      to: to.toIso8601String(),
    );
    if (result.body != null) {
      return result.body;
    } else {
      throw MesssagedException(error: result.error);
    }
  }

  /// получить список назначений для животного по его ID
  Future<PaginatedAnimalPrescriptionList?> fetchPrescriptionListByAnimal(
    int animalId, {
    int? limit,
    int offset = 0,
    bool? isActual,
    bool? isOld,
  }) async {
    if (_configService.typeValues == null) {
      await _configService.getTypeValues();
    }

    final result = await _acitsClient.apiV1AnimalsIdPrescriptionsGet(
      id: animalId,
      xCurrentShelter: _authService.currentShelterId,
      limit: limit,
      offset: offset,
      executeAtGte: isActual ?? false ? DateTime.now().toIso8601String() : null,
      executeAtLt: isOld ?? false ? DateTime.now().toIso8601String() : null,
    );
    if (result.body != null) {
      return result.body;
    } else {
      throw MesssagedException(error: result.error);
    }
  }

  String? getTypeName(MyTypeEnum? type) => _configService.getMyTypeName(type);
}
