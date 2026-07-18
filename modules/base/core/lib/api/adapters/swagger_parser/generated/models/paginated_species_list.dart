// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:json_annotation/json_annotation.dart';

import 'species.dart';

part 'paginated_species_list.g.dart';

@JsonSerializable()
class PaginatedSpeciesList {
  const PaginatedSpeciesList({
    this.count,
    this.next,
    this.previous,
    this.results,
  });
  
  factory PaginatedSpeciesList.fromJson(Map<String, Object?> json) => _$PaginatedSpeciesListFromJson(json);
  
  final int? count;
  final String? next;
  final String? previous;
  final List<Species>? results;

  Map<String, Object?> toJson() => _$PaginatedSpeciesListToJson(this);
}
