// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_change_password_serializers.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserChangePasswordSerializers _$UserChangePasswordSerializersFromJson(
  Map<String, dynamic> json,
) => UserChangePasswordSerializers(
  id: UserChangePasswordSerializers._read_id(json['id']),
  password: json['password'] as String?,
  rePassword: json['re_password'] as String?,
  oldPassword: json['old_password'] as String?,
  additionalProperties:
      UserChangePasswordSerializers._extras(json, 'additionalProperties') ==
          null
      ? const {}
      : UserChangePasswordSerializers._readExtras(
          UserChangePasswordSerializers._extras(json, 'additionalProperties'),
        ),
);

Map<String, dynamic> _$UserChangePasswordSerializersToJson(
  UserChangePasswordSerializers instance,
) => <String, dynamic>{
  'id': ?UserChangePasswordSerializers._write_id(instance.id),
  'password': ?instance.password,
  're_password': ?instance.rePassword,
  'old_password': ?instance.oldPassword,
};
