import 'dart:typed_data';

import 'dto/animal_dto.dart';
import 'dto/animal_image_write_dto.dart';
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

  /// Replaces the photo set of animal [id] while preserving every other field.
  ///
  /// The adapter fetches the current animal, keeps all scalar/relation fields
  /// (attributes with their `attrId`, species, dates, curator/applicant, …) and
  /// re-writes with [newImages] appended and [retainImageIds] as `valid_images`.
  /// This is the photo-only write path (gallery screen) — it does not require
  /// the caller to reconstruct the whole animal.
  Future<AnimalDto> updatePhotos(
    int id, {
    required List<AnimalImageWriteDto> newImages,
    required List<int> retainImageIds,
    int? shelterId,
  });

  /// Fetches a generated PDF for animal [id] as raw bytes. [pdfType] is one of
  /// `history` / `history-editing` / `history-prescriptions`; [from]/[to] scope
  /// the report window. Returns the PDF bytes 1:1 (binary-safe — no string
  /// round-trip), so they can go straight to a renderer/share on any platform.
  Future<Uint8List> getAnimalPdf({
    required int id,
    required String pdfType,
    required DateTime from,
    required DateTime to,
    String? tz,
    int? shelterId,
  });
}
