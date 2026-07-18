// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:json_annotation/json_annotation.dart';

import 'adoption.dart';

part 'paginated_adoption_list.g.dart';

@JsonSerializable()
class PaginatedAdoptionList {
  const PaginatedAdoptionList({
    this.count,
    this.next,
    this.previous,
    this.results,
  });
  
  factory PaginatedAdoptionList.fromJson(Map<String, Object?> json) => _$PaginatedAdoptionListFromJson(json);
  
  final int? count;
  final String? next;
  final String? previous;
  final List<Adoption>? results;

  Map<String, Object?> toJson() => _$PaginatedAdoptionListToJson(this);
}
