// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:json_annotation/json_annotation.dart';

import 'shelter_drug.dart';

part 'paginated_shelter_drug_list.g.dart';

@JsonSerializable()
class PaginatedShelterDrugList {
  const PaginatedShelterDrugList({
    this.count,
    this.next,
    this.previous,
    this.results,
  });
  
  factory PaginatedShelterDrugList.fromJson(Map<String, Object?> json) => _$PaginatedShelterDrugListFromJson(json);
  
  final int? count;
  final String? next;
  final String? previous;
  final List<ShelterDrug>? results;

  Map<String, Object?> toJson() => _$PaginatedShelterDrugListToJson(this);
}
