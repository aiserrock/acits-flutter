// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:json_annotation/json_annotation.dart';

import 'role_enum.dart';
import 'user_serializers.dart';

part 'user_shelters_admin_serializers.g.dart';

/// UserShelters serializer for admin.
@JsonSerializable()
class UserSheltersAdminSerializers {
  const UserSheltersAdminSerializers({
    this.id,
    this.user,
    this.userId,
    this.role,
    this.isVerifiedByAdmin,
  });
  
  factory UserSheltersAdminSerializers.fromJson(Map<String, Object?> json) => _$UserSheltersAdminSerializersFromJson(json);
  
  final int? id;
  final UserSerializers? user;
  @JsonKey(name: 'user_id')
  final int? userId;
  final RoleEnum? role;
  @JsonKey(name: 'is_verified_by_admin')
  final bool? isVerifiedByAdmin;

  Map<String, Object?> toJson() => _$UserSheltersAdminSerializersToJson(this);
}
