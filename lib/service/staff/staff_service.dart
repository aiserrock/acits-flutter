import 'package:acits_flutter/domain/exception.dart';
import 'package:acits_flutter/service/auth/auth_service.dart';
import 'package:injectable/injectable.dart';

import 'package:acits_flutter/api/openapi.swagger.dart';

/// Сервис сотрудников (заявителей и пр.)
@singleton
class StaffService {
  StaffService(
    this._authService,
    this._client,
  );

  final AuthService _authService;
  final Openapi _client;

  /// Список кураторов
  Future<List<Curator>> getCurators({
    int limit = 25,
    int offset = 0,
    String? searchRequest,
  }) async {
    final result = await _client.apiV1CuratorsGet(
      limit: limit,
      offset: offset,
      search: searchRequest,
      xCurrentShelter: _authService.currentShelterId,
    );

    final data = result.body?.results;

    if (data != null) {
      return data;
    } else {
      throw MesssagedException(error: result.error);
    }
  }
}
