import 'package:injectable/injectable.dart';

import 'package:acits_flutter/export.dart';

import 'package:acits_flutter/service/auth/auth_service.dart';
import 'package:acits_flutter/domain/exception.dart';
import 'package:acits_flutter/service/config/config_service.dart';

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

  Future<PaginatedPrescriptionExecutionTodayList?> fetchTodayPrescriptionList() async {
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
      throw MessagedException(error: result.error);
    }
  }

  /// получить список назначений для животного по его ID
  Future<PaginatedPrescriptionList?> fetchPrescriptionListByAnimal(
    int animalId, {
    int? limit,
    int offset = 0,
    bool isActual = false,
    bool isOld = false,
  }) async {
    if (_configService.typeValues == null) {
      await _configService.getTypeValues();
    }

    final result = await _acitsClient.apiV1PrescriptionsGet(
      animal: animalId,
      xCurrentShelter: _authService.currentShelterId,
      limit: limit,
      offset: offset,
      executeAtGte: isActual ? DateTime.now().toUtc().toPatchApiDate : null,
      executeAtLt: isOld ? DateTime.now().toIso8601String() : null,
    );
    if (result.body != null) {
      return result.body;
    } else {
      throw MessagedException(error: result.error);
    }
  }

  /// получить назначение для животного по ID назначения
  Future<Prescription?> fetchPrescriptionById(int id) async {
    final result = await _acitsClient.apiV1PrescriptionsIdGet(
      id: id,
      xCurrentShelter: _authService.currentShelterId,
    );

    if (result.body != null) {
      return result.body;
    } else {
      throw MessagedException(error: result.error);
    }
  }

  /// Создать новое назначение
  Future<Prescription?> createPrescription(Prescription prescription) async {
    final result = await _acitsClient.apiV1PrescriptionsPost(
      body: prescription.copyWith(files: prescription.files ?? []),
      xCurrentShelter: _authService.currentShelterId,
    );

    if (result.body != null) {
      return result.body;
    } else {
      throw MessagedException(error: result.error);
    }
  }

  String? getTypeName(MyTypeEnum? type) => _configService.getMyTypeName(type);

  /// Получить список лекарств
  Future<PaginatedShelterDrugList?> fetchDrugList({
    String? search,
    int? limit,
    int offset = 0,
  }) async {
    final result = await _acitsClient.apiV1ShelterDrugsGet(
      xCurrentShelter: _authService.currentShelterId,
      search: search,
      limit: limit,
      offset: offset,
    );
    if (result.body != null) {
      return result.body;
    } else {
      throw MessagedException(error: result.error);
    }
  }
}
