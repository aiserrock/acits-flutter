import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';

import 'package:acits_api/acits_api.dart'
    show AnimalNotesApiPort, AnimalNoteWriteDto, AnimalNoteFileWriteDto, AnimalNoteDto, AnimalNoteFileDto;
import 'package:dio/dio.dart';
import 'package:acits_flutter/di/di_container.dart';
import 'package:acits_flutter/domain/animal_note/animal_note.dart' as notes;
import 'package:acits_flutter/domain/animal_note/animal_note_file.dart' as notes;
import 'package:acits_flutter/service/document/document_repository.dart';
import 'package:file_picker/file_picker.dart';
import 'package:injectable/injectable.dart';

import 'package:acits_flutter/domain/exception.dart';
import 'package:acits_flutter/service/auth/auth_service.dart';
import 'package:acits_flutter/util/logger/log.dart';

const _notesListLimit = 25;

/// Сервис заметок/комментариев животного + PDF-карточка. Полностью на новом
/// стеке: заметки через [AnimalNotesApiPort], PDF — через [DocumentRepository]
/// (модульный `AnimalRepository`). Chopper здесь больше не используется.
@singleton
class AnimalService {
  AnimalService(this._authService, this._notesPort);

  final AuthService _authService;

  /// Порт заметок/комментариев.
  final AnimalNotesApiPort _notesPort;

  /// Список заметок животного (новые сверху). Возвращает доменные сущности —
  /// маппинг DTO→сущность локальный (порт отдаёт DTO).
  Future<List<notes.AnimalNote>> fetchAnimalNotes(int animalId, {int limit = _notesListLimit, int? offset = 0}) async {
    Log.debug('Fetch animal notes: animalId=$animalId limit=$limit offset=$offset');
    try {
      final dtos = await _notesPort.listByAnimal(
        animalId,
        limit: limit,
        offset: offset,
        shelterId: _authService.currentShelterId,
      );
      Log.info('Animal notes: ${dtos.length} items');
      return dtos.map(_mapNote).toList(growable: false);
    } on DioException catch (e) {
      Log.warning('Fetch animal notes failed: ${_noteErrorText(e)}');
      throw MessagedException(error: _noteErrorText(e));
    }
  }

  Future<notes.AnimalNote?> patchAnimalNote({
    required int id,
    required int animalId,
    required String text,
    List<PlatformFile>? files,
  }) async {
    Log.debug('Patch animal note: id=$id animalId=$animalId files=${files?.length ?? 0}');
    try {
      final dto = await _notesPort.patch(
        id,
        AnimalNoteWriteDto(id: id, animal: animalId, content: text, files: _prepareNoteFiles(files)),
        shelterId: _authService.currentShelterId,
      );
      Log.info('Animal note patched: id=${dto.id}');
      return _mapNote(dto);
    } on DioException catch (e) {
      Log.warning('Patch animal note failed: ${_noteErrorText(e)}');
      throw MessagedException(error: _noteErrorText(e));
    }
  }

  Future<bool> deleteAnimalNote({required int id}) async {
    Log.debug('Delete animal note: id=$id');
    try {
      await _notesPort.delete(id, shelterId: _authService.currentShelterId);
      Log.info('Animal note deleted: id=$id');
      return true;
    } on DioException catch (e) {
      Log.warning('Delete animal note failed: ${_noteErrorText(e)}');
      throw MessagedException(error: _noteErrorText(e));
    }
  }

  Future<notes.AnimalNote?> createAnimalNote({
    required int animalId,
    required String text,
    List<PlatformFile>? files,
  }) async {
    Log.debug('Create animal note: animalId=$animalId files=${files?.length ?? 0}');
    try {
      final dto = await _notesPort.create(
        AnimalNoteWriteDto(animal: animalId, content: text, files: _prepareNoteFiles(files)),
        shelterId: _authService.currentShelterId,
      );
      Log.info('Animal note created: id=${dto.id}');
      return _mapNote(dto);
    } on DioException catch (e) {
      Log.warning('Create animal note failed: ${_noteErrorText(e)}');
      throw MessagedException(error: _noteErrorText(e));
    }
  }

  List<AnimalNoteFileWriteDto>? _prepareNoteFiles(List<PlatformFile>? files) {
    // Байты берём кроссплатформенно: file_picker на web кладёт содержимое в
    // PlatformFile.bytes (path == null), на нативе — читаем с ФС по path.
    // Раньше фильтр `path != null` молча выкидывал ВСЕ файлы в web.
    final preparedfiles = files
        ?.map<AnimalNoteFileWriteDto?>((file) {
          final bytes = _readPlatformFileBytes(file);
          if (bytes == null) return null;
          int indexOfExtSplit = file.name.lastIndexOf('.');
          if (indexOfExtSplit < 0) indexOfExtSplit = file.name.length;
          return AnimalNoteFileWriteDto(
            name: file.name.substring(0, indexOfExtSplit),
            file: 'data:application/${file.extension};base64,${base64Encode(bytes)}',
          );
        })
        .whereType<AnimalNoteFileWriteDto>()
        .toList();
    return preparedfiles;
  }

  notes.AnimalNote _mapNote(AnimalNoteDto d) => notes.AnimalNote(
    id: d.id,
    url: d.url,
    animal: d.animal,
    content: d.content,
    files: d.files?.map(_mapNoteFile).toList(growable: false),
    createdAt: d.createdAt,
    updatedAt: d.updatedAt,
    createdBy: d.createdBy,
    updatedBy: d.updatedBy,
    isUserCanEditOrDelete: d.isUserCanEditOrDelete,
  );

  notes.AnimalNoteFile _mapNoteFile(AnimalNoteFileDto f) =>
      notes.AnimalNoteFile(id: f.id, file: f.file, name: f.name, filename: f.filename, createdAt: f.createdAt);

  String _noteErrorText(DioException e) => e.response?.data?.toString() ?? e.message ?? e.toString();

  /// Читает байты выбранного файла кроссплатформенно: из памяти (web/при
  /// withData) либо с ФС по пути (натив). Возвращает null, если ни то ни другое
  /// недоступно.
  Uint8List? _readPlatformFileBytes(PlatformFile file) {
    if (file.bytes != null) return file.bytes;
    if (!kIsWeb && file.path != null) return File(file.path!).readAsBytesSync();
    return null;
  }

  /// Получить PDF карточки животного как байты (кроссплатформенно, без диска).
  /// Раньше возвращал `File` и был доступен только на mobile; теперь байты идут
  /// прямо в рендерер/шаринг и работают в PWA.
  Future<Uint8List> fetchPdfAnimalCard(int animalId) async {
    Log.debug('Fetch PDF animal card: animalId=$animalId');
    // TODO: extract to DI
    final repo = getIt<DocumentRepository>();
    final bytes = await repo.fetchAnimalDoc(animalId);
    // Диагностика источника PDF (одним сообщением): длина в байтах и первые
    // байты (у валидного PDF — «%PDF» = 37 80 68 70).
    final head = bytes.take(8).toList();
    Log.info('[pdf] animalId=$animalId decoded=${bytes.lengthInBytes}B head=$head');
    return bytes;
  }
}
