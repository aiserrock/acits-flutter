// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:json_annotation/json_annotation.dart';

part 'breeds_species_stats_item.g.dart';

/// Serializer for items from AnimalStatsResponseSerializer
@JsonSerializable()
class BreedsSpeciesStatsItem {
  const BreedsSpeciesStatsItem({
    required this.id,
    required this.name,
    required this.count,
  });
  
  factory BreedsSpeciesStatsItem.fromJson(Map<String, Object?> json) => _$BreedsSpeciesStatsItemFromJson(json);
  
  final int id;
  final String name;
  final int count;

  Map<String, Object?> toJson() => _$BreedsSpeciesStatsItemToJson(this);
}
