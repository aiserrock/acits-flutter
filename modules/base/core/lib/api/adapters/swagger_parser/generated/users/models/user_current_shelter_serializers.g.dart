// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_current_shelter_serializers.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserCurrentShelterSerializers _$UserCurrentShelterSerializersFromJson(
  Map<String, dynamic> json,
) => UserCurrentShelterSerializers(
  currentShelter: UserCurrentShelterSerializers._read_currentShelter(
    json['current_shelter'],
  ),
  currentShelterUserRole: json['current_shelter_user_role'] as String?,
  isUserCanEdit: json['is_user_can_edit'] as bool?,
  isUserCanDelete: json['is_user_can_delete'] as bool?,
  additionalProperties:
      UserCurrentShelterSerializers._extras(json, 'additionalProperties') ==
          null
      ? const {}
      : UserCurrentShelterSerializers._readExtras(
          UserCurrentShelterSerializers._extras(json, 'additionalProperties'),
        ),
);

Map<String, dynamic> _$UserCurrentShelterSerializersToJson(
  UserCurrentShelterSerializers instance,
) => <String, dynamic>{
  'current_shelter': ?UserCurrentShelterSerializers._write_currentShelter(
    instance.currentShelter,
  ),
  'current_shelter_user_role': ?instance.currentShelterUserRole,
  'is_user_can_edit': ?instance.isUserCanEdit,
  'is_user_can_delete': ?instance.isUserCanDelete,
};
