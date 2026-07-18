import 'package:core/api.dart';

import 'package:animals/domain/domain.dart';

/// Домен [Animal] (+ входные данные формы редактирования) → [AnimalWriteDto].
///
/// Экран правки собирает пейлоад из полей формы, поэтому то, что доменный
/// [Animal] восстановить не может, передаётся явно:
/// - [attributes] — потому что доменный `attributes` (Map name→value) теряет
///   `attrId`/`isRequired`, обязательные для записи;
/// - [newImages] — новые фото (base64), [retainImageIds] — id уже загруженных,
///   которые надо сохранить;
/// - [specId] — обязателен на запись; если не передан, берём `animal.speciesId`.
///
/// Обязательные на запись поля (specId, placeOfCatch, dateJoined, shelter)
/// извлекаются из [animal]; если чего-то нет — это ошибка вызова (assert),
/// а не «тихий» дефолт, чтобы не отправить на бэкенд неполный объект.
AnimalWriteDto animalToWriteDto(
  Animal animal, {
  required List<AnimalAttributeDto> attributes,
  List<AnimalImageWriteDto> newImages = const [],
  List<int> retainImageIds = const [],
  int? specId,
  int? curatorId,
  int? applicantId,
}) {
  final resolvedSpecId = specId ?? animal.speciesId;
  assert(resolvedSpecId != null, 'AnimalWriteDto requires specId (animal.speciesId or explicit)');
  assert(animal.placeOfCatch != null, 'AnimalWriteDto requires placeOfCatch');
  assert(animal.dateJoined != null, 'AnimalWriteDto requires dateJoined');

  return AnimalWriteDto(
    specId: resolvedSpecId!,
    dateJoined: animal.dateJoined!,
    placeOfCatch: animal.placeOfCatch!,
    shelter: animal.shelterId,
    animalAttributes: attributes,
    name: animal.name,
    images: newImages.isEmpty ? null : newImages,
    validImages: retainImageIds.isEmpty ? null : retainImageIds,
    status: animal.status.wire,
    birthDate: animal.birthDate,
    placeOfRelease: animal.placeOfRelease,
    chippingCode: animal.chippingCode,
    height: animal.height,
    weight: animal.weight,
    curatorId: curatorId ?? animal.curator?.id,
    applicantId: applicantId ?? animal.applicant?.id,
    canBeShared: animal.canBeShared,
  );
}
