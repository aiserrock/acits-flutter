// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:json_annotation/json_annotation.dart';

part 'user_serializers.g.dart';

/// User serializer.
@JsonSerializable()
class UserSerializers {
  const UserSerializers({
    required this.id,
    required this.username,
    required this.firstName,
    required this.lastName,
    required this.fullName,
    required this.email,
    required this.dateJoined,
    required this.isVerified,
    this.fathersName,
    this.phoneNumber,
    this.address,
    this.isOfferSigned,
  });
  
  factory UserSerializers.fromJson(Map<String, Object?> json) => _$UserSerializersFromJson(json);
  
  final int id;

  /// Required. 150 characters or fewer. Letters, digits and @/./+/-/_ only.
  final String username;
  @JsonKey(name: 'first_name')
  final String firstName;
  @JsonKey(name: 'last_name')
  final String lastName;
  @JsonKey(name: 'fathers_name')
  final String? fathersName;
  @JsonKey(name: 'full_name')
  final String fullName;
  final String email;
  @JsonKey(name: 'phone_number')
  final String? phoneNumber;
  final String? address;
  @JsonKey(name: 'date_joined')
  final DateTime dateJoined;
  @JsonKey(name: 'is_verified')
  final bool isVerified;
  @JsonKey(name: 'is_offer_signed')
  final bool? isOfferSigned;

  Map<String, Object?> toJson() => _$UserSerializersToJson(this);
}
