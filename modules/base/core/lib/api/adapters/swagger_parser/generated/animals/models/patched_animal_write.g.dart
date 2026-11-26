// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'patched_animal_write.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PatchedAnimalWrite _$PatchedAnimalWriteFromJson(Map<String, dynamic> json) =>
    PatchedAnimalWrite(
      name: json['name'] as String?,
      images: (json['images'] as List<dynamic>?)
          ?.map((e) => AnimalImageWrite.fromJson(e as Map<String, dynamic>))
          .toList(),
      validImages: PatchedAnimalWrite._read_validImages(json['valid_images']),
      specId: PatchedAnimalWrite._read_specId(json['spec_id']),
      status: PatchedAnimalWrite._read_status(json['status']),
      dateJoined: PatchedAnimalWrite._read_dateJoined(json['date_joined']),
      birthDate: PatchedAnimalWrite._read_birthDate(json['birth_date']),
      deathDate: PatchedAnimalWrite._read_deathDate(json['death_date']),
      deathReason: json['death_reason'] as String?,
      defaultImageId: PatchedAnimalWrite._read_defaultImageId(
        json['default_image_id'],
      ),
      placeOfCatch: json['place_of_catch'] as String?,
      placeOfRelease: json['place_of_release'] as String?,
      dateOfChipping: PatchedAnimalWrite._read_dateOfChipping(
        json['date_of_chipping'],
      ),
      chippingCode: json['chipping_code'] as String?,
      height: json['height'] as String?,
      weight: json['weight'] as String?,
      shelter: PatchedAnimalWrite._read_shelter(json['shelter']),
      curatorId: PatchedAnimalWrite._read_curatorId(json['curator_id']),
      applicantId: PatchedAnimalWrite._read_applicantId(json['applicant_id']),
      animalAttributes: (json['animal_attributes'] as List<dynamic>?)
          ?.map((e) => AnimalAttributeValue.fromJson(e as Map<String, dynamic>))
          .toList(),
      canBeShared: json['can_be_shared'] as bool?,
      additionalProperties:
          PatchedAnimalWrite._extras(json, 'additionalProperties') == null
          ? const {}
          : PatchedAnimalWrite._readExtras(
              PatchedAnimalWrite._extras(json, 'additionalProperties'),
            ),
    );

Map<String, dynamic> _$PatchedAnimalWriteToJson(
  PatchedAnimalWrite instance,
) => <String, dynamic>{
  'name': ?instance.name,
  'images': ?instance.images?.map((e) => e.toJson()).toList(),
  'valid_images': ?PatchedAnimalWrite._write_validImages(instance.validImages),
  'spec_id': ?PatchedAnimalWrite._write_specId(instance.specId),
  'status': ?PatchedAnimalWrite._write_status(instance.status),
  'date_joined': ?PatchedAnimalWrite._write_dateJoined(instance.dateJoined),
  'birth_date': ?PatchedAnimalWrite._write_birthDate(instance.birthDate),
  'death_date': ?PatchedAnimalWrite._write_deathDate(instance.deathDate),
  'death_reason': ?instance.deathReason,
  'default_image_id': ?PatchedAnimalWrite._write_defaultImageId(
    instance.defaultImageId,
  ),
  'place_of_catch': ?instance.placeOfCatch,
  'place_of_release': ?instance.placeOfRelease,
  'date_of_chipping': ?PatchedAnimalWrite._write_dateOfChipping(
    instance.dateOfChipping,
  ),
  'chipping_code': ?instance.chippingCode,
  'height': ?instance.height,
  'weight': ?instance.weight,
  'shelter': ?PatchedAnimalWrite._write_shelter(instance.shelter),
  'curator_id': ?PatchedAnimalWrite._write_curatorId(instance.curatorId),
  'applicant_id': ?PatchedAnimalWrite._write_applicantId(instance.applicantId),
  'animal_attributes': ?instance.animalAttributes
      ?.map((e) => e.toJson())
      .toList(),
  'can_be_shared': ?instance.canBeShared,
};
