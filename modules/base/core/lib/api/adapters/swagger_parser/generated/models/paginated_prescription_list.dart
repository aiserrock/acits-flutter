// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:json_annotation/json_annotation.dart';

import 'prescription.dart';

part 'paginated_prescription_list.g.dart';

@JsonSerializable()
class PaginatedPrescriptionList {
  const PaginatedPrescriptionList({
    this.count,
    this.next,
    this.previous,
    this.results,
  });
  
  factory PaginatedPrescriptionList.fromJson(Map<String, Object?> json) => _$PaginatedPrescriptionListFromJson(json);
  
  final int? count;
  final String? next;
  final String? previous;
  final List<Prescription>? results;

  Map<String, Object?> toJson() => _$PaginatedPrescriptionListToJson(this);
}
