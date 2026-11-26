// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'applicant.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Applicant _$ApplicantFromJson(Map<String, dynamic> json) => Applicant(
  id: Applicant._read_id(json['id']),
  url: json['url'] as String?,
  shelter: Applicant._read_shelter(json['shelter']),
  firstName: json['first_name'] as String?,
  lastName: json['last_name'] as String?,
  email: json['email'] as String?,
  phoneNumber: json['phone_number'] as String?,
  contactDetails: json['contact_details'] as String?,
  createdBy: json['created_by'] as String?,
  updatedBy: json['updated_by'] as String?,
  createdAt: Applicant._read_createdAt(json['created_at']),
  updatedAt: Applicant._read_updatedAt(json['updated_at']),
  animalId: Applicant._read_animalId(json['animal_id']),
  applicantFiles: (json['applicant_files'] as List<dynamic>?)
      ?.map((e) => ApplicantFile.fromJson(e as Map<String, dynamic>))
      .toList(),
  additionalProperties: Applicant._extras(json, 'additionalProperties') == null
      ? const {}
      : Applicant._readExtras(Applicant._extras(json, 'additionalProperties')),
);

Map<String, dynamic> _$ApplicantToJson(Applicant instance) => <String, dynamic>{
  'id': ?Applicant._write_id(instance.id),
  'url': ?instance.url,
  'shelter': ?Applicant._write_shelter(instance.shelter),
  'first_name': ?instance.firstName,
  'last_name': ?instance.lastName,
  'email': ?instance.email,
  'phone_number': ?instance.phoneNumber,
  'contact_details': ?instance.contactDetails,
  'created_by': ?instance.createdBy,
  'updated_by': ?instance.updatedBy,
  'created_at': ?Applicant._write_createdAt(instance.createdAt),
  'updated_at': ?Applicant._write_updatedAt(instance.updatedAt),
  'animal_id': ?Applicant._write_animalId(instance.animalId),
  'applicant_files': ?instance.applicantFiles?.map((e) => e.toJson()).toList(),
};
