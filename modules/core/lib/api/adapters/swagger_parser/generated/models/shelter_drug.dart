// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:json_annotation/json_annotation.dart';

import 'drug.dart';

part 'shelter_drug.g.dart';

/// ShelterDrug serializer.
@JsonSerializable()
class ShelterDrug {
  const ShelterDrug({
    required this.drug,
    this.drugResiduesCount,
  });
  
  factory ShelterDrug.fromJson(Map<String, Object?> json) => _$ShelterDrugFromJson(json);
  
  final Drug drug;
  @JsonKey(name: 'drug_residues_count')
  final int? drugResiduesCount;

  Map<String, Object?> toJson() => _$ShelterDrugToJson(this);
}
