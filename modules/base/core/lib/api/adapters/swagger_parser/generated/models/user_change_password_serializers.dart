// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:json_annotation/json_annotation.dart';

part 'user_change_password_serializers.g.dart';

/// User change password serializer.
@JsonSerializable()
class UserChangePasswordSerializers {
  const UserChangePasswordSerializers({
    this.id,
    this.password,
    this.rePassword,
    this.oldPassword,
  });
  
  factory UserChangePasswordSerializers.fromJson(Map<String, Object?> json) => _$UserChangePasswordSerializersFromJson(json);
  
  final int? id;
  final String? password;
  @JsonKey(name: 're_password')
  final String? rePassword;
  @JsonKey(name: 'old_password')
  final String? oldPassword;

  Map<String, Object?> toJson() => _$UserChangePasswordSerializersToJson(this);
}
