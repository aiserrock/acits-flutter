// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:json_annotation/json_annotation.dart';

import 'role_enum.dart';

part 'user_shelter_worker_serializers.g.dart';

/// User shelter worker serializer.
@JsonSerializable()
class UserShelterWorkerSerializers {
  const UserShelterWorkerSerializers({
    this.firstName,
    this.lastName,
    this.fathersName,
    this.email,
    this.phoneNumber,
    this.address,
    this.password,
    this.rePassword,
    this.shelter,
    this.role,
    this.isOfferSigned,
  });
  
  factory UserShelterWorkerSerializers.fromJson(Map<String, Object?> json) => _$UserShelterWorkerSerializersFromJson(json);
  
  @JsonKey(name: 'first_name')
  final String? firstName;
  @JsonKey(name: 'last_name')
  final String? lastName;
  @JsonKey(name: 'fathers_name')
  final String? fathersName;
  final String? email;
  @JsonKey(name: 'phone_number')
  final String? phoneNumber;
  final String? address;
  final String? password;
  @JsonKey(name: 're_password')
  final String? rePassword;
  final int? shelter;
  final RoleEnum? role;
  @JsonKey(name: 'is_offer_signed')
  final bool? isOfferSigned;

  Map<String, Object?> toJson() => _$UserShelterWorkerSerializersToJson(this);
}
