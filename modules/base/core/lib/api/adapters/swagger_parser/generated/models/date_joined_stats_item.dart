// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:json_annotation/json_annotation.dart';

import 'date_joined_inner_species_counts.dart';

part 'date_joined_stats_item.g.dart';

/// Serializer for items from AnimalStatsResponseSerializer
@JsonSerializable()
class DateJoinedStatsItem {
  const DateJoinedStatsItem({
    this.dateJoined,
    this.count,
    this.species,
  });
  
  factory DateJoinedStatsItem.fromJson(Map<String, Object?> json) => _$DateJoinedStatsItemFromJson(json);
  
  @JsonKey(name: 'date_joined')
  final DateTime? dateJoined;
  final int? count;
  final List<DateJoinedInnerSpeciesCounts>? species;

  Map<String, Object?> toJson() => _$DateJoinedStatsItemToJson(this);
}
