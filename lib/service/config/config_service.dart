import 'package:acits_api/acits_api.dart';
import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:injectable/injectable.dart';

import 'package:acits_flutter/domain/exception.dart';
import 'package:acits_flutter/service/auth/auth_service.dart';
import 'package:acits_flutter/service/shared_pref/preference_storage.dart';
import 'package:acits_flutter/util/logger/log.dart';

/// Сервис конфигурации.
///
/// Инфраструктурный сервис поверх стабильного [SelectionApiPort]: тянет
/// selection-значения (имена статусов/типов) и каталог атрибутов животного,
/// кеширует их и отдаёт остальному приложению через lookup-методы. Внешний
/// контракт (`getStatus131Name`/`getMyTypeName`/`animalAttributes`/…) сохранён;
/// имена статусов/типов резолвятся по wire-строке, без gen/api.
@singleton
class ConfigService {
  ConfigService(this._port, this._authService, this._preferenceStorage);

  final SelectionApiPort _port;
  final AuthService _authService;
  final PreferenceStorage _preferenceStorage;

  Map<String, dynamic>? _typeValues;

  final _prescriptionTypeNames = <String, String?>{};
  final _animalStatusNames = <String, String?>{};
  List<AttributeDto>? _animalAttributes;
  int? _animalAttributesShelterId;

  Map<String, dynamic>? get typeValues => _typeValues != null ? Map<String, dynamic>.from(_typeValues!) : null;

  List<AttributeDto>? get animalAttributes => _animalAttributes;

  Future<void> initConfig({int? currentShelterId}) async {
    await Future.wait([
      getTypeValues(currentShelterId: currentShelterId),
      getAnimalAttr(currentShelterId: currentShelterId),
    ]);
  }

  Future<Map<String, dynamic>?> getTypeValues({int? currentShelterId}) async {
    final shelterId = currentShelterId ?? _authService.currentShelterId;
    Log.debug('Get type values: shelterId=$shelterId');
    try {
      final result = await _port.valuesForSelection(shelterId: shelterId);
      _typeValues = Map<String, dynamic>.from(result.values);
      // Инвалидируем кеши имён — они лениво перечитают новые значения.
      _prescriptionTypeNames.clear();
      _animalStatusNames.clear();
      Log.info('Type values loaded: keys=${_typeValues?.length ?? 0}');
      return _typeValues;
    } on DioException catch (e) {
      Log.warning('Get type values failed: ${_errorText(e)}');
      throw MessagedException(error: _errorText(e));
    }
  }

  Future<List<AttributeDto>> getAnimalAttr({int? currentShelterId}) async {
    final shelterId = currentShelterId ?? _authService.currentShelterId;
    Log.debug('Get animal attributes: shelterId=$shelterId');
    if (_animalAttributes != null && _animalAttributesShelterId == shelterId) {
      Log.debug('Animal attributes returned from cache: count=${_animalAttributes!.length}');
      return _animalAttributes!;
    }
    try {
      final result = await _port.animalAttributes(shelterId: shelterId);
      _animalAttributes = result;
      _animalAttributesShelterId = shelterId;
      Log.info('Animal attributes loaded: count=${_animalAttributes!.length}');
      return _animalAttributes!;
    } on DioException catch (e) {
      Log.warning('Get animal attributes failed: ${_errorText(e)}');
      throw MessagedException(error: _errorText(e));
    }
  }

  /// Человекочитаемое имя типа назначения по его wire-значению (из серверного
  /// конфига). Принимает wire-строку — enum'ы генератора здесь больше не нужны.
  String? getMyTypeName(String? wire) {
    if (wire == null) return null;
    if (_prescriptionTypeNames.isEmpty) _parsePrescriptionTypes();
    return _prescriptionTypeNames[wire];
  }

  /// Человекочитаемое имя статуса животного по его wire-значению.
  String? getStatus131Name(String? wire) {
    if (wire == null) return null;
    if (_animalStatusNames.isEmpty) _parseAnimalStatusTypes();
    return _animalStatusNames[wire];
  }

  void _parseAnimalStatusTypes() {
    final raw = typeValues?['animal_status'];
    if (raw is List<dynamic>) {
      for (final item in raw) {
        if (item is Map) {
          final key = item['value'];
          if (key is String) _animalStatusNames[key] = item['display_name'] as String?;
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
          if (key is String) _prescriptionTypeNames[key] = item['display_name'] as String?;
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

  String _errorText(DioException e) => e.response?.data?.toString() ?? e.message ?? e.toString();
}
