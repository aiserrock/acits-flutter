import 'dto/animal_dto.dart';
import 'dto/animal_write_dto.dart';
import 'dto/species_dto.dart';

/// Stable port for the animals slice — expressed entirely in OUR DTOs.
///
/// This is the contract the app depends on. It never mentions the generated
/// swagger_parser types; swapping the underlying generator (retrofit →
/// openapi-generator → …) means writing a new adapter that implements this
/// interface, with zero changes to ports, DTOs, repositories, or features.
abstract interface class AnimalApiPort {
  /// Lists animals, optionally scoped to a shelter and/or filtered by a free
  /// text [search], sorted by [ordering] (DRF `ordering` query, e.g.
  /// `-date_joined`), with [limit]/[offset] pagination. Returns the unwrapped
  /// `results` list (pagination envelope is handled by the adapter).
  Future<List<AnimalDto>> list({int? shelterId, String? search, String? ordering, int? limit, int? offset});

  /// Fetches a single animal by its numeric [id].
  Future<AnimalDto> getById(int id, {int? shelterId});

  /// Creates an animal from [body]; returns the created (read) animal.
  Future<AnimalDto> create(AnimalWriteDto body, {int? shelterId});

  /// Replaces the animal [id] with [body]; returns the updated (read) animal.
  Future<AnimalDto> update(int id, AnimalWriteDto body, {int? shelterId});

  /// Deletes the animal [id].
  Future<void> delete(int id, {int? shelterId});

  /// Lists species at the given taxonomy [level] (1/2/3), optionally scoped to
  /// a [parentId], filtered by [search], with [limit]/[offset] pagination.
  Future<List<SpeciesDto>> listSpecies({
    required int level,
    int? parentId,
    String? search,
    int? limit,
    int? offset,
    int? shelterId,
  });
}
