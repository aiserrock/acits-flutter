// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'prescription_short.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PrescriptionShort _$PrescriptionShortFromJson(Map<String, dynamic> json) =>
    PrescriptionShort(
      id: (json['id'] as num).toInt(),
      animal: AnimalShort.fromJson(json['animal'] as Map<String, dynamic>),
      drugs: (json['drugs'] as List<dynamic>)
          .map((e) => PrescriptionDrug.fromJson(e as Map<String, dynamic>))
          .toList(),
      createdBy: json['created_by'] as String,
      updatedBy: json['updated_by'] as String,
      myType: json['my_type'] == null
          ? null
          : PrescriptionShortMyTypeEnum.fromJson(json['my_type'] as String),
      extraTypeAttributes: json['extra_type_attributes'],
      description: json['description'] as String?,
      files: (json['files'] as List<dynamic>?)
          ?.map((e) => PrescriptionFile.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$PrescriptionShortToJson(PrescriptionShort instance) =>
    <String, dynamic>{
      'id': instance.id,
      'my_type': instance.myType,
      'extra_type_attributes': instance.extraTypeAttributes,
      'description': instance.description,
      'animal': instance.animal,
      'drugs': instance.drugs,
      'created_by': instance.createdBy,
      'updated_by': instance.updatedBy,
      'files': instance.files,
    };
