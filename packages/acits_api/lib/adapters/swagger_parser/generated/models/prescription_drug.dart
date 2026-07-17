// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:json_annotation/json_annotation.dart';

part 'prescription_drug.g.dart';

/// PrescriptionDrug serializer.
@JsonSerializable()
class PrescriptionDrug {
  const PrescriptionDrug({
    required this.drugId,
    required this.drugName,
    required this.usageInstruction,
    required this.formOfDrug,
    required this.drugDosage,
  });
  
  factory PrescriptionDrug.fromJson(Map<String, Object?> json) => _$PrescriptionDrugFromJson(json);
  
  @JsonKey(name: 'drug_id')
  final int drugId;
  @JsonKey(name: 'drug_name')
  final String drugName;
  @JsonKey(name: 'usage_instruction')
  final String usageInstruction;

  /// Form of drug (pills/syrop/e.t.c.)
  @JsonKey(name: 'form_of_drug')
  final String formOfDrug;
  @JsonKey(name: 'drug_dosage')
  final double drugDosage;

  Map<String, Object?> toJson() => _$PrescriptionDrugToJson(this);
}
