// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'patched_user_shelters_admin_serializers.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PatchedUserSheltersAdminSerializers
_$PatchedUserSheltersAdminSerializersFromJson(Map<String, dynamic> json) =>
    PatchedUserSheltersAdminSerializers(
      id: (json['id'] as num).toInt(),
      user: UserSerializers.fromJson(json['user'] as Map<String, dynamic>),
      userId: (json['user_id'] as num).toInt(),
      role: RoleEnum.fromJson(json['role'] as String),
      isVerifiedByAdmin: json['is_verified_by_admin'] as bool,
    );

Map<String, dynamic> _$PatchedUserSheltersAdminSerializersToJson(
  PatchedUserSheltersAdminSerializers instance,
) => <String, dynamic>{
  'id': instance.id,
  'user': instance.user,
  'user_id': instance.userId,
  'role': instance.role,
  'is_verified_by_admin': instance.isVerifiedByAdmin,
};
