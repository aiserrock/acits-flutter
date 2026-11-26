// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'patched_user_change_password_serializers.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PatchedUserChangePasswordSerializers
_$PatchedUserChangePasswordSerializersFromJson(Map<String, dynamic> json) =>
    PatchedUserChangePasswordSerializers(
      id: PatchedUserChangePasswordSerializers._read_id(json['id']),
      password: json['password'] as String?,
      rePassword: json['re_password'] as String?,
      oldPassword: json['old_password'] as String?,
      additionalProperties:
          PatchedUserChangePasswordSerializers._extras(
                json,
                'additionalProperties',
              ) ==
              null
          ? const {}
          : PatchedUserChangePasswordSerializers._readExtras(
              PatchedUserChangePasswordSerializers._extras(
                json,
                'additionalProperties',
              ),
            ),
    );

Map<String, dynamic> _$PatchedUserChangePasswordSerializersToJson(
  PatchedUserChangePasswordSerializers instance,
) => <String, dynamic>{
  'id': ?PatchedUserChangePasswordSerializers._write_id(instance.id),
  'password': ?instance.password,
  're_password': ?instance.rePassword,
  'old_password': ?instance.oldPassword,
};
