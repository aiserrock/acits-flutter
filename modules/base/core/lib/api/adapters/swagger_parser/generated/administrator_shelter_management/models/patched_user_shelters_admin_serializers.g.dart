// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'patched_user_shelters_admin_serializers.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PatchedUserSheltersAdminSerializers
_$PatchedUserSheltersAdminSerializersFromJson(Map<String, dynamic> json) {
  $checkKeys(json, disallowNullValues: const ['user']);
  return PatchedUserSheltersAdminSerializers(
    id: PatchedUserSheltersAdminSerializers._read_id(json['id']),
    user: json['user'] == null
        ? null
        : UserSerializers.fromJson(json['user'] as Map<String, dynamic>),
    userId: PatchedUserSheltersAdminSerializers._read_userId(json['user_id']),
    role: PatchedUserSheltersAdminSerializers._read_role(json['role']),
    isVerifiedByAdmin: json['is_verified_by_admin'] as bool?,
    additionalProperties:
        PatchedUserSheltersAdminSerializers._extras(
              json,
              'additionalProperties',
            ) ==
            null
        ? const {}
        : PatchedUserSheltersAdminSerializers._readExtras(
            PatchedUserSheltersAdminSerializers._extras(
              json,
              'additionalProperties',
            ),
          ),
  );
}

Map<String, dynamic> _$PatchedUserSheltersAdminSerializersToJson(
  PatchedUserSheltersAdminSerializers instance,
) => <String, dynamic>{
  'id': ?PatchedUserSheltersAdminSerializers._write_id(instance.id),
  'user': ?instance.user?.toJson(),
  'user_id': ?PatchedUserSheltersAdminSerializers._write_userId(
    instance.userId,
  ),
  'role': ?PatchedUserSheltersAdminSerializers._write_role(instance.role),
  'is_verified_by_admin': ?instance.isVerifiedByAdmin,
};
