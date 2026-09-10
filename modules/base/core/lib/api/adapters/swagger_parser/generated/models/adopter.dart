// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:json_annotation/json_annotation.dart';

part 'adopter.g.dart';

/// Adopter serializer.
@JsonSerializable()
class Adopter {
  const Adopter({
    this.id,
    this.url,
    this.shelter,
    this.firstName,
    this.lastName,
    this.email,
    this.phoneNumber,
    this.address,
    this.createdBy,
    this.updatedBy,
    this.createdAt,
    this.updatedAt,
  });
  
  factory Adopter.fromJson(Map<String, Object?> json) => _$AdopterFromJson(json);
  
  final int? id;
  final String? url;
  final String? shelter;
  @JsonKey(name: 'first_name')
  final String? firstName;
  @JsonKey(name: 'last_name')
  final String? lastName;
  final String? email;
  @JsonKey(name: 'phone_number')
  final String? phoneNumber;
  final String? address;
  @JsonKey(name: 'created_by')
  final String? createdBy;
  @JsonKey(name: 'updated_by')
  final String? updatedBy;
  @JsonKey(name: 'created_at')
  final DateTime? createdAt;
  @JsonKey(name: 'updated_at')
  final DateTime? updatedAt;

  Map<String, Object?> toJson() => _$AdopterToJson(this);
}
