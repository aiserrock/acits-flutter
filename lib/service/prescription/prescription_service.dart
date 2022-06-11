import 'package:injectable/injectable.dart';

import 'package:acits_flutter/export.dart';

import 'package:acits_flutter/service/auth/auth_service.dart';
import 'package:acits_flutter/domain/exception.dart';
import 'package:acits_flutter/service/config/config_service.dart';

/// Сервис назначений
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
      return _toLocalExecutionsList(result.body);
    } else {
      throw MessagedException(error: result.error ?? result.bodyString);
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
      executeAtLt: isOld ? DateTime.now().toUtc().toIso8601String() : null,
    );
    if (result.body != null) {
      return _toLocalList(result.body);
    } else {
      throw MessagedException(error: result.error ?? result.bodyString);
    }
  }

  /// получить назначение для животного по ID назначения
  Future<Prescription?> fetchPrescriptionById(int id) async {
    final result = await _acitsClient.apiV1PrescriptionsIdGet(
      id: id,
      xCurrentShelter: _authService.currentShelterId,
    );

    if (result.body != null) {
      return result.body?.copyWith(
        executions: _toLocal(
          result.body?.executions ?? [],
        ),
      );
    } else {
      throw MessagedException(error: result.error ?? result.bodyString);
    }
  }

  /// Создать новое назначение
  Future<Prescription?> createPrescription(Prescription prescription) async {
    final result = await _acitsClient.apiV1PrescriptionsPost(
      body: prescription.copyWith(
        files: prescription.files ?? [],
        executions: _toUtc(
          prescription.executions ?? [],
        ),
      ),
      xCurrentShelter: _authService.currentShelterId,
    );

    if (result.body != null) {
      return result.body;
    } else {
      throw MessagedException(error: result.error ?? result.bodyString);
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
      throw MessagedException(error: result.error ?? result.bodyString);
    }
  }

  /// Изменить назначение
  Future<Prescription?> updatePrescription(Prescription prescription) async {
    final result = await _acitsClient.apiV1PrescriptionsIdPut(
      id: prescription.id,
      body: prescription.copyWith(
        files: prescription.files ?? [],
        executions: _toUtc(
          prescription.executions ?? [],
        ),
      ),
      xCurrentShelter: _authService.currentShelterId,
    );

    if (result.body != null) {
      return result.body;
    } else {
      throw MessagedException(error: result.error ?? result.bodyString);
    }
  }

  List<PrescriptionExecution> _toUtc(List<PrescriptionExecution> local) {
    return local.map((item) => item.copyWith(executeAt: item.executeAt?.toUtc())).toList();
  }

  List<PrescriptionExecution> _toLocal(List<PrescriptionExecution> utc) {
    return utc.map((item) => item.copyWith(executeAt: item.executeAt?.toLocal())).toList();
  }

  PaginatedPrescriptionList? _toLocalList(PaginatedPrescriptionList? utc) {
    if (utc == null) return null;

    return utc.copyWith(
        results: utc.results
            ?.map((item) => item.copyWith(executions: _toLocal(item.executions ?? [])))
            .toList());
  }

  PaginatedPrescriptionExecutionTodayList? _toLocalExecutionsList(
      PaginatedPrescriptionExecutionTodayList? utc) {
    if (utc == null) return null;

    return utc.copyWith(
        results: utc.results
            ?.map((item) => item.copyWith(executeAt: item.executeAt?.toLocal()))
            .toList());
  }
}
