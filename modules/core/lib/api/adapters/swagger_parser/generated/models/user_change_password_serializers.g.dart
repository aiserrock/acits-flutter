// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_change_password_serializers.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserChangePasswordSerializers _$UserChangePasswordSerializersFromJson(
  Map<String, dynamic> json,
) => UserChangePasswordSerializers(
  id: (json['id'] as num).toInt(),
  password: json['password'] as String,
  rePassword: json['re_password'] as String,
  oldPassword: json['old_password'] as String,
);

Map<String, dynamic> _$UserChangePasswordSerializersToJson(
  UserChangePasswordSerializers instance,
) => <String, dynamic>{
  'id': instance.id,
  'password': instance.password,
  're_password': instance.rePassword,
  'old_password': instance.oldPassword,
};
