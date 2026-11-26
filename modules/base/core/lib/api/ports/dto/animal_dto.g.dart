// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'animal_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AnimalDto _$AnimalDtoFromJson(Map<String, dynamic> json) => AnimalDto(
  id: (json['id'] as num).toInt(),
  uuid: json['uuid'] as String,
  url: json['url'] as String,
  images:
      (json['images'] as List<dynamic>?)
          ?.map((e) => AnimalImageDto.fromJson(e as Map<String, dynamic>))
          .toList() ??
      [],
  dateJoined: DateTime.parse(json['date_joined'] as String),
  placeOfCatch: json['place_of_catch'] as String,
  shelter: (json['shelter'] as num).toInt(),
  animalAttributes:
      (json['animal_attributes'] as List<dynamic>?)
          ?.map((e) => AnimalAttributeDto.fromJson(e as Map<String, dynamic>))
          .toList() ??
      [],
  name: json['name'] as String?,
  spec: json['spec'] == null
      ? null
      : SpeciesDto.fromJson(json['spec'] as Map<String, dynamic>),
  status: json['status'] as String?,
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
  hasDocuments: json['has_documents'] as bool?,
  curator: json['curator'] == null
      ? null
      : CuratorDto.fromJson(json['curator'] as Map<String, dynamic>),
  applicant: json['applicant'] == null
      ? null
      : ApplicantDto.fromJson(json['applicant'] as Map<String, dynamic>),
  deletedAt: json['deleted_at'] == null
      ? null
      : DateTime.parse(json['deleted_at'] as String),
  adoption: json['adoption'] as String?,
  release: json['release'] as String?,
  overstay: json['overstay'] as String?,
  canBeShared: json['can_be_shared'] as bool?,
);

Map<String, dynamic> _$AnimalDtoToJson(AnimalDto instance) => <String, dynamic>{
  'id': instance.id,
  'uuid': instance.uuid,
  'url': instance.url,
  'name': instance.name,
  'images': instance.images.map((e) => e.toJson()).toList(),
  'spec': instance.spec?.toJson(),
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
  'has_documents': instance.hasDocuments,
  'shelter': instance.shelter,
  'curator': instance.curator?.toJson(),
  'applicant': instance.applicant?.toJson(),
  'animal_attributes': instance.animalAttributes
      .map((e) => e.toJson())
      .toList(),
  'deleted_at': instance.deletedAt?.toIso8601String(),
  'adoption': instance.adoption,
  'release': instance.release,
  'overstay': instance.overstay,
  'can_be_shared': instance.canBeShared,
};
