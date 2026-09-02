// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:json_annotation/json_annotation.dart';

import 'animal_short.dart';
import 'prescription_drug.dart';
import 'prescription_file.dart';
import 'prescription_short_my_type_enum.dart';

part 'prescription_short.g.dart';

/// PrescriptionShort serializer.
@JsonSerializable()
class PrescriptionShort {
  const PrescriptionShort({
    this.id,
    this.myType,
    this.extraTypeAttributes,
    this.description,
    this.animal,
    this.drugs,
    this.createdBy,
    this.updatedBy,
    this.files,
  });
  
  factory PrescriptionShort.fromJson(Map<String, Object?> json) => _$PrescriptionShortFromJson(json);
  
  final int? id;
  @JsonKey(name: 'my_type')
  final PrescriptionShortMyTypeEnum? myType;
  @JsonKey(name: 'extra_type_attributes')
  final dynamic extraTypeAttributes;
  final String? description;
  final AnimalShort? animal;
  final List<PrescriptionDrug>? drugs;
  @JsonKey(name: 'created_by')
  final String? createdBy;
  @JsonKey(name: 'updated_by')
  final String? updatedBy;
  final List<PrescriptionFile>? files;

  Map<String, Object?> toJson() => _$PrescriptionShortToJson(this);
}
