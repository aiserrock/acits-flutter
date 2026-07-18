import 'package:json_annotation/json_annotation.dart';

part 'prescription_execution_dto.g.dart';

/// A single scheduled execution (dose/procedure) of a prescription.
///
/// OUR DTO — mirrors `PrescriptionExecution`. [status] is kept as the raw wire
/// string (e.g. `IN_PROGRESS`) so unknown backend values round-trip. [id] is
/// nullable because the write path sends executions without an id.
@JsonSerializable()
class PrescriptionExecutionDto {
  const PrescriptionExecutionDto({required this.executeAt, this.id, this.status});

  factory PrescriptionExecutionDto.fromJson(Map<String, dynamic> json) => _$PrescriptionExecutionDtoFromJson(json);

  final int? id;
  @JsonKey(name: 'execute_at')
  final DateTime executeAt;
  final String? status;

  Map<String, dynamic> toJson() => _$PrescriptionExecutionDtoToJson(this);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PrescriptionExecutionDto && other.id == id && other.executeAt == executeAt && other.status == status;

  @override
  int get hashCode => Object.hash(id, executeAt, status);
}
