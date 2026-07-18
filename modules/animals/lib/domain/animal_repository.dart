import 'dart:typed_data';

import 'package:base/base.dart';

import 'package:animals/domain/domain.dart';

/// Контракт репозитория животных (feature-local). Всё в доменных типах и
/// [Result]<[Failure], T> — DTO сюда не проникают (остаются в data-слое).
abstract interface class AnimalRepository {
  Future<Result<Failure, List<AnimalListItem>>> list({
    int? shelterId,
    String? search,
    String? ordering,
    int? limit,
    int? offset,
  });

  Future<Result<Failure, Animal>> getById(int id, {int? shelterId});

  /// Создаёт животное из [animal] (+ явные атрибуты/новые фото формы).
  Future<Result<Failure, Animal>> create(
    Animal animal, {
    required List<AnimalAttributeInput> attributes,
    List<AnimalImageInput> newImages,
    List<int> retainImageIds,
    int? shelterId,
  });

  /// Обновляет животное [id] значениями [animal] (+ атрибуты/фото формы).
  Future<Result<Failure, Animal>> update(
    int id,
    Animal animal, {
    required List<AnimalAttributeInput> attributes,
    List<AnimalImageInput> newImages,
    List<int> retainImageIds,
    int? shelterId,
  });

  Future<Result<Failure, void>> delete(int id, {int? shelterId});

  Future<Result<Failure, List<AnimalSpecies>>> listSpecies({
    required int level,
    int? parentId,
    String? search,
    int? limit,
    int? offset,
    int? shelterId,
  });

  /// Обновляет только набор фотографий животного [id], сохраняя все прочие
  /// поля. [newImages] — новые фото (base64), [retainImageIds] — id уже
  /// загруженных, которые надо сохранить.
  Future<Result<Failure, Animal>> updatePhotos(
    int id, {
    required List<AnimalImageInput> newImages,
    required List<int> retainImageIds,
    int? shelterId,
  });

  /// Возвращает сгенерированный PDF-документ животного [id] байтами.
  /// [pdfType] — `history` / `history-editing` / `history-prescriptions`;
  /// [from]/[to] задают окно отчёта.
  Future<Result<Failure, Uint8List>> getAnimalPdf({
    required int id,
    required String pdfType,
    required DateTime from,
    required DateTime to,
    String? tz,
    int? shelterId,
  });
}
