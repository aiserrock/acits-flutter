// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'prescription_file_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PrescriptionFileDto _$PrescriptionFileDtoFromJson(Map<String, dynamic> json) => PrescriptionFileDto(
  file: json['file'] as String,
  id: (json['id'] as num?)?.toInt(),
  name: json['name'] as String?,
  filename: json['filename'] as String?,
  createdAt: json['created_at'] == null ? null : DateTime.parse(json['created_at'] as String),
);

Map<String, dynamic> _$PrescriptionFileDtoToJson(PrescriptionFileDto instance) => <String, dynamic>{
  'id': instance.id,
  'file': instance.file,
  'name': instance.name,
  'filename': instance.filename,
  'created_at': instance.createdAt?.toIso8601String(),
};
