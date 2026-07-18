// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'animal_write.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AnimalWrite _$AnimalWriteFromJson(Map<String, dynamic> json) => AnimalWrite(
  specId: (json['spec_id'] as num).toInt(),
  dateJoined: DateTime.parse(json['date_joined'] as String),
  placeOfCatch: json['place_of_catch'] as String,
  shelter: (json['shelter'] as num).toInt(),
  animalAttributes: (json['animal_attributes'] as List<dynamic>)
      .map((e) => AnimalAttributeValue.fromJson(e as Map<String, dynamic>))
      .toList(),
  name: json['name'] as String?,
  images: (json['images'] as List<dynamic>?)
      ?.map((e) => AnimalImageWrite.fromJson(e as Map<String, dynamic>))
      .toList(),
  validImages: (json['valid_images'] as List<dynamic>?)
      ?.map((e) => (e as num).toInt())
      .toList(),
  status: json['status'] == null
      ? null
      : Status69fEnum.fromJson(json['status'] as String),
  birthDate: json['birth_date'] == null
      ? null
      : DateTime.parse(json['birth_date'] as String),
  deathDate: json['death_date'] == null
      ? null
      : DateTime.parse(json['death_date'] as String),
  deathReason: json['death_reason'] as String?,
  defaultImageId: (json['default_image_id'] as num?)?.toInt(),
  placeOfRelease: json['place_of_release'] as String?,
  dateOfChipping: json['date_of_chipping'] == null
      ? null
      : DateTime.parse(json['date_of_chipping'] as String),
  chippingCode: json['chipping_code'] as String?,
  height: json['height'] as String?,
  weight: json['weight'] as String?,
  curatorId: (json['curator_id'] as num?)?.toInt(),
  applicantId: (json['applicant_id'] as num?)?.toInt(),
  canBeShared: json['can_be_shared'] as bool?,
);

Map<String, dynamic> _$AnimalWriteToJson(AnimalWrite instance) =>
    <String, dynamic>{
      'name': instance.name,
      'images': instance.images,
      'valid_images': instance.validImages,
      'spec_id': instance.specId,
      'status': instance.status,
      'date_joined': instance.dateJoined.toIso8601String(),
      'birth_date': instance.birthDate?.toIso8601String(),
      'death_date': instance.deathDate?.toIso8601String(),
      'death_reason': instance.deathReason,
      'default_image_id': instance.defaultImageId,
      'place_of_catch': instance.placeOfCatch,
      'place_of_release': instance.placeOfRelease,
      'date_of_chipping': instance.dateOfChipping?.toIso8601String(),
      'chipping_code': instance.chippingCode,
      'height': instance.height,
      'weight': instance.weight,
      'shelter': instance.shelter,
      'curator_id': instance.curatorId,
      'applicant_id': instance.applicantId,
      'animal_attributes': instance.animalAttributes,
      'can_be_shared': instance.canBeShared,
    };
