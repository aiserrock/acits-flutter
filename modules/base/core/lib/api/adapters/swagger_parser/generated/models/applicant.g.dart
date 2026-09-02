// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'applicant.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Applicant _$ApplicantFromJson(Map<String, dynamic> json) => Applicant(
  id: (json['id'] as num?)?.toInt(),
  url: json['url'] as String?,
  shelter: (json['shelter'] as num?)?.toInt(),
  firstName: json['first_name'] as String?,
  lastName: json['last_name'] as String?,
  email: json['email'] as String?,
  phoneNumber: json['phone_number'] as String?,
  contactDetails: json['contact_details'] as String?,
  createdBy: json['created_by'] as String?,
  updatedBy: json['updated_by'] as String?,
  createdAt: json['created_at'] == null
      ? null
      : DateTime.parse(json['created_at'] as String),
  updatedAt: json['updated_at'] == null
      ? null
      : DateTime.parse(json['updated_at'] as String),
  animalId: (json['animal_id'] as num?)?.toInt(),
  applicantFiles: (json['applicant_files'] as List<dynamic>?)
      ?.map((e) => ApplicantFile.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$ApplicantToJson(Applicant instance) => <String, dynamic>{
  'id': instance.id,
  'url': instance.url,
  'shelter': instance.shelter,
  'first_name': instance.firstName,
  'last_name': instance.lastName,
  'email': instance.email,
  'phone_number': instance.phoneNumber,
  'contact_details': instance.contactDetails,
  'created_by': instance.createdBy,
  'updated_by': instance.updatedBy,
  'created_at': instance.createdAt?.toIso8601String(),
  'updated_at': instance.updatedAt?.toIso8601String(),
  'animal_id': instance.animalId,
  'applicant_files': instance.applicantFiles,
};
