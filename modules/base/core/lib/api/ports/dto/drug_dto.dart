import 'package:json_annotation/json_annotation.dart';

part 'drug_dto.g.dart';

/// A drug from the shelter drug catalogue (search / picker).
///
/// OUR DTO — flattens `ShelterDrug` (`{drug: Drug, drug_residues_count}`) into a
/// single shape: the catalogue [Drug] fields plus the optional residues count.
@JsonSerializable()
class DrugDto {
  const DrugDto({
    required this.id,
    required this.name,
    required this.formOfDrug,
    required this.formOfDrugName,
    this.usageInstruction,
    this.drugResiduesCount,
  });

  factory DrugDto.fromJson(Map<String, dynamic> json) => _$DrugDtoFromJson(json);

  final int id;
  final String name;
  @JsonKey(name: 'usage_instruction')
  final String? usageInstruction;
  @JsonKey(name: 'form_of_drug')
  final int formOfDrug;
  @JsonKey(name: 'form_of_drug_name')
  final String formOfDrugName;
  @JsonKey(name: 'drug_residues_count')
  final int? drugResiduesCount;

  Map<String, dynamic> toJson() => _$DrugDtoToJson(this);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DrugDto &&
          other.id == id &&
          other.name == name &&
          other.usageInstruction == usageInstruction &&
          other.formOfDrug == formOfDrug &&
          other.formOfDrugName == formOfDrugName &&
          other.drugResiduesCount == drugResiduesCount;

  @override
  int get hashCode => Object.hash(id, name, usageInstruction, formOfDrug, formOfDrugName, drugResiduesCount);
}
