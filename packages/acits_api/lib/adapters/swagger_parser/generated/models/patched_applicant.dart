// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:json_annotation/json_annotation.dart';

import 'applicant_file.dart';

part 'patched_applicant.g.dart';

/// Applicant serializer.
@JsonSerializable()
class PatchedApplicant {
  const PatchedApplicant({
    this.id,
    this.url,
    this.shelter,
    this.firstName,
    this.lastName,
    this.email,
    this.phoneNumber,
    this.contactDetails,
    this.createdBy,
    this.updatedBy,
    this.createdAt,
    this.updatedAt,
    this.animalId,
    this.applicantFiles,
  });
  
  factory PatchedApplicant.fromJson(Map<String, Object?> json) => _$PatchedApplicantFromJson(json);
  
  final int? id;
  final String? url;
  final int? shelter;
  @JsonKey(name: 'first_name')
  final String? firstName;
  @JsonKey(name: 'last_name')
  final String? lastName;
  final String? email;
  @JsonKey(name: 'phone_number')
  final String? phoneNumber;
  @JsonKey(name: 'contact_details')
  final String? contactDetails;
  @JsonKey(name: 'created_by')
  final String? createdBy;
  @JsonKey(name: 'updated_by')
  final String? updatedBy;
  @JsonKey(name: 'created_at')
  final DateTime? createdAt;
  @JsonKey(name: 'updated_at')
  final DateTime? updatedAt;
  @JsonKey(name: 'animal_id')
  final int? animalId;
  @JsonKey(name: 'applicant_files')
  final List<ApplicantFile>? applicantFiles;

  Map<String, Object?> toJson() => _$PatchedApplicantToJson(this);
}
