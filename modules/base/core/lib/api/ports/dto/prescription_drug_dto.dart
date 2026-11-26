import 'package:json_annotation/json_annotation.dart';

part 'prescription_drug_dto.g.dart';

/// A drug line inside a prescription (name + dosage + form).
///
/// OUR DTO — mirrors `PrescriptionDrug` on the wire. [usageInstruction] and
/// [formOfDrug] are nullable because the app's write path fills only a subset.
@JsonSerializable()
class PrescriptionDrugDto {
  const PrescriptionDrugDto({
    required this.drugId,
    required this.drugName,
    required this.drugDosage,
    this.usageInstruction,
    this.formOfDrug,
  });

  factory PrescriptionDrugDto.fromJson(Map<String, dynamic> json) => _$PrescriptionDrugDtoFromJson(json);

  @JsonKey(name: 'drug_id')
  final int drugId;
  @JsonKey(name: 'drug_name')
  final String drugName;
  @JsonKey(name: 'drug_dosage')
  final double drugDosage;
  @JsonKey(name: 'usage_instruction')
  final String? usageInstruction;
  @JsonKey(name: 'form_of_drug')
  final String? formOfDrug;

  Map<String, dynamic> toJson() => _$PrescriptionDrugDtoToJson(this);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PrescriptionDrugDto &&
          other.drugId == drugId &&
          other.drugName == drugName &&
          other.drugDosage == drugDosage &&
          other.usageInstruction == usageInstruction &&
          other.formOfDrug == formOfDrug;

  @override
  int get hashCode => Object.hash(drugId, drugName, drugDosage, usageInstruction, formOfDrug);
}
