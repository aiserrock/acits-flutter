// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'animal_short_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AnimalShortDto _$AnimalShortDtoFromJson(Map<String, dynamic> json) =>
    AnimalShortDto(
      id: (json['id'] as num).toInt(),
      uuid: json['uuid'] as String,
      specName: json['spec_name'] as String,
      name: json['name'] as String?,
      specParentName: json['spec_parent_name'] as String?,
      avatar: json['avatar'] as String?,
      defaultImageId: (json['default_image_id'] as num?)?.toInt(),
    );

Map<String, dynamic> _$AnimalShortDtoToJson(AnimalShortDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'uuid': instance.uuid,
      'name': instance.name,
      'spec_name': instance.specName,
      'spec_parent_name': instance.specParentName,
      'avatar': instance.avatar,
      'default_image_id': instance.defaultImageId,
    };
