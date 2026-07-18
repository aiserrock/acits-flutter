// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:json_annotation/json_annotation.dart';

import 'applicant.dart';

part 'paginated_applicant_list.g.dart';

@JsonSerializable()
class PaginatedApplicantList {
  const PaginatedApplicantList({
    this.count,
    this.next,
    this.previous,
    this.results,
  });
  
  factory PaginatedApplicantList.fromJson(Map<String, Object?> json) => _$PaginatedApplicantListFromJson(json);
  
  final int? count;
  final String? next;
  final String? previous;
  final List<Applicant>? results;

  Map<String, Object?> toJson() => _$PaginatedApplicantListToJson(this);
}
