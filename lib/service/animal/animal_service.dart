import 'dart:convert';
import 'dart:io';
import 'dart:math';

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
  }) async {
    final result = await _client.apiV1AnimalsGet(
      limit: limit,
      offset: offset,
      xCurrentShelter: _authService.currentShelterId,
      search: searchRequest,
    );

    if (result.body != null) {
      return result.body;
    } else {
      throw MessagedException(error: result.error);
    }
  }

  /// Получить детальное представление животного по его ID
  Future<AnimalRead> fetchAnimalDetail({required int id}) async {
    final result = await _client.apiV1AnimalsIdGet(
      id: id.toString(),
      xCurrentShelter: _authService.currentShelterId,
    );

    if (result.body != null) {
      return result.body!;
    } else {
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
      return data;
    } else {
      throw MessagedException(error: result.error);
    }
  }

  Future<AnimalRead?> createAnimal(AnimalWrite animal) async {
    animal = animal.copyWith(
      shelter: _authService.shelterRole?.currentShelter,
      placeOfRelease: animal.placeOfRelease ?? '',
      deathReason: animal.deathReason ?? '',
    );
    final result = await _client.apiV1AnimalsPost(
      xCurrentShelter: _authService.currentShelterId,
      body: animal,
    );

    final data = result.body;

    if (data != null) {
      return data;
    } else {
      throw MessagedException(error: result.error);
    }
  }

  Future<AnimalRead?> updateAnimal(int id, AnimalWrite animal) async {
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
      return data;
    } else {
      throw MessagedException(error: result.error);
    }
  }

  ApiV1AnimalsSpeciesGetLevel getLevel(int value) {
    assert(value >= 0);
    assert(value < ApiV1AnimalsSpeciesGetLevel.values.length - 1);
    return ApiV1AnimalsSpeciesGetLevel.values[value + 1];
  }

  Future<AnimalRead> changeAnimalPhotos(int animalId, List<GalleryItemData> images) async {
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
              image: base64Encode(
                buffer.asUint8List(fileBytes.offsetInBytes, fileBytes.lengthInBytes),
              ),
            ),
          );
        }),
      );
    }

    images.where((e) => e.filePath != null && e.isChoosed).forEach((e) {
      var image = image_util.decodeImage(File(e.filePath!).readAsBytesSync());
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
        AnimalImageWrite(
          isPrimary: false,
          name: e.filePath ?? '',
          image: base64Encode(image_util.encodePng(image)),
        ),
      );
    });

    final result = await _client.apiV1AnimalsIdPut(
      xCurrentShelter: _authService.currentShelterId,
      id: animalId.toString(),
      body: animal.body?.write.copyWith(images: additional, validImages: retainImages),
    );

    final data = result.body;

    if (data != null) {
      return data;
    } else {
      throw MessagedException(error: result.error);
    }
  }

  Future<void> deleteAnimal(String id) async {
    final result = await _client.apiV1AnimalsIdDelete(
      id: id,
      xCurrentShelter: _authService.currentShelterId,
    );

    if (result.error != null) {
      throw MessagedException(error: result.error);
    }
  }

  Future<PaginatedAnimalNoteList?> fetchAnimalNotes(
    int animalId, {
    int limit = _notesListLimit,
    int? offset = 0,
  }) async {
    final result = await _client.apiV1AnimalsNotesGet(
      animal: animalId,
      limit: limit,
      offset: offset,
      ordering: '-created_at',
      xCurrentShelter: _authService.currentShelterId,
    );

    final data = result.body;

    if (data != null) {
      return data;
    } else {
      throw MessagedException(error: result.error);
    }
  }

  Future<AnimalNote?> patchAnimalNote({
    required int id,
    required int animalId,
    required String text,
    List<PlatformFile>? files,
  }) async {
    final content = PatchedAnimalNote(
      id: id,
      animal: animalId,
      content: text,
      files: _prepareNoteFiles(files),
    );
    final result = await _client.apiV1AnimalsNotesIdPatch(
      id: id,
      body: content,
      xCurrentShelter: _authService.currentShelterId,
    );

    final data = result.body;

    if (data != null) {
      return data;
    } else {
      throw MessagedException(error: result.error);
    }
  }

  Future<bool> deleteAnimalNote({required int id}) async {
    final result = await _client.apiV1AnimalsNotesIdDelete(
      id: id,
      xCurrentShelter: _authService.currentShelterId,
    );

    if (result.error == null) {
      return true;
    } else {
      throw MessagedException(error: result.error);
    }
  }

  Future<AnimalNote?> createAnimalNote({
    required int animalId,
    required String text,
    List<PlatformFile>? files,
  }) async {
    final content = AnimalNote(animal: animalId, content: text, files: _prepareNoteFiles(files));

    final result = await _client.apiV1AnimalsNotesPost(
      body: content,
      xCurrentShelter: _authService.currentShelterId,
    );

    final data = result.body;

    if (data != null) {
      return data;
    } else {
      throw MessagedException(error: result.error);
    }
  }

  List<AnimalNoteFile>? _prepareNoteFiles(List<PlatformFile>? files) {
    final preparedfiles = files?.where((file) => file.path != null).map<AnimalNoteFile>((file) {
      int indexOfExtSplit = file.name.lastIndexOf('.');
      if (indexOfExtSplit < 0) indexOfExtSplit = file.name.length;
      return AnimalNoteFile(
        name: file.name.substring(0, indexOfExtSplit),
        file:
            'data:application/${file.extension};base64,${base64Encode(File(file.path!).readAsBytesSync())}',
      );
    }).toList();
    return preparedfiles;
  }

  /// Скачать и сохранить во временной директории файл карточки животного
  Future<File> fetchPdfAnimalCard(int animalId) async {
    // TODO: extract to DI
    final repo = getIt<DocumentRepository>();
    final raw = await repo.fetchAnimalDoc(animalId);
    final pdf = await repo.convertPdfStringToFile(raw, fileName: 'animal_$animalId.pdf');
    return pdf;
  }
}
