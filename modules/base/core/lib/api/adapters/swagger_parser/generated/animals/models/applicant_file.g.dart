// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'applicant_file.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ApplicantFile _$ApplicantFileFromJson(Map<String, dynamic> json) =>
    ApplicantFile(
      id: ApplicantFile._read_id(json['id']),
      file: json['file'] as String?,
      name: json['name'] as String?,
      filename: json['filename'] as String?,
      createdAt: ApplicantFile._read_createdAt(json['created_at']),
      additionalProperties:
          ApplicantFile._extras(json, 'additionalProperties') == null
          ? const {}
          : ApplicantFile._readExtras(
              ApplicantFile._extras(json, 'additionalProperties'),
            ),
    );

Map<String, dynamic> _$ApplicantFileToJson(ApplicantFile instance) =>
    <String, dynamic>{
      'id': ?ApplicantFile._write_id(instance.id),
      'file': ?instance.file,
      'name': ?instance.name,
      'filename': ?instance.filename,
      'created_at': ?ApplicantFile._write_createdAt(instance.createdAt),
    };
