// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:json_annotation/json_annotation.dart';

import 'shelter_serializers.dart';

part 'user_shelter_admin_serializers.g.dart';

/// User shelter admin serializer.
@JsonSerializable()
class UserShelterAdminSerializers {
  const UserShelterAdminSerializers({
    this.id,
    this.firstName,
    this.lastName,
    this.fathersName,
    this.email,
    this.phoneNumber,
    this.address,
    this.password,
    this.rePassword,
    this.isOfferSigned,
    this.shelter,
  });
  
  factory UserShelterAdminSerializers.fromJson(Map<String, Object?> json) => _$UserShelterAdminSerializersFromJson(json);
  
  final int? id;
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
  @JsonKey(name: 'is_offer_signed')
  final bool? isOfferSigned;
  final ShelterSerializers? shelter;

  Map<String, Object?> toJson() => _$UserShelterAdminSerializersToJson(this);
}
