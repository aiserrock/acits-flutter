// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'animal_stats_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AnimalStatsResponse _$AnimalStatsResponseFromJson(
  Map<String, dynamic> json,
) => AnimalStatsResponse(
  breeds: (json['breeds'] as List<dynamic>?)
      ?.map((e) => BreedsSpeciesStatsItem.fromJson(e as Map<String, dynamic>))
      .toList(),
  species: (json['species'] as List<dynamic>?)
      ?.map((e) => BreedsSpeciesStatsItem.fromJson(e as Map<String, dynamic>))
      .toList(),
  dateJoined: (json['date_joined'] as List<dynamic>?)
      ?.map((e) => DateJoinedStatsItem.fromJson(e as Map<String, dynamic>))
      .toList(),
  statusTransitions: (json['status_transitions'] as List<dynamic>?)
      ?.map((e) => StatusTransitionsItem.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$AnimalStatsResponseToJson(
  AnimalStatsResponse instance,
) => <String, dynamic>{
  'breeds': instance.breeds,
  'species': instance.species,
  'date_joined': instance.dateJoined,
  'status_transitions': instance.statusTransitions,
};
