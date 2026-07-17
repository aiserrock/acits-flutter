import '../../ports/animal_api_port.dart';
import '../../ports/dto/animal_attribute_dto.dart';
import '../../ports/dto/animal_dto.dart';
import '../../ports/dto/animal_image_dto.dart';
import '../../ports/dto/animal_image_write_dto.dart';
import '../../ports/dto/animal_write_dto.dart';
import '../../ports/dto/applicant_dto.dart';
import '../../ports/dto/curator_dto.dart';
import '../../ports/dto/image_thumbnails_dto.dart';
import '../../ports/dto/species_dto.dart';
import 'generated/clients/animals_client.dart';
import 'generated/models/animal_attribute_value.dart';
import 'generated/models/animal_image_read.dart';
import 'generated/models/animal_image_write.dart';
import 'generated/models/animal_read.dart';
import 'generated/models/animal_write.dart';
import 'generated/models/applicant.dart';
import 'generated/models/curator.dart';
import 'generated/models/image_thumbnails.dart';
import 'generated/models/level.dart';
import 'generated/models/species.dart';
import 'generated/models/status69f_enum.dart';

/// The ONLY place generated swagger_parser code is touched.
///
/// Wraps the generated [AnimalsClient] (retrofit over the shared `Dio` from
/// acits_core, injected in Step 7) and maps generated models onto OUR
/// generator-agnostic DTOs. Swapping generators = replace this file with a new
/// adapter implementing [AnimalApiPort]; ports/DTOs/features stay unchanged.
class AnimalApiAdapter implements AnimalApiPort {
  const AnimalApiAdapter(this._client);

  final AnimalsClient _client;

  @override
  Future<List<AnimalDto>> list({int? shelterId, String? search, int? limit, int? offset}) async {
    final page = await _client.v1AnimalsList(xCurrentShelter: shelterId, search: search, limit: limit, offset: offset);
    final results = page.results ?? const <AnimalRead>[];
    return results.map(_mapAnimal).toList(growable: false);
  }

  @override
  Future<AnimalDto> getById(int id, {int? shelterId}) async {
    final animal = await _client.v1AnimalsRetrieve(id: id.toString(), xCurrentShelter: shelterId);
    return _mapAnimal(animal);
  }

  @override
  Future<AnimalDto> create(AnimalWriteDto body, {int? shelterId}) async {
    final animal = await _client.v1AnimalsCreate(body: _mapWrite(body), xCurrentShelter: shelterId);
    return _mapAnimal(animal);
  }

  @override
  Future<AnimalDto> update(int id, AnimalWriteDto body, {int? shelterId}) async {
    final animal = await _client.v1AnimalsUpdate(id: id.toString(), body: _mapWrite(body), xCurrentShelter: shelterId);
    return _mapAnimal(animal);
  }

  @override
  Future<void> delete(int id, {int? shelterId}) =>
      _client.v1AnimalsDestroy(id: id.toString(), xCurrentShelter: shelterId);

  @override
  Future<List<SpeciesDto>> listSpecies({
    required int level,
    int? parentId,
    String? search,
    int? limit,
    int? offset,
    int? shelterId,
  }) async {
    final page = await _client.v1AnimalsSpeciesList(
      xCurrentShelter: shelterId,
      level: Level.fromJson(level),
      parentId: parentId,
      search: search,
      limit: limit,
      offset: offset,
    );
    final results = page.results ?? const <Species>[];
    return results.map(_mapSpecies).toList(growable: false);
  }

  // ── OUR DTO → generated (write path) ───────────────────────────────────────

  AnimalWrite _mapWrite(AnimalWriteDto d) => AnimalWrite(
    name: d.name,
    images: d.images?.map(_mapImageWrite).toList(growable: false),
    validImages: d.validImages,
    specId: d.specId,
    status: d.status == null ? null : Status69fEnum.fromJson(d.status!),
    dateJoined: d.dateJoined,
    birthDate: d.birthDate,
    deathDate: d.deathDate,
    deathReason: d.deathReason,
    defaultImageId: d.defaultImageId,
    placeOfCatch: d.placeOfCatch,
    placeOfRelease: d.placeOfRelease,
    dateOfChipping: d.dateOfChipping,
    chippingCode: d.chippingCode,
    height: d.height,
    weight: d.weight,
    shelter: d.shelter,
    curatorId: d.curatorId,
    applicantId: d.applicantId,
    animalAttributes: d.animalAttributes.map(_mapAttributeWrite).toList(growable: false),
    canBeShared: d.canBeShared,
  );

  AnimalImageWrite _mapImageWrite(AnimalImageWriteDto i) =>
      AnimalImageWrite(name: i.name, image: i.image, isPrimary: i.isPrimary);

  AnimalAttributeValue _mapAttributeWrite(AnimalAttributeDto a) =>
      AnimalAttributeValue(attrId: a.attrId, name: a.name, value: a.value, isRequired: a.isRequired);

  // ── generated → OUR DTO mapping ────────────────────────────────────────────

  AnimalDto _mapAnimal(AnimalRead a) => AnimalDto(
    id: a.id,
    uuid: a.uuid,
    url: a.url,
    name: a.name,
    images: a.images.map(_mapImage).toList(growable: false),
    spec: _mapSpecies(a.spec),
    status: a.status?.json,
    dateJoined: a.dateJoined,
    birthDate: a.birthDate,
    deathDate: a.deathDate,
    deathReason: a.deathReason,
    defaultImageId: a.defaultImageId,
    placeOfCatch: a.placeOfCatch,
    placeOfRelease: a.placeOfRelease,
    dateOfChipping: a.dateOfChipping,
    chippingCode: a.chippingCode,
    height: a.height,
    weight: a.weight,
    hasDocuments: a.hasDocuments,
    shelter: a.shelter,
    curator: _mapCurator(a.curator),
    applicant: _mapApplicant(a.applicant),
    animalAttributes: a.animalAttributes.map(_mapAttribute).toList(growable: false),
    deletedAt: a.deletedAt,
    adoption: a.adoption,
    release: a.release,
    overstay: a.overstay,
    canBeShared: a.canBeShared,
  );

  AnimalImageDto _mapImage(AnimalImageRead i) =>
      AnimalImageDto(id: i.id, filename: i.filename, image: _mapThumbnails(i.image), isPrimary: i.isPrimary);

  ImageThumbnailsDto _mapThumbnails(ImageThumbnails t) =>
      ImageThumbnailsDto(large: t.large, medium: t.medium, small: t.small);

  SpeciesDto _mapSpecies(Species s) => SpeciesDto(
    id: s.id,
    name: s.name,
    level: s.level.json ?? 0,
    parentId: s.parentId,
    parentName: s.parentName,
    categoryName: s.categoryName,
  );

  CuratorDto _mapCurator(Curator c) => CuratorDto(
    id: c.id,
    url: c.url,
    shelter: c.shelter,
    firstName: c.firstName,
    lastName: c.lastName,
    email: c.email,
    phoneNumber: c.phoneNumber,
    address: c.address,
    createdBy: c.createdBy,
    updatedBy: c.updatedBy,
    createdAt: c.createdAt,
    updatedAt: c.updatedAt,
  );

  ApplicantDto _mapApplicant(Applicant a) => ApplicantDto(
    id: a.id,
    url: a.url,
    shelter: a.shelter,
    firstName: a.firstName,
    lastName: a.lastName,
    email: a.email,
    phoneNumber: a.phoneNumber,
    contactDetails: a.contactDetails,
    createdBy: a.createdBy,
    updatedBy: a.updatedBy,
    createdAt: a.createdAt,
    updatedAt: a.updatedAt,
    animalId: a.animalId,
    applicantFiles: a.applicantFiles?.map((f) => Map<String, dynamic>.from(f.toJson())).toList(growable: false),
  );

  AnimalAttributeDto _mapAttribute(AnimalAttributeValue v) =>
      AnimalAttributeDto(attrId: v.attrId, name: v.name, value: v.value, isRequired: v.isRequired);
}
