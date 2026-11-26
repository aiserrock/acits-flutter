// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'patched_applicant.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PatchedApplicant _$PatchedApplicantFromJson(Map<String, dynamic> json) =>
    PatchedApplicant(
      id: PatchedApplicant._read_id(json['id']),
      url: json['url'] as String?,
      shelter: PatchedApplicant._read_shelter(json['shelter']),
      firstName: json['first_name'] as String?,
      lastName: json['last_name'] as String?,
      email: json['email'] as String?,
      phoneNumber: json['phone_number'] as String?,
      contactDetails: json['contact_details'] as String?,
      createdBy: json['created_by'] as String?,
      updatedBy: json['updated_by'] as String?,
      createdAt: PatchedApplicant._read_createdAt(json['created_at']),
      updatedAt: PatchedApplicant._read_updatedAt(json['updated_at']),
      animalId: PatchedApplicant._read_animalId(json['animal_id']),
      applicantFiles: (json['applicant_files'] as List<dynamic>?)
          ?.map((e) => ApplicantFile.fromJson(e as Map<String, dynamic>))
          .toList(),
      additionalProperties:
          PatchedApplicant._extras(json, 'additionalProperties') == null
          ? const {}
          : PatchedApplicant._readExtras(
              PatchedApplicant._extras(json, 'additionalProperties'),
            ),
    );

Map<String, dynamic> _$PatchedApplicantToJson(
  PatchedApplicant instance,
) => <String, dynamic>{
  'id': ?PatchedApplicant._write_id(instance.id),
  'url': ?instance.url,
  'shelter': ?PatchedApplicant._write_shelter(instance.shelter),
  'first_name': ?instance.firstName,
  'last_name': ?instance.lastName,
  'email': ?instance.email,
  'phone_number': ?instance.phoneNumber,
  'contact_details': ?instance.contactDetails,
  'created_by': ?instance.createdBy,
  'updated_by': ?instance.updatedBy,
  'created_at': ?PatchedApplicant._write_createdAt(instance.createdAt),
  'updated_at': ?PatchedApplicant._write_updatedAt(instance.updatedAt),
  'animal_id': ?PatchedApplicant._write_animalId(instance.animalId),
  'applicant_files': ?instance.applicantFiles?.map((e) => e.toJson()).toList(),
};
