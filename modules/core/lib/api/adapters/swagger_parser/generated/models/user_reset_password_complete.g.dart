// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_reset_password_complete.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserResetPasswordComplete _$UserResetPasswordCompleteFromJson(
  Map<String, dynamic> json,
) => UserResetPasswordComplete(
  uidb64: json['uidb64'] as String,
  token: json['token'] as String,
  newPassword: json['new_password'] as String,
);

Map<String, dynamic> _$UserResetPasswordCompleteToJson(
  UserResetPasswordComplete instance,
) => <String, dynamic>{
  'uidb64': instance.uidb64,
  'token': instance.token,
  'new_password': instance.newPassword,
};
