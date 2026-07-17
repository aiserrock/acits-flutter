import 'package:acits_api/acits_api.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import 'package:acits_flutter/domain/exception.dart';
import 'package:acits_flutter/domain/prescription/animal_short.dart';
import 'package:acits_flutter/domain/prescription/drug.dart';
import 'package:acits_flutter/domain/prescription/prescription.dart';
import 'package:acits_flutter/domain/prescription/prescription_drug.dart';
import 'package:acits_flutter/domain/prescription/prescription_execution.dart';
import 'package:acits_flutter/domain/prescription/prescription_execution_today.dart';
import 'package:acits_flutter/domain/prescription/prescription_file.dart';
import 'package:acits_flutter/domain/prescription/prescription_type.dart';
import 'package:acits_flutter/service/auth/auth_service.dart';
import 'package:acits_flutter/service/config/config_service.dart';
import 'package:acits_flutter/util/logger/log.dart';

/// Сервис назначений.
///
/// Прикладной сервис поверх стабильного [PrescriptionApiPort]: вызывает порт,
/// разворачивает DTO → доменные сущности, ошибки Dio → [MessagedException]
/// (внешний контракт для UI сохранён). Порт скрывает полиморфизм назначения и
/// генератор клиента.
@singleton
class PrescriptionService {
  PrescriptionService(this._port, this._authService, this._configService);

  final PrescriptionApiPort _port;
  final AuthService _authService;
  final ConfigService _configService;

  Future<List<PrescriptionExecutionToday>> fetchTodayPrescriptionList({String? search, String? ordering}) async {
    Log.debug('Fetch today prescription executions: search=$search ordering=$ordering');
    if (_configService.typeValues == null) {
      await _configService.getTypeValues();
    }
    try {
      final dtos = await _port.todayExecutions(
        search: search,
        ordering: ordering,
        shelterId: _authService.currentShelterId,
      );
      Log.info('Today prescription executions loaded: count=${dtos.length}');
      // executeAt приходит в UTC — переводим в локальное для отображения времени.
      return dtos.map(_mapExecutionToday).toList(growable: false);
    } on DioException catch (e) {
      Log.warning('Fetch today prescription executions failed: ${_errorText(e)}');
      throw MessagedException(error: _errorText(e));
    }
  }

  /// Получить список назначений для животного по его ID (актуальные/прошлые).
  Future<List<Prescription>> fetchPrescriptionListByAnimal(
    int animalId, {
    int? limit,
    int offset = 0,
    bool isActual = false,
    bool isOld = false,
  }) async {
    Log.debug(
      'Fetch prescriptions by animal: animalId=$animalId limit=$limit offset=$offset isActual=$isActual isOld=$isOld',
    );
    if (_configService.typeValues == null) {
      await _configService.getTypeValues();
    }
    try {
      final dtos = await _port.listByAnimal(
        animalId,
        isActual: isActual,
        isOld: isOld,
        limit: limit,
        offset: offset,
        shelterId: _authService.currentShelterId,
      );
      Log.info('Prescriptions by animal loaded: animalId=$animalId count=${dtos.length}');
      return dtos.map(_mapPrescription).map(_toLocal).toList(growable: false);
    } on DioException catch (e) {
      Log.warning('Fetch prescriptions by animal failed: animalId=$animalId ${_errorText(e)}');
      throw MessagedException(error: _errorText(e));
    }
  }

  /// Получить назначение по ID.
  Future<Prescription> fetchPrescriptionById(int id) async {
    Log.debug('Fetch prescription by id: id=$id');
    try {
      final dto = await _port.getById(id, shelterId: _authService.currentShelterId);
      Log.info('Prescription loaded: id=$id');
      return _toLocal(_mapPrescription(dto));
    } on DioException catch (e) {
      Log.warning('Fetch prescription by id failed: id=$id ${_errorText(e)}');
      throw MessagedException(error: _errorText(e));
    }
  }

  /// Создать новое назначение.
  Future<Prescription> createPrescription(Prescription prescription) async {
    Log.debug('Create prescription: animalId=${prescription.animal}');
    try {
      final dto = await _port.create(_toWriteDto(prescription), shelterId: _authService.currentShelterId);
      final model = _mapPrescription(dto);
      Log.info('Prescription created: id=${model.id}');
      return model;
    } on DioException catch (e) {
      Log.warning('Create prescription failed: ${_errorText(e)}');
      throw MessagedException(error: _errorText(e));
    }
  }

  /// Изменить назначение.
  Future<Prescription> updatePrescription(Prescription prescription) async {
    Log.debug('Update prescription: id=${prescription.id}');
    final id = prescription.id;
    if (id == null) throw MessagedException(error: 'Prescription id is required for update');
    try {
      final dto = await _port.update(id, _toWriteDto(prescription), shelterId: _authService.currentShelterId);
      final model = _mapPrescription(dto);
      Log.info('Prescription updated: id=${model.id}');
      return model;
    } on DioException catch (e) {
      Log.warning('Update prescription failed: id=$id ${_errorText(e)}');
      throw MessagedException(error: _errorText(e));
    }
  }

  /// Получить список лекарств.
  Future<List<Drug>> fetchDrugList({String? searchRequest, int limit = 25, int offset = 0}) async {
    Log.debug('Fetch drug list: search=$searchRequest limit=$limit offset=$offset');
    try {
      final dtos = await _port.listDrugs(
        search: searchRequest,
        limit: limit,
        offset: offset,
        shelterId: _authService.currentShelterId,
      );
      Log.info('Drug list loaded: count=${dtos.length}');
      return dtos.map(_mapDrug).toList(growable: false);
    } on DioException catch (e) {
      Log.warning('Fetch drug list failed: ${_errorText(e)}');
      throw MessagedException(error: _errorText(e));
    }
  }

  /// Человекочитаемое имя типа назначения (из серверного конфига).
  String? getTypeName(PrescriptionType? type) => _configService.getMyTypeName(type?.wire);

  /// Текущий приют (для скоупинга связанных запросов, напр. животного в форме).
  int? get currentShelterId => _authService.currentShelterId;

  // ── DTO → сущность ─────────────────────────────────────────────────────────

  Prescription _mapPrescription(PrescriptionDto d) => Prescription(
    id: d.id,
    url: d.url,
    animal: d.animal,
    type: PrescriptionType.fromWire(d.myType),
    duration: d.duration == null ? null : PrescriptionDuration.fromWire(d.duration),
    description: d.description,
    createdBy: d.createdBy,
    updatedBy: d.updatedBy,
    drugs: d.drugs.map(_mapDrugLine).toList(growable: false),
    executions: d.executions.map(_mapExecution).toList(growable: false),
    files: d.files?.map(_mapFile).toList(growable: false),
    extraTypeAttributes: d.extraTypeAttributes,
  );

  PrescriptionDrug _mapDrugLine(PrescriptionDrugDto d) => PrescriptionDrug(
    drugId: d.drugId,
    drugName: d.drugName,
    drugDosage: d.drugDosage,
    usageInstruction: d.usageInstruction,
    formOfDrug: d.formOfDrug,
  );

  PrescriptionExecution _mapExecution(PrescriptionExecutionDto e) =>
      PrescriptionExecution(id: e.id, executeAt: e.executeAt, status: e.status);

  PrescriptionFile _mapFile(PrescriptionFileDto f) =>
      PrescriptionFile(id: f.id, file: f.file, name: f.name, filename: f.filename, createdAt: f.createdAt);

  Drug _mapDrug(DrugDto d) => Drug(
    id: d.id,
    name: d.name,
    usageInstruction: d.usageInstruction,
    formOfDrug: d.formOfDrug,
    formOfDrugName: d.formOfDrugName,
    drugResiduesCount: d.drugResiduesCount,
  );

  PrescriptionExecutionToday _mapExecutionToday(PrescriptionExecutionTodayDto d) => PrescriptionExecutionToday(
    id: d.id,
    executeAt: d.executeAt.toLocal(),
    prescription: PrescriptionShortEntity(
      id: d.prescription.id,
      type: PrescriptionType.fromWire(d.prescription.myType),
      description: d.prescription.description,
      animal: _mapAnimalShort(d.prescription.animal),
      drugs: d.prescription.drugs.map(_mapDrugLine).toList(growable: false),
      createdBy: d.prescription.createdBy,
      updatedBy: d.prescription.updatedBy,
      extraTypeAttributes: d.prescription.extraTypeAttributes,
    ),
  );

  AnimalShort _mapAnimalShort(AnimalShortDto a) => AnimalShort(
    id: a.id,
    uuid: a.uuid,
    name: a.name,
    specName: a.specName,
    specParentName: a.specParentName,
    avatar: a.avatar,
    defaultImageId: a.defaultImageId,
  );

  // ── сущность → write-DTO ────────────────────────────────────────────────────

  PrescriptionWriteDto _toWriteDto(Prescription p) => PrescriptionWriteDto(
    id: p.id,
    animal: p.animal,
    myType: p.type.wire ?? '',
    duration: p.duration?.wire,
    description: p.description,
    drugs: p.drugs
        .map(
          (d) => PrescriptionDrugDto(
            drugId: d.drugId,
            drugName: d.drugName,
            drugDosage: d.drugDosage,
            usageInstruction: d.usageInstruction,
            formOfDrug: d.formOfDrug,
          ),
        )
        .toList(growable: false),
    // executeAt шлём в UTC (сервер ждёт UTC), как и прежний chopper-код.
    executions: p.executions
        .map((e) => PrescriptionExecutionDto(id: e.id, executeAt: e.executeAt.toUtc(), status: e.status))
        .toList(growable: false),
    files: (p.files ?? const <PrescriptionFile>[])
        .map(
          (f) =>
              PrescriptionFileDto(id: f.id, file: f.file, name: f.name, filename: f.filename, createdAt: f.createdAt),
        )
        .toList(growable: false),
    extraTypeAttributes: p.extraTypeAttributes,
  );

  // ── UTC → локальное время исполнений ────────────────────────────────────────

  Prescription _toLocal(Prescription p) => p.copyWith(
    executions: p.executions.map((e) => e.copyWith(executeAt: e.executeAt.toLocal())).toList(growable: false),
  );

  String _errorText(DioException e) => e.response?.data?.toString() ?? e.message ?? e.toString();
}
