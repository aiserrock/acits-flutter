// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'prescription_file.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PrescriptionFile _$PrescriptionFileFromJson(Map<String, dynamic> json) =>
    PrescriptionFile(
      id: PrescriptionFile._read_id(json['id']),
      file: json['file'] as String?,
      name: json['name'] as String?,
      filename: json['filename'] as String?,
      createdAt: PrescriptionFile._read_createdAt(json['created_at']),
      additionalProperties:
          PrescriptionFile._extras(json, 'additionalProperties') == null
          ? const {}
          : PrescriptionFile._readExtras(
              PrescriptionFile._extras(json, 'additionalProperties'),
            ),
    );

Map<String, dynamic> _$PrescriptionFileToJson(PrescriptionFile instance) =>
    <String, dynamic>{
      'id': ?PrescriptionFile._write_id(instance.id),
      'file': ?instance.file,
      'name': ?instance.name,
      'filename': ?instance.filename,
      'created_at': ?PrescriptionFile._write_createdAt(instance.createdAt),
    };
