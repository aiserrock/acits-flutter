// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:json_annotation/json_annotation.dart';

part 'user_current_shelter_serializers.g.dart';

/// User current shelter serializer.
@JsonSerializable()
class UserCurrentShelterSerializers {
  const UserCurrentShelterSerializers({
    this.currentShelter,
    this.currentShelterUserRole,
    this.isUserCanEdit,
    this.isUserCanDelete,
  });
  
  factory UserCurrentShelterSerializers.fromJson(Map<String, Object?> json) => _$UserCurrentShelterSerializersFromJson(json);
  
  @JsonKey(name: 'current_shelter')
  final int? currentShelter;
  @JsonKey(name: 'current_shelter_user_role')
  final String? currentShelterUserRole;
  @JsonKey(name: 'is_user_can_edit')
  final bool? isUserCanEdit;
  @JsonKey(name: 'is_user_can_delete')
  final bool? isUserCanDelete;

  Map<String, Object?> toJson() => _$UserCurrentShelterSerializersToJson(this);
}
