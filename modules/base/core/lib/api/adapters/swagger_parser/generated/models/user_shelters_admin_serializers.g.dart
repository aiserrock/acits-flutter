// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_shelters_admin_serializers.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserSheltersAdminSerializers _$UserSheltersAdminSerializersFromJson(
  Map<String, dynamic> json,
) => UserSheltersAdminSerializers(
  id: (json['id'] as num?)?.toInt(),
  user: json['user'] == null
      ? null
      : UserSerializers.fromJson(json['user'] as Map<String, dynamic>),
  userId: (json['user_id'] as num?)?.toInt(),
  role: json['role'] == null ? null : RoleEnum.fromJson(json['role'] as String),
  isVerifiedByAdmin: json['is_verified_by_admin'] as bool?,
);

Map<String, dynamic> _$UserSheltersAdminSerializersToJson(
  UserSheltersAdminSerializers instance,
) => <String, dynamic>{
  'id': instance.id,
  'user': instance.user,
  'user_id': instance.userId,
  'role': instance.role,
  'is_verified_by_admin': instance.isVerifiedByAdmin,
};
