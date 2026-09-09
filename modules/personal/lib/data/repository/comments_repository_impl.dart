import 'dart:convert';

import 'package:core/api.dart' show AnimalNotesApiPort, AnimalNoteWriteDto, AnimalNoteFileWriteDto;
import 'package:core/data.dart';
import 'package:util/util.dart';

import 'package:personal/data/mapper/mapper.dart';
import 'package:personal/domain/domain.dart';
import 'package:personal/util/util.dart';

/// Реализация [CommentsRepository]. Здесь DTO заканчиваются: вызываем
/// [AnimalNotesApiPort], разворачиваем DTO → сущности мапперами, ловим
/// исключения → типизированный [Failure] через общий [guard]. Наружу (в
/// домен/UI) уходят только сущности в [Result].
///
/// Скоуп по приюту берётся из [PersonalShelterProvider] (мостится в приложении
/// к AuthService).
class CommentsRepositoryImpl implements CommentsRepository {
  const CommentsRepositoryImpl(this._notesPort, this._shelterProvider);

  final AnimalNotesApiPort _notesPort;
  final PersonalShelterProvider _shelterProvider;

  @override
  Future<Result<Failure, List<AnimalNote>>> listByAnimal(int animalId, {int limit = kNotesListLimit, int offset = 0}) {
    Log.debug('Fetch animal notes: animalId=$animalId limit=$limit offset=$offset');
    return _guard(() async {
      final dtos = await _notesPort.listByAnimal(
        animalId,
        limit: limit,
        offset: offset,
        shelterId: _shelterProvider.shelterId,
      );
      Log.info('Animal notes: ${dtos.length} items');
      return dtos.map((d) => AnimalNoteMapper(d).toEntity()).toList(growable: false);
    });
  }

  @override
  Future<Result<Failure, AnimalNote>> create({
    required int animalId,
    required String text,
    List<AnimalNoteFileInput> files = const [],
  }) {
    Log.debug('Create animal note: animalId=$animalId files=${files.length}');
    return _guard(() async {
      final dto = await _notesPort.create(
        AnimalNoteWriteDto(animal: animalId, content: text, files: _toFileDtos(files)),
        shelterId: _shelterProvider.shelterId,
      );
      Log.info('Animal note created: id=${dto.id}');
      return AnimalNoteMapper(dto).toEntity();
    });
  }

  @override
  Future<Result<Failure, AnimalNote>> patch({
    required int id,
    required int animalId,
    required String text,
    List<AnimalNoteFileInput> files = const [],
  }) {
    Log.debug('Patch animal note: id=$id animalId=$animalId files=${files.length}');
    return _guard(() async {
      final dto = await _notesPort.patch(
        id,
        AnimalNoteWriteDto(id: id, animal: animalId, content: text, files: _toFileDtos(files)),
        shelterId: _shelterProvider.shelterId,
      );
      Log.info('Animal note patched: id=${dto.id}');
      return AnimalNoteMapper(dto).toEntity();
    });
  }

  @override
  Future<Result<Failure, void>> delete(int id) {
    Log.debug('Delete animal note: id=$id');
    return _guard(() async {
      await _notesPort.delete(id, shelterId: _shelterProvider.shelterId);
      Log.info('Animal note deleted: id=$id');
    });
  }

  /// Доменные вложения → write-DTO: имя без расширения + data-URL с base64.
  /// Чтение байтов остаётся на стороне presentation (платформенная операция),
  /// кодирование под провод — здесь.
  List<AnimalNoteFileWriteDto>? _toFileDtos(List<AnimalNoteFileInput> files) {
    return files.map((file) {
      int indexOfExtSplit = file.name.lastIndexOf('.');
      if (indexOfExtSplit < 0) indexOfExtSplit = file.name.length;
      return AnimalNoteFileWriteDto(
        name: file.name.substring(0, indexOfExtSplit),
        file: 'data:application/${file.extension};base64,${base64Encode(file.bytes)}',
      );
    }).toList();
  }

  /// Логируем на этом уровне: выше остаётся только [Failure], а исходное
  /// исключение со стеком — единственное, по чему в crash-репорте видно, что
  /// именно упало.
  Future<Result<Failure, T>> _guard<T>(Future<T> Function() body) =>
      guard(body, onError: (e, s) => Log.error('CommentsRepository request failed', e, s));
}
