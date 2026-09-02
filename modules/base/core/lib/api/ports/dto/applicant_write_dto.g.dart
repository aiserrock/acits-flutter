// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'applicant_write_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ApplicantWriteDto _$ApplicantWriteDtoFromJson(Map<String, dynamic> json) =>
    ApplicantWriteDto(
      firstName: json['first_name'] as String,
      lastName: json['last_name'] as String,
      phoneNumber: json['phone_number'] as String,
      id: (json['id'] as num?)?.toInt(),
      shelter: (json['shelter'] as num?)?.toInt(),
      email: json['email'] as String?,
      contactDetails: json['contact_details'] as String?,
    );

Map<String, dynamic> _$ApplicantWriteDtoToJson(ApplicantWriteDto instance) =>
    <String, dynamic>{
      'id': ?instance.id,
      'shelter': ?instance.shelter,
      'first_name': instance.firstName,
      'last_name': instance.lastName,
      'email': ?instance.email,
      'phone_number': instance.phoneNumber,
      'contact_details': ?instance.contactDetails,
    };
