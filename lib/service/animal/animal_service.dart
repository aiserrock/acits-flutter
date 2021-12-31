import 'package:acits_flutter/domain/exception.dart';
import 'package:acits_flutter/service/auth/auth_service.dart';
import 'package:acits_flutter/service/config/config_service.dart';
import 'package:injectable/injectable.dart';

import 'package:acits_flutter/api/openapi.swagger.dart';

@singleton
class AnimalService {
  AnimalService(
    this._authService,
    this._client,
    this._configService,
  );

  final AuthService _authService;
  final Openapi _client;
  final ConfigService _configService;

  Future<PaginatedAnimalList?> fetchAnimalList({
    required int limit,
    int offset = 0,
  }) async {
    final result = await _client.apiV1AnimalsGet(
      limit: limit,
      offset: offset,
      xCurrentShelter: _authService.currentShelterId,
    );

    if (result.body != null) {
      return result.body;
    } else {
      throw MesssagedException(error: result.error);
    }
  }
}
