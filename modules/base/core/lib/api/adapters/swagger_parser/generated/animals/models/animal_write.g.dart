// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'animal_write.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AnimalWrite _$AnimalWriteFromJson(Map<String, dynamic> json) {
  $checkKeys(
    json,
    requiredKeys: const [
      'spec_id',
      'date_joined',
      'place_of_catch',
      'shelter',
      'animal_attributes',
    ],
    disallowNullValues: const [
      'spec_id',
      'date_joined',
      'place_of_catch',
      'shelter',
      'animal_attributes',
    ],
  );
  return AnimalWrite(
    name: json['name'] as String?,
    images: (json['images'] as List<dynamic>?)
        ?.map((e) => AnimalImageWrite.fromJson(e as Map<String, dynamic>))
        .toList(),
    validImages: AnimalWrite._read_validImages(json['valid_images']),
    specId: AnimalWrite._read_specId(json['spec_id']),
    status: AnimalWrite._read_status(json['status']),
    dateJoined: AnimalWrite._read_dateJoined(json['date_joined']),
    birthDate: AnimalWrite._read_birthDate(json['birth_date']),
    deathDate: AnimalWrite._read_deathDate(json['death_date']),
    deathReason: json['death_reason'] as String?,
    defaultImageId: AnimalWrite._read_defaultImageId(json['default_image_id']),
    placeOfCatch: json['place_of_catch'] as String,
    placeOfRelease: json['place_of_release'] as String?,
    dateOfChipping: AnimalWrite._read_dateOfChipping(json['date_of_chipping']),
    chippingCode: json['chipping_code'] as String?,
    height: json['height'] as String?,
    weight: json['weight'] as String?,
    shelter: AnimalWrite._read_shelter(json['shelter']),
    curatorId: AnimalWrite._read_curatorId(json['curator_id']),
    applicantId: AnimalWrite._read_applicantId(json['applicant_id']),
    animalAttributes: (json['animal_attributes'] as List<dynamic>)
        .map((e) => AnimalAttributeValue.fromJson(e as Map<String, dynamic>))
        .toList(),
    canBeShared: json['can_be_shared'] as bool?,
    additionalProperties:
        AnimalWrite._extras(json, 'additionalProperties') == null
        ? const {}
        : AnimalWrite._readExtras(
            AnimalWrite._extras(json, 'additionalProperties'),
          ),
  );
}

Map<String, dynamic> _$AnimalWriteToJson(AnimalWrite instance) =>
    <String, dynamic>{
      'name': ?instance.name,
      'images': ?instance.images?.map((e) => e.toJson()).toList(),
      'valid_images': ?AnimalWrite._write_validImages(instance.validImages),
      'spec_id': ?AnimalWrite._write_specId(instance.specId),
      'status': ?AnimalWrite._write_status(instance.status),
      'date_joined': ?AnimalWrite._write_dateJoined(instance.dateJoined),
      'birth_date': ?AnimalWrite._write_birthDate(instance.birthDate),
      'death_date': ?AnimalWrite._write_deathDate(instance.deathDate),
      'death_reason': ?instance.deathReason,
      'default_image_id': ?AnimalWrite._write_defaultImageId(
        instance.defaultImageId,
      ),
      'place_of_catch': instance.placeOfCatch,
      'place_of_release': ?instance.placeOfRelease,
      'date_of_chipping': ?AnimalWrite._write_dateOfChipping(
        instance.dateOfChipping,
      ),
      'chipping_code': ?instance.chippingCode,
      'height': ?instance.height,
      'weight': ?instance.weight,
      'shelter': ?AnimalWrite._write_shelter(instance.shelter),
      'curator_id': ?AnimalWrite._write_curatorId(instance.curatorId),
      'applicant_id': ?AnimalWrite._write_applicantId(instance.applicantId),
      'animal_attributes': instance.animalAttributes
          .map((e) => e.toJson())
          .toList(),
      'can_be_shared': ?instance.canBeShared,
    };
