import 'dart:convert';

import 'package:acits_flutter/domain/exception.dart';
import 'package:injectable/injectable.dart';

import 'package:acits_flutter/api/openapi.swagger.dart';

import 'package:acits_flutter/service/auth/auth_service.dart';

@singleton
class PrescriptionService {
  PrescriptionService(
    this._acitsClient,
    this._authService,
  );

  final Openapi _acitsClient;
  final AuthService _authService;

  Map<String, dynamic>? _typeValues;
  final _prescriptionTypeNames = <MyTypeEnum, String?>{};

  Future<PaginatedPrescriptionExecutionTodayList?> getTodayPrescriptionList() async {
    if (_typeValues == null) {
      await getTypeValues();
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

  Future<ValuesForSelection?> getTypeValues() async {
    final result = await _acitsClient.apiV1ValuesForSelectionGet(
      xCurrentShelter: _authService.currentShelterId,
    );
    if (result.body != null) {
      _typeValues = jsonDecode(result.bodyString);
      return result.body;
    } else {
      throw MesssagedException(error: result.error);
    }
  }

  String? getTypeName(MyTypeEnum? type) {
    if (type == null) return null;
    if (_prescriptionTypeNames.isEmpty) _parsePrescriptionTypes();
    return _prescriptionTypeNames[type];
  }

  void _parsePrescriptionTypes() {
    final raw = _typeValues?['prescription_types'];
    if (raw is List<dynamic>) {
      for (final item in raw) {
        if (item is Map) {
          final key = item['value'];
          final type =
              $MyTypeEnumMap.entries.firstWhereOrNull((element) => element.value == key)?.key;
          if (type != null) _prescriptionTypeNames[type] = item['display_name'];
        }
      }
    }
  }
}

extension FirstWhereOrNullExtension<E> on Iterable<E> {
  E? firstWhereOrNull(bool Function(E) test) {
    for (E element in this) {
      if (test(element)) return element;
    }
    return null;
  }
}
