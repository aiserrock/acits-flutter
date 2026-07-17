// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:json_annotation/json_annotation.dart';

part 'drug.g.dart';

/// Drug serializer.
@JsonSerializable()
class Drug {
  const Drug({
    required this.id,
    required this.name,
    required this.usageInstruction,
    required this.formOfDrug,
    required this.formOfDrugName,
  });
  
  factory Drug.fromJson(Map<String, Object?> json) => _$DrugFromJson(json);
  
  final int id;
  final String name;
  @JsonKey(name: 'usage_instruction')
  final String usageInstruction;
  @JsonKey(name: 'form_of_drug')
  final int formOfDrug;
  @JsonKey(name: 'form_of_drug_name')
  final String formOfDrugName;

  Map<String, Object?> toJson() => _$DrugToJson(this);
}
