// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:json_annotation/json_annotation.dart';

import 'breeds_species_stats_item.dart';

part 'date_joined_inner_species_counts.g.dart';

/// Serializer for items from DateJoinedStatsItemSerializer
@JsonSerializable()
class DateJoinedInnerSpeciesCounts {
  const DateJoinedInnerSpeciesCounts({
    required this.id,
    required this.name,
    required this.count,
    this.breeds,
  });
  
  factory DateJoinedInnerSpeciesCounts.fromJson(Map<String, Object?> json) => _$DateJoinedInnerSpeciesCountsFromJson(json);
  
  final int id;
  final String name;
  final int count;
  final List<BreedsSpeciesStatsItem>? breeds;

  Map<String, Object?> toJson() => _$DateJoinedInnerSpeciesCountsToJson(this);
}
