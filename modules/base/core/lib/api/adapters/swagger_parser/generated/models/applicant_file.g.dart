// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'applicant_file.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ApplicantFile _$ApplicantFileFromJson(Map<String, dynamic> json) =>
    ApplicantFile(
      id: (json['id'] as num?)?.toInt(),
      file: json['file'] as String?,
      name: json['name'] as String?,
      filename: json['filename'] as String?,
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
    );

Map<String, dynamic> _$ApplicantFileToJson(ApplicantFile instance) =>
    <String, dynamic>{
      'id': instance.id,
      'file': instance.file,
      'name': instance.name,
      'filename': instance.filename,
      'created_at': instance.createdAt?.toIso8601String(),
    };
