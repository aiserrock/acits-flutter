import 'package:acits_core/acits_core.dart';

import 'animal.dart';
import 'animal_edit_input.dart';
import 'animal_list_item.dart';
import 'animal_species.dart';

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
}
