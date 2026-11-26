// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'prescription_short.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PrescriptionShort _$PrescriptionShortFromJson(Map<String, dynamic> json) {
  $checkKeys(json, disallowNullValues: const ['animal']);
  return PrescriptionShort(
    id: PrescriptionShort._read_id(json['id']),
    myType: PrescriptionShort._read_myType(json['my_type']),
    extraTypeAttributes: json['extra_type_attributes'],
    description: json['description'] as String?,
    animal: json['animal'] == null
        ? null
        : AnimalShort.fromJson(json['animal'] as Map<String, dynamic>),
    drugs: (json['drugs'] as List<dynamic>?)
        ?.map((e) => PrescriptionDrug.fromJson(e as Map<String, dynamic>))
        .toList(),
    createdBy: json['created_by'] as String?,
    updatedBy: json['updated_by'] as String?,
    files: (json['files'] as List<dynamic>?)
        ?.map((e) => PrescriptionFile.fromJson(e as Map<String, dynamic>))
        .toList(),
    additionalProperties:
        PrescriptionShort._extras(json, 'additionalProperties') == null
        ? const {}
        : PrescriptionShort._readExtras(
            PrescriptionShort._extras(json, 'additionalProperties'),
          ),
  );
}

Map<String, dynamic> _$PrescriptionShortToJson(PrescriptionShort instance) =>
    <String, dynamic>{
      'id': ?PrescriptionShort._write_id(instance.id),
      'my_type': ?PrescriptionShort._write_myType(instance.myType),
      'extra_type_attributes': ?instance.extraTypeAttributes,
      'description': ?instance.description,
      'animal': ?instance.animal?.toJson(),
      'drugs': ?instance.drugs?.map((e) => e.toJson()).toList(),
      'created_by': ?instance.createdBy,
      'updated_by': ?instance.updatedBy,
      'files': ?instance.files?.map((e) => e.toJson()).toList(),
    };
