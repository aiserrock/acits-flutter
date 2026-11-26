import 'package:dio/dio.dart';

import '../../ports/animal_notes_api_port.dart';
import '../../ports/dto/animal_note_dto.dart';
import '../../ports/dto/animal_note_file_dto.dart';
import '../../ports/dto/animal_note_write_dto.dart';
import 'generated/clients/animals_client.dart';
import 'generated/models/animal_note.dart';
import 'generated/models/animal_note_file.dart';

/// The ONLY place generated swagger_parser code is touched for animal notes.
///
/// List/delete use the typed [AnimalsClient]. Create/patch go through the raw
/// [Dio]: the generated write types (`AnimalNote`/`PatchedAnimalNote`) demand
/// server-computed fields (`id`/`url`/`created_at`/…) the app cannot supply on
/// create, so we post the minimal payload by hand — matching the previous
/// chopper behavior.
class AnimalNotesApiAdapter implements AnimalNotesApiPort {
  const AnimalNotesApiAdapter(this._dio, this._client);

  final Dio _dio;
  final AnimalsClient _client;

  Options _shelterHeader(int? shelterId) =>
      Options(headers: shelterId == null ? null : {'x-current-shelter': shelterId});

  @override
  Future<List<AnimalNoteDto>> listByAnimal(int animalId, {int? limit, int? offset, int? shelterId}) async {
    final page = await _client.v1AnimalsNotesList(
      animal: animalId,
      limit: limit,
      offset: offset,
      ordering: '-created_at',
      xCurrentShelter: shelterId,
    );
    final results = page.results ?? const <AnimalNote>[];
    return results.map(_mapNote).toList(growable: false);
  }

  @override
  Future<AnimalNoteDto> create(AnimalNoteWriteDto body, {int? shelterId}) async {
    final response = await _dio.post<Map<String, dynamic>>(
      '/api/v1/animals/notes/',
      data: body.toJson(),
      options: _shelterHeader(shelterId),
    );
    return AnimalNoteDto.fromJson(response.data ?? const <String, dynamic>{});
  }

  @override
  Future<AnimalNoteDto> patch(int id, AnimalNoteWriteDto body, {int? shelterId}) async {
    final response = await _dio.patch<Map<String, dynamic>>(
      '/api/v1/animals/notes/$id/',
      data: body.toJson(),
      options: _shelterHeader(shelterId),
    );
    return AnimalNoteDto.fromJson(response.data ?? const <String, dynamic>{});
  }

  @override
  Future<void> delete(int id, {int? shelterId}) => _client.v1AnimalsNotesDestroy(id: id, xCurrentShelter: shelterId);

  // ── generated → OUR DTO mapping ────────────────────────────────────────────

  AnimalNoteDto _mapNote(AnimalNote n) => AnimalNoteDto(
    id: n.id ?? 0,
    url: n.url,
    animal: n.animal ?? 0,
    content: n.content ?? '',
    files: n.files?.map(_mapFile).toList(growable: false),
    createdAt: n.createdAt,
    updatedAt: n.updatedAt,
    createdBy: n.createdBy,
    updatedBy: n.updatedBy,
    isUserCanEditOrDelete: n.isUserCanEditOrDelete,
  );

  /// Placeholder for the wire-required non-null `created_at` that the relaxed
  /// generated model now types nullable. Real payloads always carry it.
  static final _epoch = DateTime.fromMillisecondsSinceEpoch(0, isUtc: true);

  AnimalNoteFileDto _mapFile(AnimalNoteFile f) => AnimalNoteFileDto(
    id: f.id ?? 0,
    file: f.file ?? '',
    name: f.name ?? '',
    filename: f.filename ?? '',
    createdAt: f.createdAt ?? _epoch,
  );
}
