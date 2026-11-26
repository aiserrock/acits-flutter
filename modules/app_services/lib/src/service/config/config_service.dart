import 'package:core/api.dart';
import 'package:auth/auth.dart' show AuthConfigInitializer;
import 'package:core/data.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:injectable/injectable.dart';

import 'package:core/domain.dart';
import 'package:app_services/src/service/auth/auth_service.dart';
import 'package:app_services/src/service/shared_pref/preference_storage.dart';
import 'package:app_services/src/log.dart';

/// Сервис конфигурации.
///
/// Инфраструктурный сервис поверх стабильного [SelectionApiPort]: тянет
/// selection-значения (имена статусов/типов) и каталог атрибутов животного,
/// кеширует их и отдаёт остальному приложению через lookup-методы. Внешний
/// контракт (`getStatus131Name`/`getMyTypeName`/`animalAttributes`/…) сохранён;
/// имена статусов/типов резолвятся по wire-строке, без gen/api.
@singleton
class ConfigService implements AuthConfigInitializer {
  ConfigService(this._port, this._authService, this._preferenceStorage);

  final SelectionApiPort _port;
  final AuthService _authService;
  final PreferenceStorage _preferenceStorage;

  Map<String, dynamic>? _typeValues;

  final _prescriptionTypeNames = <String, String?>{};
  final _animalStatusNames = <String, String?>{};
  List<AnimalAttributeDefinition>? _animalAttributes;
  int? _animalAttributesShelterId;

  Map<String, dynamic>? get typeValues => _typeValues != null ? Map<String, dynamic>.from(_typeValues!) : null;

  List<AnimalAttributeDefinition>? get animalAttributes => _animalAttributes;

  @override
  Future<Result<Failure, void>> initConfig({int? currentShelterId}) async {
    final results = await Future.wait<Result<Failure, Object?>>([
      getTypeValues(currentShelterId: currentShelterId),
      getAnimalAttr(currentShelterId: currentShelterId),
    ]);
    final failure = results.map((r) => r.failureOrNull).nonNulls.firstOrNull;
    return failure == null ? const Ok(null) : Err(failure);
  }

  Future<Result<Failure, Map<String, dynamic>?>> getTypeValues({int? currentShelterId}) {
    final shelterId = currentShelterId ?? _authService.currentShelterId;
    Log.debug('Get type values: shelterId=$shelterId');
    return _guard('Get type values', () async {
      final result = await _port.valuesForSelection(shelterId: shelterId);
      _typeValues = Map<String, dynamic>.from(result.values);
      // Инвалидируем кеши имён — они лениво перечитают новые значения.
      _prescriptionTypeNames.clear();
      _animalStatusNames.clear();
      Log.info('Type values loaded: keys=${_typeValues?.length ?? 0}');
      return _typeValues;
    });
  }

  Future<Result<Failure, List<AnimalAttributeDefinition>>> getAnimalAttr({int? currentShelterId}) async {
    final shelterId = currentShelterId ?? _authService.currentShelterId;
    Log.debug('Get animal attributes: shelterId=$shelterId');
    final cached = _animalAttributes;
    if (cached != null && _animalAttributesShelterId == shelterId) {
      Log.debug('Animal attributes returned from cache: count=${cached.length}');
      return Ok(cached);
    }
    return _guard('Get animal attributes', () async {
      final result = await _port.animalAttributes(shelterId: shelterId);
      final attributes = result.map(_toDefinition).toList(growable: false);
      _animalAttributes = attributes;
      _animalAttributesShelterId = shelterId;
      Log.info('Animal attributes loaded: count=${attributes.length}');
      return attributes;
    });
  }

  static AnimalAttributeDefinition _toDefinition(AttributeDto d) =>
      AnimalAttributeDefinition(id: d.id, name: d.name, isRequired: d.isRequired ?? false);

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
  @override
  bool get isFirstLaunch => _preferenceStorage.isFirstLaunch ?? true;

  /// Первый ли запуск приложения
  @override
  void setFirstLaunch({bool value = false}) => _preferenceStorage.isFirstLaunch = value;

  /// Текущая локаль приложения в формате ru-RU
  String get local => Intl.getCurrentLocale().replaceAll('_', '-');

  /// Транспортные исключения заканчиваются здесь: наружу уходит [Failure].
  Future<Result<Failure, T>> _guard<T>(String action, Future<T> Function() body) =>
      guard(body, onError: (e, s) => Log.warning('$action failed', e, s));
}
