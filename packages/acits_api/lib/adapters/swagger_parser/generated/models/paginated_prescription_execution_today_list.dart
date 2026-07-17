// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:json_annotation/json_annotation.dart';

import 'prescription_execution_today.dart';

part 'paginated_prescription_execution_today_list.g.dart';

@JsonSerializable()
class PaginatedPrescriptionExecutionTodayList {
  const PaginatedPrescriptionExecutionTodayList({
    this.count,
    this.next,
    this.previous,
    this.results,
  });
  
  factory PaginatedPrescriptionExecutionTodayList.fromJson(Map<String, Object?> json) => _$PaginatedPrescriptionExecutionTodayListFromJson(json);
  
  final int? count;
  final String? next;
  final String? previous;
  final List<PrescriptionExecutionToday>? results;

  Map<String, Object?> toJson() => _$PaginatedPrescriptionExecutionTodayListToJson(this);
}
