// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:json_annotation/json_annotation.dart';

part 'user_reset_password_complete.g.dart';

/// A serializer for completing password reset.
@JsonSerializable()
class UserResetPasswordComplete {
  const UserResetPasswordComplete({
    required this.uidb64,
    required this.token,
    required this.newPassword,
  });
  
  factory UserResetPasswordComplete.fromJson(Map<String, Object?> json) => _$UserResetPasswordCompleteFromJson(json);
  
  final String uidb64;
  final String token;
  @JsonKey(name: 'new_password')
  final String newPassword;

  Map<String, Object?> toJson() => _$UserResetPasswordCompleteToJson(this);
}
