import 'package:core/api.dart';
import 'package:core/data.dart';
import 'package:util/util.dart';

import 'package:prescriptions/domain/domain.dart';
import 'package:prescriptions/util/util.dart';

/// Реализация [PrescriptionRepository]. Здесь DTO заканчиваются: вызываем
/// [PrescriptionApiPort], разворачиваем DTO → сущности, ловим исключения →
/// типизированный [Failure]. Наружу (в домен/UI) уходят только сущности в
/// [Result].
///
/// Порт скрывает полиморфизм назначения (`oneOf` по `my_type`) и генератор
/// клиента. Скоуп по приюту берётся из [PrescriptionsShelterProvider], имена
/// типов прогреваются через [PrescriptionTypeLabels] (оба мостятся в приложении
/// к AuthService/ConfigService).
class PrescriptionRepositoryImpl implements PrescriptionRepository {
  const PrescriptionRepositoryImpl(this._port, this._shelterProvider, this._typeLabels);

  final PrescriptionApiPort _port;
  final PrescriptionsShelterProvider _shelterProvider;
  final PrescriptionTypeLabels _typeLabels;

  @override
  Future<Result<Failure, List<PrescriptionExecutionToday>>> listTodayExecutions({String? search, String? ordering}) {
    Log.debug('Fetch today prescription executions: search=$search ordering=$ordering');
    return guard(() async {
      await _typeLabels.ensureLoaded();
      final dtos = await _port.todayExecutions(search: search, ordering: ordering, shelterId: _currentShelterId);
      Log.info('Today prescription executions loaded: count=${dtos.length}');
      // executeAt приходит в UTC — переводим в локальное для отображения времени.
      return dtos.map(_mapExecutionToday).toList(growable: false);
    });
  }

  @override
  Future<Result<Failure, List<Prescription>>> listByAnimal(
    int animalId, {
    int? limit,
    int offset = 0,
    bool isActual = false,
    bool isOld = false,
  }) {
    Log.debug(
      'Fetch prescriptions by animal: animalId=$animalId limit=$limit offset=$offset isActual=$isActual isOld=$isOld',
    );
    return guard(() async {
      await _typeLabels.ensureLoaded();
      final dtos = await _port.listByAnimal(
        animalId,
        isActual: isActual,
        isOld: isOld,
        limit: limit,
        offset: offset,
        shelterId: _currentShelterId,
      );
      Log.info('Prescriptions by animal loaded: animalId=$animalId count=${dtos.length}');
      return dtos.map(_mapPrescription).map(_toLocal).toList(growable: false);
    });
  }

  @override
  Future<Result<Failure, Prescription>> getById(int id) {
    Log.debug('Fetch prescription by id: id=$id');
    return guard(() async {
      final dto = await _port.getById(id, shelterId: _currentShelterId);
      Log.info('Prescription loaded: id=$id');
      return _toLocal(_mapPrescription(dto));
    });
  }

  @override
  Future<Result<Failure, Prescription>> create(Prescription prescription) {
    Log.debug('Create prescription: animalId=${prescription.animal}');
    return guard(() async {
      final dto = await _port.create(_toWriteDto(prescription), shelterId: _currentShelterId);
      final model = _mapPrescription(dto);
      Log.info('Prescription created: id=${model.id}');
      return model;
    });
  }

  @override
  Future<Result<Failure, Prescription>> update(Prescription prescription) {
    final id = prescription.id;
    Log.debug('Update prescription: id=$id');
    return guard(() async {
      // Без id обновлять нечего — guard превратит это в UnknownFailure, экран
      // покажет ошибку (раньше был MessagedException).
      if (id == null) throw StateError('Prescription id is required for update');
      final dto = await _port.update(id, _toWriteDto(prescription), shelterId: _currentShelterId);
      final model = _mapPrescription(dto);
      Log.info('Prescription updated: id=${model.id}');
      return model;
    });
  }

  @override
  Future<Result<Failure, List<Drug>>> listDrugs({String? searchRequest, int limit = 25, int offset = 0}) {
    Log.debug('Fetch drug list: search=$searchRequest limit=$limit offset=$offset');
    return guard(() async {
      final dtos = await _port.listDrugs(
        search: searchRequest,
        limit: limit,
        offset: offset,
        shelterId: _currentShelterId,
      );
      Log.info('Drug list loaded: count=${dtos.length}');
      return dtos.map(_mapDrug).toList(growable: false);
    });
  }

  int? get _currentShelterId => _shelterProvider.shelterId;

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
}
