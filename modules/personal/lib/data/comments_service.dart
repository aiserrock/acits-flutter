import 'dart:convert';
import 'dart:io';

import 'package:core/api.dart'
    show
        AnimalNotesApiPort,
        AnimalNoteWriteDto,
        AnimalNoteFileWriteDto,
        AnimalNoteDto,
        AnimalNoteFileDto;
import 'package:core/domain.dart' show MessagedException;
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';

import 'package:personal/domain/domain.dart';
import 'package:personal/util/util.dart';

const _notesListLimit = 25;

/// Сервис заметок/комментариев животного.
///
/// Прикладной сервис поверх стабильного [AnimalNotesApiPort]: вызывает порт,
/// разворачивает DTO → доменные сущности [AnimalNote], ошибки Dio →
/// [MessagedException]. Скоуп по приюту берётся из [PersonalShelterProvider]
/// (мостится в приложении к AuthService). Логика перенесена из app
/// `AnimalService` без изменений поведения.
class CommentsService {
  CommentsService(this._notesPort, this._shelterProvider);

  final AnimalNotesApiPort _notesPort;
  final PersonalShelterProvider _shelterProvider;

  /// Список заметок животного (новые сверху). Возвращает доменные сущности —
  /// маппинг DTO→сущность локальный (порт отдаёт DTO).
  Future<List<AnimalNote>> fetchAnimalNotes(
    int animalId, {
    int limit = _notesListLimit,
    int? offset = 0,
  }) async {
    Log.debug('Fetch animal notes: animalId=$animalId limit=$limit offset=$offset');
    try {
      final dtos = await _notesPort.listByAnimal(
        animalId,
        limit: limit,
        offset: offset,
        shelterId: _shelterProvider.shelterId,
      );
      Log.info('Animal notes: ${dtos.length} items');
      return dtos.map(_mapNote).toList(growable: false);
    } on DioException catch (e) {
      Log.warning('Fetch animal notes failed: ${_noteErrorText(e)}');
      throw MessagedException(error: _noteErrorText(e));
    }
  }

  Future<AnimalNote?> patchAnimalNote({
    required int id,
    required int animalId,
    required String text,
    List<PlatformFile>? files,
  }) async {
    Log.debug('Patch animal note: id=$id animalId=$animalId files=${files?.length ?? 0}');
    try {
      final dto = await _notesPort.patch(
        id,
        AnimalNoteWriteDto(
          id: id,
          animal: animalId,
          content: text,
          files: _prepareNoteFiles(files),
        ),
        shelterId: _shelterProvider.shelterId,
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
      await _notesPort.delete(id, shelterId: _shelterProvider.shelterId);
      Log.info('Animal note deleted: id=$id');
      return true;
    } on DioException catch (e) {
      Log.warning('Delete animal note failed: ${_noteErrorText(e)}');
      throw MessagedException(error: _noteErrorText(e));
    }
  }

  Future<AnimalNote?> createAnimalNote({
    required int animalId,
    required String text,
    List<PlatformFile>? files,
  }) async {
    Log.debug('Create animal note: animalId=$animalId files=${files?.length ?? 0}');
    try {
      final dto = await _notesPort.create(
        AnimalNoteWriteDto(animal: animalId, content: text, files: _prepareNoteFiles(files)),
        shelterId: _shelterProvider.shelterId,
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

  /// Читает байты выбранного файла кроссплатформенно: из памяти (web/при
  /// withData) либо с ФС по пути (натив). Возвращает null, если ни то ни другое
  /// недоступно.
  Uint8List? _readPlatformFileBytes(PlatformFile file) {
    if (file.bytes != null) return file.bytes;
    if (!kIsWeb && file.path != null) return File(file.path!).readAsBytesSync();
    return null;
  }

  AnimalNote _mapNote(AnimalNoteDto d) => AnimalNote(
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

  AnimalNoteFile _mapNoteFile(AnimalNoteFileDto f) => AnimalNoteFile(
    id: f.id,
    file: f.file,
    name: f.name,
    filename: f.filename,
    createdAt: f.createdAt,
  );

  String _noteErrorText(DioException e) =>
      e.response?.data?.toString() ?? e.message ?? e.toString();
}
