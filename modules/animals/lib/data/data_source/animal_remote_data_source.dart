import 'dart:typed_data';

import 'package:acits_api/acits_api.dart';

/// Тонкая обёртка над [AnimalApiPort]: только вызовы, никакой логики/маппинга.
/// Возвращает DTO — их разворачивает в сущности репозиторий (там DTO и стоп).
class AnimalRemoteDataSource {
  const AnimalRemoteDataSource(this._port);

  final AnimalApiPort _port;

  Future<List<AnimalDto>> list({int? shelterId, String? search, String? ordering, int? limit, int? offset}) =>
      _port.list(shelterId: shelterId, search: search, ordering: ordering, limit: limit, offset: offset);

  Future<AnimalDto> getById(int id, {int? shelterId}) => _port.getById(id, shelterId: shelterId);

  Future<AnimalDto> create(AnimalWriteDto body, {int? shelterId}) => _port.create(body, shelterId: shelterId);

  Future<AnimalDto> update(int id, AnimalWriteDto body, {int? shelterId}) =>
      _port.update(id, body, shelterId: shelterId);

  Future<void> delete(int id, {int? shelterId}) => _port.delete(id, shelterId: shelterId);

  Future<List<SpeciesDto>> listSpecies({
    required int level,
    int? parentId,
    String? search,
    int? limit,
    int? offset,
    int? shelterId,
  }) => _port.listSpecies(
    level: level,
    parentId: parentId,
    search: search,
    limit: limit,
    offset: offset,
    shelterId: shelterId,
  );

  Future<AnimalDto> updatePhotos(
    int id, {
    required List<AnimalImageWriteDto> newImages,
    required List<int> retainImageIds,
    int? shelterId,
  }) => _port.updatePhotos(id, newImages: newImages, retainImageIds: retainImageIds, shelterId: shelterId);

  Future<Uint8List> getAnimalPdf({
    required int id,
    required String pdfType,
    required DateTime from,
    required DateTime to,
    String? tz,
    int? shelterId,
  }) => _port.getAnimalPdf(id: id, pdfType: pdfType, from: from, to: to, tz: tz, shelterId: shelterId);
}
