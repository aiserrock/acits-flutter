// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'animal_read.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AnimalRead _$AnimalReadFromJson(Map<String, dynamic> json) {
  $checkKeys(json, disallowNullValues: const ['spec', 'curator', 'applicant']);
  return AnimalRead(
    id: AnimalRead._read_id(json['id']),
    uuid: json['uuid'] as String?,
    url: json['url'] as String?,
    name: json['name'] as String?,
    images: (json['images'] as List<dynamic>?)
        ?.map((e) => AnimalImageRead.fromJson(e as Map<String, dynamic>))
        .toList(),
    spec: json['spec'] == null
        ? null
        : Species.fromJson(json['spec'] as Map<String, dynamic>),
    status: AnimalRead._read_status(json['status']),
    dateJoined: AnimalRead._read_dateJoined(json['date_joined']),
    birthDate: AnimalRead._read_birthDate(json['birth_date']),
    deathDate: AnimalRead._read_deathDate(json['death_date']),
    deathReason: json['death_reason'] as String?,
    defaultImageId: AnimalRead._read_defaultImageId(json['default_image_id']),
    placeOfCatch: json['place_of_catch'] as String?,
    placeOfRelease: json['place_of_release'] as String?,
    dateOfChipping: AnimalRead._read_dateOfChipping(json['date_of_chipping']),
    chippingCode: json['chipping_code'] as String?,
    height: json['height'] as String?,
    weight: json['weight'] as String?,
    hasDocuments: json['has_documents'] as bool?,
    shelter: AnimalRead._read_shelter(json['shelter']),
    curator: json['curator'] == null
        ? null
        : Curator.fromJson(json['curator'] as Map<String, dynamic>),
    applicant: json['applicant'] == null
        ? null
        : Applicant.fromJson(json['applicant'] as Map<String, dynamic>),
    animalAttributes: (json['animal_attributes'] as List<dynamic>?)
        ?.map((e) => AnimalAttributeValue.fromJson(e as Map<String, dynamic>))
        .toList(),
    deletedAt: AnimalRead._read_deletedAt(json['deleted_at']),
    adoption: json['adoption'] as String?,
    release: json['release'] as String?,
    overstay: json['overstay'] as String?,
    canBeShared: json['can_be_shared'] as bool?,
    additionalProperties:
        AnimalRead._extras(json, 'additionalProperties') == null
        ? const {}
        : AnimalRead._readExtras(
            AnimalRead._extras(json, 'additionalProperties'),
          ),
  );
}

Map<String, dynamic> _$AnimalReadToJson(AnimalRead instance) =>
    <String, dynamic>{
      'id': ?AnimalRead._write_id(instance.id),
      'uuid': ?instance.uuid,
      'url': ?instance.url,
      'name': ?instance.name,
      'images': ?instance.images?.map((e) => e.toJson()).toList(),
      'spec': ?instance.spec?.toJson(),
      'status': ?AnimalRead._write_status(instance.status),
      'date_joined': ?AnimalRead._write_dateJoined(instance.dateJoined),
      'birth_date': ?AnimalRead._write_birthDate(instance.birthDate),
      'death_date': ?AnimalRead._write_deathDate(instance.deathDate),
      'death_reason': ?instance.deathReason,
      'default_image_id': ?AnimalRead._write_defaultImageId(
        instance.defaultImageId,
      ),
      'place_of_catch': ?instance.placeOfCatch,
      'place_of_release': ?instance.placeOfRelease,
      'date_of_chipping': ?AnimalRead._write_dateOfChipping(
        instance.dateOfChipping,
      ),
      'chipping_code': ?instance.chippingCode,
      'height': ?instance.height,
      'weight': ?instance.weight,
      'has_documents': ?instance.hasDocuments,
      'shelter': ?AnimalRead._write_shelter(instance.shelter),
      'curator': ?instance.curator?.toJson(),
      'applicant': ?instance.applicant?.toJson(),
      'animal_attributes': ?instance.animalAttributes
          ?.map((e) => e.toJson())
          .toList(),
      'deleted_at': ?AnimalRead._write_deletedAt(instance.deletedAt),
      'adoption': ?instance.adoption,
      'release': ?instance.release,
      'overstay': ?instance.overstay,
      'can_be_shared': ?instance.canBeShared,
    };
