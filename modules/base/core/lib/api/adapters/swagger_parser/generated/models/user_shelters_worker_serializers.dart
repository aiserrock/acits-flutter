// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:json_annotation/json_annotation.dart';

import 'role_enum.dart';

part 'user_shelters_worker_serializers.g.dart';

/// UserShelters serializer for worker.
@JsonSerializable()
class UserSheltersWorkerSerializers {
  const UserSheltersWorkerSerializers({
    required this.shelter,
    required this.role,
  });
  
  factory UserSheltersWorkerSerializers.fromJson(Map<String, Object?> json) => _$UserSheltersWorkerSerializersFromJson(json);
  
  final int shelter;
  final RoleEnum role;

  Map<String, Object?> toJson() => _$UserSheltersWorkerSerializersToJson(this);
}
