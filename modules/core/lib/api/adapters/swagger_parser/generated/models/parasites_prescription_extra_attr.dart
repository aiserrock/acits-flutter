// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:json_annotation/json_annotation.dart';

import 'parasites_type_enum.dart';

part 'parasites_prescription_extra_attr.g.dart';

/// Serializer for extra attributes passed for prescriptions.
/// with ParasitesTreatment type. Validated data stored as JSON then.
@JsonSerializable()
class ParasitesPrescriptionExtraAttr {
  const ParasitesPrescriptionExtraAttr({
    this.reaction = '',
    this.parasitesType,
  });
  
  factory ParasitesPrescriptionExtraAttr.fromJson(Map<String, Object?> json) => _$ParasitesPrescriptionExtraAttrFromJson(json);
  
  @JsonKey(name: 'parasites_type')
  final ParasitesTypeEnum? parasitesType;
  final String reaction;

  Map<String, Object?> toJson() => _$ParasitesPrescriptionExtraAttrToJson(this);
}
