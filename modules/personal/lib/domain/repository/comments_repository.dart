import 'package:util/util.dart';

import 'package:personal/domain/domain.dart';

/// Размер страницы списка заметок по умолчанию.
const kNotesListLimit = 25;

/// Контракт репозитория заметок/комментариев животного (feature-local).
///
/// Всё в доменных типах и [Result]<[Failure], T> — DTO сюда не проникают
/// (остаются в data-слое). Скоуп по приюту репозиторий берёт из
/// [PersonalShelterProvider], поэтому вызывающему его передавать не нужно.
///
/// Значения по умолчанию объявлены здесь: вызывающий код видит репозиторий
/// через этот интерфейс, и именно отсюда подставляются дефолты.
abstract interface class CommentsRepository {
  /// Список заметок животного постранично ([limit]/[offset]).
  Future<Result<Failure, List<AnimalNote>>> listByAnimal(int animalId, {int limit = kNotesListLimit, int offset = 0});

  /// Создаёт заметку для животного [animalId] с текстом [text] и вложениями.
  Future<Result<Failure, AnimalNote>> create({
    required int animalId,
    required String text,
    List<AnimalNoteFileInput> files = const [],
  });

  /// Обновляет заметку [id] (принадлежащую [animalId]) текстом и вложениями.
  Future<Result<Failure, AnimalNote>> patch({
    required int id,
    required int animalId,
    required String text,
    List<AnimalNoteFileInput> files = const [],
  });

  /// Удаляет заметку [id].
  Future<Result<Failure, void>> delete(int id);
}
