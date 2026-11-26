import 'dto/animal_note_dto.dart';
import 'dto/animal_note_write_dto.dart';

/// Stable port for animal notes / comments — expressed in OUR DTOs.
///
/// Never mentions the generated swagger_parser types; swapping the generator
/// means writing a new adapter that implements this interface.
abstract interface class AnimalNotesApiPort {
  /// Lists notes for an animal (newest first), with [limit]/[offset] paging.
  /// Returns the unwrapped `results` list.
  Future<List<AnimalNoteDto>> listByAnimal(int animalId, {int? limit, int? offset, int? shelterId});

  /// Creates a note from [body]; returns the created note.
  Future<AnimalNoteDto> create(AnimalNoteWriteDto body, {int? shelterId});

  /// Partially updates the note [id] with [body]; returns the updated note.
  Future<AnimalNoteDto> patch(int id, AnimalNoteWriteDto body, {int? shelterId});

  /// Deletes the note [id].
  Future<void> delete(int id, {int? shelterId});
}
