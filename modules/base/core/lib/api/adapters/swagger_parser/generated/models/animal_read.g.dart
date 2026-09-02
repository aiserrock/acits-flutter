// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'animal_read.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AnimalRead _$AnimalReadFromJson(Map<String, dynamic> json) => AnimalRead(
  id: (json['id'] as num?)?.toInt(),
  uuid: json['uuid'] as String?,
  url: json['url'] as String?,
  name: json['name'] as String?,
  images: (json['images'] as List<dynamic>?)
      ?.map((e) => AnimalImageRead.fromJson(e as Map<String, dynamic>))
      .toList(),
  spec: json['spec'] == null
      ? null
      : Species.fromJson(json['spec'] as Map<String, dynamic>),
  status: json['status'] == null
      ? null
      : Status69fEnum.fromJson(json['status'] as String),
  dateJoined: json['date_joined'] == null
      ? null
      : DateTime.parse(json['date_joined'] as String),
  birthDate: json['birth_date'] == null
      ? null
      : DateTime.parse(json['birth_date'] as String),
  deathDate: json['death_date'] == null
      ? null
      : DateTime.parse(json['death_date'] as String),
  deathReason: json['death_reason'] as String?,
  defaultImageId: (json['default_image_id'] as num?)?.toInt(),
  placeOfCatch: json['place_of_catch'] as String?,
  placeOfRelease: json['place_of_release'] as String?,
  dateOfChipping: json['date_of_chipping'] == null
      ? null
      : DateTime.parse(json['date_of_chipping'] as String),
  chippingCode: json['chipping_code'] as String?,
  height: json['height'] as String?,
  weight: json['weight'] as String?,
  hasDocuments: json['has_documents'] as bool?,
  shelter: (json['shelter'] as num?)?.toInt(),
  curator: json['curator'] == null
      ? null
      : Curator.fromJson(json['curator'] as Map<String, dynamic>),
  applicant: json['applicant'] == null
      ? null
      : Applicant.fromJson(json['applicant'] as Map<String, dynamic>),
  animalAttributes: (json['animal_attributes'] as List<dynamic>?)
      ?.map((e) => AnimalAttributeValue.fromJson(e as Map<String, dynamic>))
      .toList(),
  deletedAt: json['deleted_at'] == null
      ? null
      : DateTime.parse(json['deleted_at'] as String),
  adoption: json['adoption'] as String?,
  release: json['release'] as String?,
  overstay: json['overstay'] as String?,
  canBeShared: json['can_be_shared'] as bool?,
);

Map<String, dynamic> _$AnimalReadToJson(AnimalRead instance) =>
    <String, dynamic>{
      'id': instance.id,
      'uuid': instance.uuid,
      'url': instance.url,
      'name': instance.name,
      'images': instance.images,
      'spec': instance.spec,
      'status': instance.status,
      'date_joined': instance.dateJoined?.toIso8601String(),
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
      'has_documents': instance.hasDocuments,
      'shelter': instance.shelter,
      'curator': instance.curator,
      'applicant': instance.applicant,
      'animal_attributes': instance.animalAttributes,
      'deleted_at': instance.deletedAt?.toIso8601String(),
      'adoption': instance.adoption,
      'release': instance.release,
      'overstay': instance.overstay,
      'can_be_shared': instance.canBeShared,
    };
