import 'package:animals/animals.dart' as domain;

import 'package:acits_flutter/export.dart';

/// STRANGLER SEAM (временный): конверсии домен [domain.Animal] ↔ DTO `AnimalRead`.
///
/// Форма правки животного (мультистраничный UI + `AnimalEditHolder`) осталась в
/// корне и всё ещё работает на `AnimalRead`, тогда как load/submit ушли в
/// модульный репозиторий (домен + Result). Эти две функции — единственная точка,
/// где домен встречается с DTO; `AnimalRead` не течёт в модуль. Когда форму
/// перепишут на доменную модель, весь этот файл удаляется.
///
/// TODO(strangler): удалить после перевода формы правки на доменную модель.
extension AnimalEditSeam on domain.Animal {
  /// Домен → seed-`AnimalRead` для инициализации формы (`AnimalEditHolder`).
  ///
  /// Восстанавливаем только то, что читают виджеты формы: имя, вид (spec),
  /// статус, даты, место отлова, габариты/чип, атрибуты (sex/color/…), аватар,
  /// куратор/заявитель. Уровень вида в форме не читается — берём kind-дефолт.
  AnimalRead toReadSeed() {
    final s = speciesId;
    final species = (s != null || speciesName != null || speciesCategoryName != null)
        ? Species(
            id: s,
            name: speciesName ?? '',
            level: LevelEnum.value_3,
            parentName: speciesParentName,
            categoryName: speciesCategoryName,
          )
        : null;

    return AnimalRead(
      id: id,
      name: name,
      images: images.map(_toImageRead).nonNulls.toList(),
      spec: species,
      status: Status69fEnum.values.firstWhereOrNull((e) => e.value == status.wire),
      dateJoined: dateJoined ?? DateTime.now(),
      birthDate: birthDate,
      placeOfCatch: placeOfCatch ?? '',
      placeOfRelease: placeOfRelease,
      dateOfChipping: dateOfChipping,
      chippingCode: chippingCode,
      height: height,
      weight: weight,
      shelter: shelterId,
      curator: _curator,
      applicant: _applicant,
      animalAttributes: attributes.entries
          .map((e) => AnimalAttributeValue(attrId: 0, name: e.key, value: e.value))
          .toList(),
      canBeShared: canBeShared,
    );
  }

  AnimalImageRead? _toImageRead(domain.AnimalImage i) {
    final large = i.large;
    final medium = i.medium;
    final small = i.small;
    if (large == null && medium == null && small == null) return null;
    return AnimalImageRead(
      id: i.id,
      isPrimary: i.isPrimary,
      filename: i.filename,
      image: ImageThumbnails(large: large ?? '', medium: medium ?? '', small: small ?? ''),
    );
  }

  Curator? get _curator {
    final c = curator;
    if (c == null) return null;
    return Curator(
      id: c.id,
      firstName: c.firstName,
      lastName: c.lastName,
      email: c.email,
      phoneNumber: c.phoneNumber ?? '',
      address: c.extra ?? '',
    );
  }

  Applicant? get _applicant {
    final a = applicant;
    if (a == null) return null;
    return Applicant(
      id: a.id,
      firstName: a.firstName,
      lastName: a.lastName,
      email: a.email,
      phoneNumber: a.phoneNumber ?? '',
      contactDetails: a.extra,
    );
  }
}

/// Собранные из формы (`AnimalRead`) доменные входные данные для submit.
///
/// [animal] несёт скаляры; атрибуты/фото передаются отдельно (см. cubit.submit).
class AnimalEditSubmitInputs {
  const AnimalEditSubmitInputs({
    required this.animal,
    required this.attributes,
    required this.newImages,
    required this.retainImageIds,
    this.specId,
  });

  final domain.Animal animal;
  final List<domain.AnimalAttributeInput> attributes;
  final List<domain.AnimalImageInput> newImages;
  final List<int> retainImageIds;
  final int? specId;
}

/// Отредактированный `AnimalRead` из холдера формы → доменные входные данные.
///
/// Зеркалит прежний `AnimalRead.write`: specId/атрибуты/`valid_images` берутся из
/// тех же полей. `spec` в холдере может быть либо `Species` (из seed), либо
/// «сырой» `Map` (после выбора нового вида на common-info странице) — id
/// извлекаем из обеих форм.
AnimalEditSubmitInputs readToSubmitInputs(AnimalRead read) {
  final attributes = read.animalAttributes
      .map(
        (a) => domain.AnimalAttributeInput(
          attrId: a.attrId,
          name: a.name,
          value: a.value,
          isRequired: a.isRequired ?? false,
        ),
      )
      .toList();

  final retainImageIds = read.images.map((e) => e.id).nonNulls.toList();

  final animal = domain.Animal(
    id: read.id ?? 0,
    name: read.name ?? '',
    shelterId: read.shelter,
    status: domain.AnimalStatus.fromWire(read.status?.value),
    images: const [],
    attributes: const {},
    speciesId: _specIdOf(read.spec),
    birthDate: read.birthDate,
    dateJoined: read.dateJoined,
    dateOfChipping: read.dateOfChipping,
    chippingCode: read.chippingCode,
    height: read.height,
    weight: read.weight,
    placeOfCatch: read.placeOfCatch,
    placeOfRelease: read.placeOfRelease,
    curator: _contactFrom(read.curator?.id),
    applicant: _contactFrom(read.applicant?.id),
    canBeShared: read.canBeShared ?? false,
  );

  return AnimalEditSubmitInputs(
    animal: animal,
    attributes: attributes,
    newImages: const [],
    retainImageIds: retainImageIds,
    specId: _specIdOf(read.spec),
  );
}

/// Минимальный контакт-носитель только с id: репозиторий использует лишь
/// `curator?.id`/`applicant?.id` для write-DTO.
domain.AnimalContact? _contactFrom(int? id) {
  if (id == null) return null;
  return domain.AnimalContact(id: id, firstName: '', lastName: '');
}

/// id вида из `spec`: `Species` даёт `.id`, «сырой» `Map` — ключ `id`.
int? _specIdOf(dynamic spec) {
  if (spec == null) return null;
  if (spec is Species) return spec.id;
  if (spec is Map) {
    final id = spec['id'];
    return id is int ? id : (id is String ? int.tryParse(id) : null);
  }
  return null;
}
