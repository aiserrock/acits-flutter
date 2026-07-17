// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:json_annotation/json_annotation.dart';

import 'applicant_file.dart';

part 'applicant.g.dart';

/// Applicant serializer.
@JsonSerializable()
class Applicant {
  const Applicant({
    required this.id,
    required this.url,
    required this.shelter,
    required this.firstName,
    required this.lastName,
    required this.phoneNumber,
    required this.createdBy,
    required this.updatedBy,
    required this.createdAt,
    required this.updatedAt,
    this.email,
    this.contactDetails,
    this.animalId,
    this.applicantFiles,
  });
  
  factory Applicant.fromJson(Map<String, Object?> json) => _$ApplicantFromJson(json);
  
  final int id;
  final String url;
  final int shelter;
  @JsonKey(name: 'first_name')
  final String firstName;
  @JsonKey(name: 'last_name')
  final String lastName;
  final String? email;
  @JsonKey(name: 'phone_number')
  final String phoneNumber;
  @JsonKey(name: 'contact_details')
  final String? contactDetails;
  @JsonKey(name: 'created_by')
  final String createdBy;
  @JsonKey(name: 'updated_by')
  final String updatedBy;
  @JsonKey(name: 'created_at')
  final DateTime createdAt;
  @JsonKey(name: 'updated_at')
  final DateTime updatedAt;
  @JsonKey(name: 'animal_id')
  final int? animalId;
  @JsonKey(name: 'applicant_files')
  final List<ApplicantFile>? applicantFiles;

  Map<String, Object?> toJson() => _$ApplicantToJson(this);
}
