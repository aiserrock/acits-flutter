import 'dart:convert';

import 'package:chopper/chopper.dart';
import 'package:injectable/injectable.dart';

import 'package:acits_flutter/export.dart';

import 'package:acits_flutter/service/auth/auth_service.dart';
import 'package:acits_flutter/domain/exception.dart';
import 'package:acits_flutter/domain/prescription_model.dart';
import 'package:acits_flutter/service/config/config_service.dart';
import 'package:acits_flutter/util/logger/log.dart';

/// Сервис назначений
@singleton
class PrescriptionService {
  PrescriptionService(this._acitsClient, this._authService, this._configService);

  final Openapi _acitsClient;
  final AuthService _authService;
  final ConfigService _configService;

  Future<PaginatedPrescriptionExecutionTodayList?> fetchTodayPrescriptionList({
    String? search,
    String? ordering,
  }) async {
    Log.debug('Fetch today prescription executions: search=$search ordering=$ordering');
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
      search: search,
      ordering: ordering,
    );
    if (result.body != null) {
      Log.info('Today prescription executions loaded: count=${result.body?.results?.length ?? 0}');
      return _toLocalExecutionsList(result.body);
    } else {
      Log.warning('Fetch today prescription executions failed: ${result.error}');
      throw MessagedException(error: result.error ?? result.bodyString);
    }
  }

  /// получить список назначений для животного по его ID
  ///
  /// `Prescription` на бэкенде полиморфный (oneOf) и генератор клиента даёт
  /// пустой тип, поэтому парсим тело ответа вручную в [PrescriptionModel].
  Future<PrescriptionListPage?> fetchPrescriptionListByAnimal(
    int animalId, {
    int? limit,
    int offset = 0,
    bool isActual = false,
    bool isOld = false,
  }) async {
    Log.debug(
      'Fetch prescriptions by animal: animalId=$animalId limit=$limit offset=$offset '
      'isActual=$isActual isOld=$isOld',
    );
    if (_configService.typeValues == null) {
      await _configService.getTypeValues();
    }

    final result = await _acitsClient.apiV1PrescriptionsGet(
      animal: animalId,
      xCurrentShelter: _authService.currentShelterId,
      limit: limit,
      offset: offset,
      // Дата-фильтр «актуальных» — по локальному дню пользователя.
      // Параметры теперь DateTime (клиент сам сериализует). Берём начало
      // локального дня, чтобы граница не сдвигалась на соседний день вечером.
      executeAtGte: isActual ? DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day) : null,
      executeAtLt: isOld ? DateTime.now().toUtc() : null,
    );
    if (result.isSuccessful) {
      final page = PrescriptionListPage.fromJson(_decodeBody(result.bodyBytes));
      Log.info('Prescriptions by animal loaded: animalId=$animalId count=${page.results.length}');
      return _toLocalList(page);
    } else {
      Log.warning('Fetch prescriptions by animal failed: animalId=$animalId ${result.error}');
      throw MessagedException(error: result.error ?? result.bodyString);
    }
  }

  /// получить назначение для животного по ID назначения
  Future<PrescriptionModel?> fetchPrescriptionById(int id) async {
    Log.debug('Fetch prescription by id: id=$id');
    final result = await _acitsClient.apiV1PrescriptionsIdGet(id: id, xCurrentShelter: _authService.currentShelterId);

    if (result.isSuccessful) {
      final model = PrescriptionModel.fromJson(_decodeBody(result.bodyBytes));
      Log.info('Prescription loaded: id=$id');
      return model.copyWith(executions: _toLocal(model.executions));
    } else {
      Log.warning('Fetch prescription by id failed: id=$id ${result.error}');
      throw MessagedException(error: result.error ?? result.bodyString);
    }
  }

  /// Создать новое назначение
  ///
  /// Тело шлём сырым JSON: сгенерённый `Prescription` — пустой oneOf-тип,
  /// его `toJson()` теряет поля.
  Future<PrescriptionModel?> createPrescription(PrescriptionModel prescription) async {
    Log.debug('Create prescription: animalId=${prescription.animal}');
    final payload = prescription
        .copyWith(files: prescription.files ?? [], executions: _toUtc(prescription.executions))
        .toJson();
    final result = await _sendPrescriptionBody(method: 'POST', path: '/api/v1/prescriptions/', body: payload);

    if (result.isSuccessful) {
      final model = PrescriptionModel.fromJson(_decodeBody(result.bodyBytes));
      Log.info('Prescription created: id=${model.id}');
      return model;
    } else {
      Log.warning('Create prescription failed: ${result.error ?? result.bodyString}');
      throw MessagedException(error: result.error ?? result.bodyString);
    }
  }

  String? getTypeName(PrescriptionShortMyTypeEnum? type) => _configService.getMyTypeName(type);

  /// Декодирует тело ответа в Map (UTF-8 → JSON). Пустое тело → {}.
  Map<String, dynamic> _decodeBody(List<int> bytes) {
    if (bytes.isEmpty) return <String, dynamic>{};
    final decoded = json.decode(utf8.decode(bytes));
    return decoded is Map<String, dynamic> ? decoded : <String, dynamic>{};
  }

  /// Получить список лекарств
  Future<PaginatedShelterDrugList?> fetchDrugList({String? searchRequest, int limit = 25, int offset = 0}) async {
    Log.debug('Fetch drug list: search=$searchRequest limit=$limit offset=$offset');
    final result = await _acitsClient.apiV1ShelterDrugsGet(
      xCurrentShelter: _authService.currentShelterId,
      search: searchRequest,
      limit: limit,
      offset: offset,
    );
    if (result.body != null) {
      Log.info('Drug list loaded: count=${result.body?.results?.length ?? 0}');
      return result.body;
    } else {
      Log.warning('Fetch drug list failed: ${result.error ?? result.bodyString}');
      throw MessagedException(error: result.error ?? result.bodyString);
    }
  }

  /// Изменить назначение
  Future<PrescriptionModel?> updatePrescription(PrescriptionModel prescription) async {
    Log.debug('Update prescription: id=${prescription.id}');
    final payload = prescription
        .copyWith(files: prescription.files ?? [], executions: _toUtc(prescription.executions))
        .toJson();
    final result = await _sendPrescriptionBody(
      method: 'PUT',
      path: '/api/v1/prescriptions/${prescription.id}/',
      body: payload,
    );

    if (result.isSuccessful) {
      final model = PrescriptionModel.fromJson(_decodeBody(result.bodyBytes));
      Log.info('Prescription updated: id=${model.id}');
      return model;
    } else {
      Log.warning('Update prescription failed: id=${prescription.id} ${result.error ?? result.bodyString}');
      throw MessagedException(error: result.error ?? result.bodyString);
    }
  }

  /// Шлёт сырое JSON-тело назначения в обход типизированного (пустого) клиента.
  Future<Response<dynamic>> _sendPrescriptionBody({
    required String method,
    required String path,
    required Map<String, dynamic> body,
  }) {
    final shelter = _authService.currentShelterId;
    final request = Request(
      method,
      Uri.parse(path),
      _acitsClient.client.baseUrl,
      body: json.encode(body),
      headers: {'content-type': 'application/json', if (shelter != null) 'x-current-shelter': '$shelter'},
    );
    return _acitsClient.client.send<dynamic, dynamic>(request);
  }

  List<PrescriptionExecution> _toUtc(List<PrescriptionExecution> local) {
    return local.map((item) => item.copyWith(executeAt: item.executeAt.toUtc())).toList();
  }

  List<PrescriptionExecution> _toLocal(List<PrescriptionExecution> utc) {
    return utc.map((item) => item.copyWith(executeAt: item.executeAt.toLocal())).toList();
  }

  PrescriptionListPage _toLocalList(PrescriptionListPage page) {
    return page.copyWith(
      results: page.results.map((item) => item.copyWith(executions: _toLocal(item.executions))).toList(),
    );
  }

  PaginatedPrescriptionExecutionTodayList? _toLocalExecutionsList(PaginatedPrescriptionExecutionTodayList? utc) {
    if (utc == null) return null;

    return utc.copyWith(
      results: utc.results?.map((item) => item.copyWith(executeAt: item.executeAt.toLocal())).toList(),
    );
  }
}
