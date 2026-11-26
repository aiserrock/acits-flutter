// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_shelters_admin_serializers.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserSheltersAdminSerializers _$UserSheltersAdminSerializersFromJson(
  Map<String, dynamic> json,
) {
  $checkKeys(json, disallowNullValues: const ['user']);
  return UserSheltersAdminSerializers(
    id: UserSheltersAdminSerializers._read_id(json['id']),
    user: json['user'] == null
        ? null
        : UserSerializers.fromJson(json['user'] as Map<String, dynamic>),
    userId: UserSheltersAdminSerializers._read_userId(json['user_id']),
    role: UserSheltersAdminSerializers._read_role(json['role']),
    isVerifiedByAdmin: json['is_verified_by_admin'] as bool?,
    additionalProperties:
        UserSheltersAdminSerializers._extras(json, 'additionalProperties') ==
            null
        ? const {}
        : UserSheltersAdminSerializers._readExtras(
            UserSheltersAdminSerializers._extras(json, 'additionalProperties'),
          ),
  );
}

Map<String, dynamic> _$UserSheltersAdminSerializersToJson(
  UserSheltersAdminSerializers instance,
) => <String, dynamic>{
  'id': ?UserSheltersAdminSerializers._write_id(instance.id),
  'user': ?instance.user?.toJson(),
  'user_id': ?UserSheltersAdminSerializers._write_userId(instance.userId),
  'role': ?UserSheltersAdminSerializers._write_role(instance.role),
  'is_verified_by_admin': ?instance.isVerifiedByAdmin,
};
