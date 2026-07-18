import 'package:json_annotation/json_annotation.dart';

import 'animal_short_dto.dart';
import 'prescription_short_dto.dart';

part 'prescription_execution_today_dto.g.dart';

/// A prescription execution scheduled for "today" (main screen feed).
///
/// OUR DTO — mirrors `PrescriptionExecutionToday`. Embeds a [PrescriptionShortDto]
/// (the parent prescription) with its [AnimalShortDto].
@JsonSerializable(explicitToJson: true)
class PrescriptionExecutionTodayDto {
  const PrescriptionExecutionTodayDto({required this.prescription, required this.executeAt, this.id});

  factory PrescriptionExecutionTodayDto.fromJson(Map<String, dynamic> json) =>
      _$PrescriptionExecutionTodayDtoFromJson(json);

  final int? id;
  final PrescriptionShortDto prescription;
  @JsonKey(name: 'execute_at')
  final DateTime executeAt;

  Map<String, dynamic> toJson() => _$PrescriptionExecutionTodayDtoToJson(this);
}
