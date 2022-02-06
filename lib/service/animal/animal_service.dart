import 'package:injectable/injectable.dart';

import 'package:acits_flutter/domain/exception.dart';
import 'package:acits_flutter/service/auth/auth_service.dart';
import 'package:acits_flutter/api/openapi.swagger.dart';

@singleton
class AnimalService {
  AnimalService(
    this._authService,
    this._client,
  );

  final AuthService _authService;
  final Openapi _client;

  /// Получить список живолных в приюте
  Future<PaginatedAnimalReadList?> fetchAnimalList({
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

  /// Получить детальное представление животного по его ID
  Future<AnimalRead> fetchAnimalDetail({required int id}) async {
    final result = await _client.apiV1AnimalsIdGet(
      id: id.toString(),
      xCurrentShelter: _authService.currentShelterId,
    );

    if (result.body != null) {
      return result.body!;
    } else {
      throw MesssagedException(error: result.error);
    }
  }

  Future<List<Species>> getAnimalSpecies({
    required ApiV1AnimalsSpeciesGetLevel level,
    int limit = 25,
    int offset = 0,
    int? parentId,
    String? searchRequest,
  }) async {
    final result = await _client.apiV1AnimalsSpeciesGet(
      level: level,
      limit: limit,
      offset: offset,
      parentId: parentId,
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

  Future<AnimalRead?> createAnimal(AnimalWrite animal) async {
    animal = animal.copyWith(
      shelter: _authService.shelterRole?.currentShelter,
      placeOfRelease: animal.placeOfRelease ?? '',
      deathReason: animal.deathReason ?? '',
    );
    final result = await _client.apiV1AnimalsPost(
      xCurrentShelter: _authService.currentShelterId,
      body: animal,
    );

    final data = result.body;

    if (data != null) {
      return data;
    } else {
      throw MesssagedException(error: result.error);
    }
  }

  Future<AnimalRead?> updateAnimal(
    int id,
    AnimalWrite animal,
  ) async {
    animal = animal.copyWith(
      shelter: _authService.shelterRole?.currentShelter,
      placeOfRelease: animal.placeOfRelease ?? '',
      deathReason: animal.deathReason ?? '',
    );
    final result = await _client.apiV1AnimalsIdPut(
      id: id.toString(),
      xCurrentShelter: _authService.currentShelterId,
      body: animal,
    );

    final data = result.body;

    if (data != null) {
      return data;
    } else {
      throw MesssagedException(error: result.error);
    }
  }

  ApiV1AnimalsSpeciesGetLevel getLevel(int value) {
    assert(value >= 0);
    assert(value < ApiV1AnimalsSpeciesGetLevel.values.length - 1);
    return ApiV1AnimalsSpeciesGetLevel.values[value + 1];
  }
}
