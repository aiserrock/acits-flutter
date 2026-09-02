import 'package:dio/dio.dart';

import '../../ports/dto/animal_short_dto.dart';
import '../../ports/dto/drug_dto.dart';
import '../../ports/dto/prescription_dto.dart';
import '../../ports/dto/prescription_drug_dto.dart';
import '../../ports/dto/prescription_execution_today_dto.dart';
import '../../ports/dto/prescription_short_dto.dart';
import '../../ports/dto/prescription_write_dto.dart';
import '../../ports/prescription_api_port.dart';
import 'generated/clients/prescriptions_client.dart';
import 'generated/clients/shelters_client.dart';
import 'generated/models/animal_short.dart';
import 'generated/models/drug.dart';
import 'generated/models/prescription_drug.dart';
import 'generated/models/prescription_execution_today.dart';
import 'generated/models/prescription_short.dart';
import 'generated/models/shelter_drug.dart';

/// The ONLY place generated swagger_parser code is touched for prescriptions.
///
/// The `Prescription` resource is a polymorphic `oneOf` the generated sealed
/// type deserializes by throwing on unknown/absent `my_type` and demanding
/// server-only fields (`id`/`url`/`created_by`). The app has always tolerated
/// those, so list/get/create/update go through the raw [Dio] and parse the
/// body into the flat [PrescriptionDto] by hand — preserving the previous
/// chopper behavior exactly. Drugs and today-executions map cleanly, so they
/// use the typed clients.
class PrescriptionApiAdapter implements PrescriptionApiPort {
  const PrescriptionApiAdapter(this._dio, this._prescriptions, this._shelters);

  final Dio _dio;
  final PrescriptionsClient _prescriptions;
  final SheltersClient _shelters;

  Options _shelterHeader(int? shelterId) =>
      Options(headers: shelterId == null ? null : {'x-current-shelter': shelterId});

  @override
  Future<List<PrescriptionDto>> listByAnimal(
    int animalId, {
    bool? isActual,
    bool? isOld,
    int? limit,
    int? offset,
    int? shelterId,
  }) async {
    final now = DateTime.now();
    final query = <String, dynamic>{'animal': animalId};
    if (limit != null) query['limit'] = limit;
    if (offset != null) query['offset'] = offset;
    // Дата-фильтр «актуальных» — по локальному дню пользователя; «прошлых» —
    // до текущего момента (UTC). Совпадает с прежним chopper-поведением.
    final actualFrom = DateTime(now.year, now.month, now.day).toIso8601String();
    if (isActual ?? false) query['execute_at__gte'] = actualFrom;
    if (isOld ?? false) query['execute_at__lt'] = now.toUtc().toIso8601String();
    final response = await _dio.get<Map<String, dynamic>>(
      '/api/v1/prescriptions/',
      queryParameters: query,
      options: _shelterHeader(shelterId),
    );
    final results = (response.data?['results'] as List<dynamic>? ?? const [])
        .whereType<Map<String, dynamic>>()
        .map(PrescriptionDto.fromJson)
        .toList(growable: false);
    return results;
  }

  @override
  Future<List<PrescriptionExecutionTodayDto>> todayExecutions({
    String? search,
    String? ordering,
    int? limit,
    int? offset,
    int? shelterId,
  }) async {
    final now = DateTime.now();
    final from = DateTime(now.year, now.month, now.day);
    final page = await _prescriptions.v1PrescriptionsExecutionsList(
      // from/to повторяют прежнюю сигнатуру; на этом эндпоинте генератор их
      // отбрасывает (как и chopper) — поведение идентично.
      from: from,
      to: from.add(const Duration(days: 1)),
      xCurrentShelter: shelterId,
      search: search,
      ordering: ordering,
      limit: limit,
      offset: offset,
    );
    final results = page.results ?? const <PrescriptionExecutionToday>[];
    return results.map(_mapExecutionToday).toList(growable: false);
  }

  @override
  Future<PrescriptionDto> getById(int id, {int? shelterId}) async {
    final response = await _dio.get<Map<String, dynamic>>(
      '/api/v1/prescriptions/$id/',
      options: _shelterHeader(shelterId),
    );
    return PrescriptionDto.fromJson(response.data ?? const <String, dynamic>{});
  }

  @override
  Future<PrescriptionDto> create(PrescriptionWriteDto body, {int? shelterId}) async {
    final response = await _dio.post<Map<String, dynamic>>(
      '/api/v1/prescriptions/',
      data: body.toJson(),
      options: _shelterHeader(shelterId),
    );
    return PrescriptionDto.fromJson(response.data ?? const <String, dynamic>{});
  }

  @override
  Future<PrescriptionDto> update(int id, PrescriptionWriteDto body, {int? shelterId}) async {
    final response = await _dio.put<Map<String, dynamic>>(
      '/api/v1/prescriptions/$id/',
      data: body.toJson(),
      options: _shelterHeader(shelterId),
    );
    return PrescriptionDto.fromJson(response.data ?? const <String, dynamic>{});
  }

  @override
  Future<List<DrugDto>> listDrugs({String? search, int? limit, int? offset, int? shelterId}) async {
    final page = await _shelters.v1ShelterDrugsList(
      xCurrentShelter: shelterId,
      search: search,
      limit: limit,
      offset: offset,
    );
    final results = page.results ?? const <ShelterDrug>[];
    return results.map(_mapDrug).toList(growable: false);
  }

  // ── generated → OUR DTO mapping ────────────────────────────────────────────

  /// Placeholder for the wire-required non-null `execute_at` that the relaxed
  /// generated model now types nullable. Real executions always carry it.
  static final _epoch = DateTime.fromMillisecondsSinceEpoch(0, isUtc: true);

  PrescriptionExecutionTodayDto _mapExecutionToday(PrescriptionExecutionToday e) => PrescriptionExecutionTodayDto(
    id: e.id,
    prescription: _mapShort(e.prescription!),
    executeAt: e.executeAt ?? _epoch,
  );

  PrescriptionShortDto _mapShort(PrescriptionShort s) => PrescriptionShortDto(
    id: s.id,
    myType: s.myType?.json,
    extraTypeAttributes: s.extraTypeAttributes is Map<String, dynamic>
        ? s.extraTypeAttributes as Map<String, dynamic>
        : null,
    description: s.description,
    animal: _mapAnimalShort(s.animal!),
    drugs: (s.drugs ?? const []).map(_mapDrugLine).toList(growable: false),
    createdBy: s.createdBy,
    updatedBy: s.updatedBy,
  );

  AnimalShortDto _mapAnimalShort(AnimalShort a) => AnimalShortDto(
    id: a.id ?? 0,
    uuid: a.uuid ?? '',
    name: a.name,
    specName: a.specName ?? '',
    specParentName: a.specParentName,
    avatar: a.avatar,
    defaultImageId: a.defaultImageId,
  );

  PrescriptionDrugDto _mapDrugLine(PrescriptionDrug d) => PrescriptionDrugDto(
    drugId: d.drugId ?? 0,
    drugName: d.drugName ?? '',
    drugDosage: d.drugDosage ?? 0,
    usageInstruction: d.usageInstruction,
    formOfDrug: d.formOfDrug,
  );

  DrugDto _mapDrug(ShelterDrug s) {
    final Drug? drug = s.drug;
    return DrugDto(
      id: drug?.id ?? 0,
      name: drug?.name ?? '',
      usageInstruction: drug?.usageInstruction,
      formOfDrug: drug?.formOfDrug ?? 0,
      formOfDrugName: drug?.formOfDrugName ?? '',
      drugResiduesCount: s.drugResiduesCount,
    );
  }
}
