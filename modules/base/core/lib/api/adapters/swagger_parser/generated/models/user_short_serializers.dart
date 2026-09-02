// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:json_annotation/json_annotation.dart';

part 'user_short_serializers.g.dart';

/// Short serializer for User.
@JsonSerializable()
class UserShortSerializers {
  const UserShortSerializers({
    this.id,
    this.fullName,
    this.email,
    this.phoneNumber,
    this.address,
  });
  
  factory UserShortSerializers.fromJson(Map<String, Object?> json) => _$UserShortSerializersFromJson(json);
  
  final int? id;
  @JsonKey(name: 'full_name')
  final String? fullName;
  final String? email;
  @JsonKey(name: 'phone_number')
  final String? phoneNumber;
  final String? address;

  Map<String, Object?> toJson() => _$UserShortSerializersToJson(this);
}
