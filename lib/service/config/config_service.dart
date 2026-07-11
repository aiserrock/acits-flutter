import 'dart:convert';

import 'package:acits_flutter/service/shared_pref/preference_storage.dart';
import 'package:injectable/injectable.dart';

import 'package:acits_flutter/domain/exception.dart';
import 'package:acits_flutter/service/auth/auth_service.dart';
import 'package:acits_flutter/export.dart';
import 'package:acits_flutter/util/logger/log.dart';

/// Сервис конфигурации
@singleton
class ConfigService {
  ConfigService(this._acitsClient, this._authService, this._preferenceStorage);

  final Openapi _acitsClient;
  final AuthService _authService;
  final PreferenceStorage _preferenceStorage;

  Map<String, dynamic>? _typeValues;

  final _prescriptionTypeNames = <PrescriptionShortMyTypeEnum, String?>{};
  final _animalStatusNames = <Status69fEnum, String?>{};
  List<AnimalAttribute>? _animalAttributes;
  int? _animalAttributesShelterId;

  Map<String, dynamic>? get typeValues =>
      _typeValues != null ? Map<String, dynamic>.from(_typeValues!) : null;

  List<AnimalAttribute>? get animalAttributes => _animalAttributes;

  Future<void> initConfig({int? currentShelterId}) async {
    await Future.wait([
      getTypeValues(currentShelterId: currentShelterId),
      getAnimalAttr(currentShelterId: currentShelterId),
    ]);
  }

  Future<ValuesForSelection?> getTypeValues({int? currentShelterId}) async {
    Log.debug('Get type values: shelterId=${currentShelterId ?? _authService.currentShelterId}');
    final result = await _acitsClient.apiV1ValuesForSelectionGet(
      xCurrentShelter: currentShelterId ?? _authService.currentShelterId,
    );
    if (result.body != null) {
      _typeValues = json.decode(utf8.decode(result.bodyBytes));
      Log.info('Type values loaded: keys=${_typeValues?.length ?? 0}');
      return result.body;
    } else {
      Log.warning('Get type values failed: ${result.error}');
      throw MessagedException(error: result.error);
    }
  }

  Future<List<AnimalAttribute>> getAnimalAttr({int? currentShelterId}) async {
    final shelterId = currentShelterId ?? _authService.currentShelterId;
    Log.debug('Get animal attributes: shelterId=$shelterId');
    if (_animalAttributes != null && _animalAttributesShelterId == shelterId) {
      Log.debug('Animal attributes returned from cache: count=${_animalAttributes!.length}');
      return _animalAttributes!;
    }
    final result = await _acitsClient.apiV1AnimalsAttributesGet(xCurrentShelter: shelterId);
    if (result.body != null) {
      _animalAttributes = result.body!;
      _animalAttributesShelterId = shelterId;
      Log.info('Animal attributes loaded: count=${_animalAttributes!.length}');
      return _animalAttributes!;
    } else {
      Log.warning('Get animal attributes failed: ${result.error}');
      throw MessagedException(error: result.error);
    }
  }

  /// После изменений в схеме API тип приходит как в виде MyTypeEnum, так и строки. Сделал
  /// обобщение и резолвинг типа внутри метода.
  String? getMyTypeName(Object? type) {
    if (type == null) return null;
    if (!(type is String || type is PrescriptionShortMyTypeEnum)) return null;
    if (_prescriptionTypeNames.isEmpty) _parsePrescriptionTypes();
    final resolvedType = (type is PrescriptionShortMyTypeEnum)
        ? type
        : prescriptionShortMyTypeEnumFromJson(type as String);
    return _prescriptionTypeNames[resolvedType];
  }

  String? getStatus131Name(Status69fEnum? type) {
    if (type == null) return null;
    if (_animalStatusNames.isEmpty) _parseAnimalStatusTypes();
    return _animalStatusNames[type];
  }

  void _parseAnimalStatusTypes() {
    final raw = typeValues?['animal_status'];
    if (raw is List<dynamic>) {
      for (final item in raw) {
        if (item is Map) {
          final key = item['value'];
          final type = Status69fEnum.values.firstWhereOrNull((element) => element.value == key);
          if (type != null) _animalStatusNames[type] = item['display_name'];
        }
      }
    }
  }

  void _parsePrescriptionTypes() {
    final raw = typeValues?['prescription_types'];
    if (raw is List<dynamic>) {
      for (final item in raw) {
        if (item is Map) {
          final key = item['value'];
          final type = PrescriptionShortMyTypeEnum.values.firstWhereOrNull(
            (element) => element.value == key,
          );
          if (type != null) _prescriptionTypeNames[type] = item['display_name'];
        }
      }
    }
  }

  /// Первый ли запуск приложения
  bool get isFirstLaunch => _preferenceStorage.isFirstLaunch ?? true;

  /// Первый ли запуск приложения
  void setFirstLaunch({bool value = false}) => _preferenceStorage.isFirstLaunch = value;

  /// Текущая локаль приложения в формате ru-RU
  String get local => Intl.getCurrentLocale().replaceAll('_', '-');
}
