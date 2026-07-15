import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:flutter/foundation.dart';

import 'package:acits_flutter/di/di_container.dart';
import 'package:acits_flutter/domain/gallery_item_data.dart';
import 'package:acits_flutter/export.dart';
import 'package:acits_flutter/service/document/document_repository.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/services.dart';
import 'package:image/image.dart' as image_util;
import 'package:injectable/injectable.dart';

import 'package:acits_flutter/domain/exception.dart';
import 'package:acits_flutter/service/auth/auth_service.dart';
import 'package:acits_flutter/util/logger/log.dart';

const _maxAnimalImageSize = 1024;
const _notesListLimit = 25;

@singleton
class AnimalService {
  AnimalService(this._authService, this._client);

  final AuthService _authService;
  final Openapi _client;

  /// Получить список живолных в приюте
  Future<PaginatedAnimalReadList?> fetchAnimalList({
    int limit = 25,
    int offset = 0,
    String? searchRequest,
    String? ordering,
  }) async {
    Log.debug('Fetch animal list: limit=$limit offset=$offset search=$searchRequest ordering=$ordering');
    final result = await _client.apiV1AnimalsGet(
      limit: limit,
      offset: offset,
      xCurrentShelter: _authService.currentShelterId,
      search: searchRequest,
      ordering: ordering,
    );

    if (result.body != null) {
      Log.info('Animal list: ${result.body?.results?.length ?? 0} items');
      return result.body;
    } else {
      Log.warning('Fetch animal list failed: ${result.error}');
      throw MessagedException(error: result.error);
    }
  }

  /// Получить детальное представление животного по его ID
  Future<AnimalRead> fetchAnimalDetail({required int id}) async {
    Log.debug('Fetch animal detail: id=$id');
    final result = await _client.apiV1AnimalsIdGet(id: id.toString(), xCurrentShelter: _authService.currentShelterId);

    if (result.body != null) {
      Log.info('Animal detail: id=${result.body!.id}');
      return result.body!;
    } else {
      Log.warning('Fetch animal detail failed: ${result.error}');
      throw MessagedException(error: result.error);
    }
  }

  Future<List<Species>> getAnimalSpecies({
    required ApiV1AnimalsSpeciesGetLevel level,
    int limit = 25,
    int offset = 0,
    int? parentId,
    String? searchRequest,
  }) async {
    Log.debug(
      'Fetch animal species: level=$level limit=$limit offset=$offset '
      'parentId=$parentId search=$searchRequest',
    );
    final result = await _client.apiV1AnimalsSpeciesGet(
      level: level,
      limit: limit,
      offset: offset,
      parentId: parentId,
      search: searchRequest,
      xCurrentShelter: _authService.currentShelterId,
    );

    final data = result.body?.results;

    if (data != null) {
      Log.info('Animal species: ${data.length} items');
      return data;
    } else {
      Log.warning('Fetch animal species failed: ${result.error}');
      throw MessagedException(error: result.error);
    }
  }

  Future<AnimalRead?> createAnimal(AnimalWrite animal) async {
    Log.debug('Create animal');
    animal = animal.copyWith(
      shelter: _authService.shelterRole?.currentShelter,
      placeOfRelease: animal.placeOfRelease ?? '',
      deathReason: animal.deathReason ?? '',
    );
    final result = await _client.apiV1AnimalsPost(xCurrentShelter: _authService.currentShelterId, body: animal);

    final data = result.body;

    if (data != null) {
      Log.info('Animal created: id=${data.id}');
      return data;
    } else {
      Log.warning('Create animal failed: ${result.error}');
      throw MessagedException(error: result.error);
    }
  }

  Future<AnimalRead?> updateAnimal(int id, AnimalWrite animal) async {
    Log.debug('Update animal: id=$id');
    animal = animal.copyWith(
      shelter: _authService.shelterRole?.currentShelter,
      placeOfRelease: animal.placeOfRelease ?? '',
      deathReason: animal.deathReason ?? '',
    );
    final result = await _client.apiV1AnimalsIdPut(
      id: id.toString(),
      xCurrentShelter: _authService.currentShelterId,
      body: animal,
    );

    final data = result.body;

    if (data != null) {
      Log.info('Animal updated: id=${data.id}');
      return data;
    } else {
      Log.warning('Update animal failed: ${result.error}');
      throw MessagedException(error: result.error);
    }
  }

  ApiV1AnimalsSpeciesGetLevel getLevel(int value) {
    assert(value >= 0);
    assert(value < ApiV1AnimalsSpeciesGetLevel.values.length - 1);
    return ApiV1AnimalsSpeciesGetLevel.values[value + 1];
  }

  Future<AnimalRead> changeAnimalPhotos(int animalId, List<GalleryItemData> images) async {
    Log.debug('Change animal photos: animalId=$animalId images=${images.length}');
    final animal = await _client.apiV1AnimalsIdGet(
      id: animalId.toString(),
      xCurrentShelter: _authService.currentShelterId,
    );

    final retainImages = <int>[];
    images.where((e) => e.network != null).forEach((e) {
      if (e.isChoosed) retainImages.add(e.network?.id ?? -1);
    });

    final additional = <AnimalImageWrite>[];
    final assets = images.where((e) => e.assetPath != null && e.isChoosed);
    if (assets.isNotEmpty) {
      await Future.wait(
        assets.map((e) async {
          final fileBytes = (await rootBundle.load(e.assetPath!));
          final buffer = fileBytes.buffer;
          additional.add(
            AnimalImageWrite(
              isPrimary: false,
              name: e.assetPath ?? '',
              image: base64Encode(buffer.asUint8List(fileBytes.offsetInBytes, fileBytes.lengthInBytes)),
            ),
          );
        }),
      );
    }

    // Байты выбранных с устройства фото читаются кроссплатформенно на этапе
    // выбора (GalleryItemData.bytes) — File(path).readAsBytesSync() падал бы на
    // web. Элементы без bytes (старый blob-URL без данных) пропускаем.
    images.where((e) => e.bytes != null && e.isChoosed).forEach((e) {
      var image = image_util.decodeImage(e.bytes!);
      if (image == null) return;
      if (image.height > _maxAnimalImageSize || image.width > _maxAnimalImageSize) {
        final ratio = _maxAnimalImageSize / max(image.height, image.width);
        image = image_util.copyResize(
          image,
          height: (image.height * ratio).floor(),
          width: (image.width * ratio).floor(),
        );
      }

      additional.add(
        AnimalImageWrite(isPrimary: false, name: e.filePath ?? '', image: base64Encode(image_util.encodePng(image))),
      );
    });

    final result = await _client.apiV1AnimalsIdPut(
      xCurrentShelter: _authService.currentShelterId,
      id: animalId.toString(),
      body: animal.body?.write.copyWith(images: additional, validImages: retainImages),
    );

    final data = result.body;

    if (data != null) {
      Log.info('Animal photos changed: id=${data.id}');
      return data;
    } else {
      Log.warning('Change animal photos failed: ${result.error}');
      throw MessagedException(error: result.error);
    }
  }

  Future<void> deleteAnimal(String id) async {
    Log.debug('Delete animal: id=$id');
    final result = await _client.apiV1AnimalsIdDelete(id: id, xCurrentShelter: _authService.currentShelterId);

    if (result.error != null) {
      Log.warning('Delete animal failed: ${result.error}');
      throw MessagedException(error: result.error);
    }
    Log.info('Animal deleted: id=$id');
  }

  Future<PaginatedAnimalNoteList?> fetchAnimalNotes(
    int animalId, {
    int limit = _notesListLimit,
    int? offset = 0,
  }) async {
    Log.debug('Fetch animal notes: animalId=$animalId limit=$limit offset=$offset');
    final result = await _client.apiV1AnimalsNotesGet(
      animal: animalId,
      limit: limit,
      offset: offset,
      ordering: '-created_at',
      xCurrentShelter: _authService.currentShelterId,
    );

    final data = result.body;

    if (data != null) {
      Log.info('Animal notes: ${data.results?.length ?? 0} items');
      return data;
    } else {
      Log.warning('Fetch animal notes failed: ${result.error}');
      throw MessagedException(error: result.error);
    }
  }

  Future<AnimalNote?> patchAnimalNote({
    required int id,
    required int animalId,
    required String text,
    List<PlatformFile>? files,
  }) async {
    Log.debug('Patch animal note: id=$id animalId=$animalId files=${files?.length ?? 0}');
    final content = PatchedAnimalNote(id: id, animal: animalId, content: text, files: _prepareNoteFiles(files));
    final result = await _client.apiV1AnimalsNotesIdPatch(
      id: id,
      body: content,
      xCurrentShelter: _authService.currentShelterId,
    );

    final data = result.body;

    if (data != null) {
      Log.info('Animal note patched: id=${data.id}');
      return data;
    } else {
      Log.warning('Patch animal note failed: ${result.error}');
      throw MessagedException(error: result.error);
    }
  }

  Future<bool> deleteAnimalNote({required int id}) async {
    Log.debug('Delete animal note: id=$id');
    final result = await _client.apiV1AnimalsNotesIdDelete(id: id, xCurrentShelter: _authService.currentShelterId);

    if (result.error == null) {
      Log.info('Animal note deleted: id=$id');
      return true;
    } else {
      Log.warning('Delete animal note failed: ${result.error}');
      throw MessagedException(error: result.error);
    }
  }

  Future<AnimalNote?> createAnimalNote({required int animalId, required String text, List<PlatformFile>? files}) async {
    Log.debug('Create animal note: animalId=$animalId files=${files?.length ?? 0}');
    final content = AnimalNote(animal: animalId, content: text, files: _prepareNoteFiles(files));

    final result = await _client.apiV1AnimalsNotesPost(body: content, xCurrentShelter: _authService.currentShelterId);

    final data = result.body;

    if (data != null) {
      Log.info('Animal note created: id=${data.id}');
      return data;
    } else {
      Log.warning('Create animal note failed: ${result.error}');
      throw MessagedException(error: result.error);
    }
  }

  List<AnimalNoteFile>? _prepareNoteFiles(List<PlatformFile>? files) {
    // Байты берём кроссплатформенно: file_picker на web кладёт содержимое в
    // PlatformFile.bytes (path == null), на нативе — читаем с ФС по path.
    // Раньше фильтр `path != null` молча выкидывал ВСЕ файлы в web.
    final preparedfiles = files
        ?.map<AnimalNoteFile?>((file) {
          final bytes = _readPlatformFileBytes(file);
          if (bytes == null) return null;
          int indexOfExtSplit = file.name.lastIndexOf('.');
          if (indexOfExtSplit < 0) indexOfExtSplit = file.name.length;
          return AnimalNoteFile(
            name: file.name.substring(0, indexOfExtSplit),
            file: 'data:application/${file.extension};base64,${base64Encode(bytes)}',
          );
        })
        .whereType<AnimalNoteFile>()
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

  /// Получить PDF карточки животного как байты (кроссплатформенно, без диска).
  /// Раньше возвращал `File` и был доступен только на mobile; теперь байты идут
  /// прямо в рендерер/шаринг и работают в PWA.
  Future<Uint8List> fetchPdfAnimalCard(int animalId) async {
    Log.debug('Fetch PDF animal card: animalId=$animalId');
    // TODO: extract to DI
    final repo = getIt<DocumentRepository>();
    final raw = await repo.fetchAnimalDoc(animalId);
    final bytes = repo.decodePdfBytes(raw);
    // Диагностика источника PDF (одним сообщением): длина строки от бэка, длина
    // после декода и первые байты (у валидного PDF — «%PDF» = 37 80 68 70).
    final head = bytes.take(8).toList();
    Log.info(
      '[pdf] animalId=$animalId raw.len=${raw.length} '
      'decoded=${bytes.lengthInBytes}B head=$head '
      'rawHead="${raw.length > 8 ? raw.substring(0, 8) : raw}"',
    );
    return bytes;
  }
}
