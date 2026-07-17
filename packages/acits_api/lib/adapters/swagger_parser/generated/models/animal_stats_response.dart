// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:json_annotation/json_annotation.dart';

import 'breeds_species_stats_item.dart';
import 'date_joined_stats_item.dart';
import 'status_transitions_item.dart';

part 'animal_stats_response.g.dart';

/// Serializer for responses made by the endpoint for statistics
@JsonSerializable()
class AnimalStatsResponse {
  const AnimalStatsResponse({
    this.breeds,
    this.species,
    this.dateJoined,
    this.statusTransitions,
  });
  
  factory AnimalStatsResponse.fromJson(Map<String, Object?> json) => _$AnimalStatsResponseFromJson(json);
  
  final List<BreedsSpeciesStatsItem>? breeds;
  final List<BreedsSpeciesStatsItem>? species;
  @JsonKey(name: 'date_joined')
  final List<DateJoinedStatsItem>? dateJoined;
  @JsonKey(name: 'status_transitions')
  final List<StatusTransitionsItem>? statusTransitions;

  Map<String, Object?> toJson() => _$AnimalStatsResponseToJson(this);
}
