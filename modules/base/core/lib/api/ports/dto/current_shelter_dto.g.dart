// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'current_shelter_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CurrentShelterDto _$CurrentShelterDtoFromJson(Map<String, dynamic> json) =>
    CurrentShelterDto(
      currentShelter: (json['current_shelter'] as num).toInt(),
      currentShelterUserRole: json['current_shelter_user_role'] as String,
      isUserCanEdit: json['is_user_can_edit'] as bool,
      isUserCanDelete: json['is_user_can_delete'] as bool,
    );

Map<String, dynamic> _$CurrentShelterDtoToJson(CurrentShelterDto instance) =>
    <String, dynamic>{
      'current_shelter': instance.currentShelter,
      'current_shelter_user_role': instance.currentShelterUserRole,
      'is_user_can_edit': instance.isUserCanEdit,
      'is_user_can_delete': instance.isUserCanDelete,
    };
