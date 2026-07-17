// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'patched_user_change_password_serializers.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PatchedUserChangePasswordSerializers
_$PatchedUserChangePasswordSerializersFromJson(Map<String, dynamic> json) =>
    PatchedUserChangePasswordSerializers(
      id: (json['id'] as num?)?.toInt(),
      password: json['password'] as String?,
      rePassword: json['re_password'] as String?,
      oldPassword: json['old_password'] as String?,
    );

Map<String, dynamic> _$PatchedUserChangePasswordSerializersToJson(
  PatchedUserChangePasswordSerializers instance,
) => <String, dynamic>{
  'id': instance.id,
  'password': instance.password,
  're_password': instance.rePassword,
  'old_password': instance.oldPassword,
};
