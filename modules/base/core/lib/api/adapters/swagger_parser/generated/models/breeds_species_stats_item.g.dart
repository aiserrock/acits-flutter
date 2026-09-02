// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'breeds_species_stats_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BreedsSpeciesStatsItem _$BreedsSpeciesStatsItemFromJson(
  Map<String, dynamic> json,
) => BreedsSpeciesStatsItem(
  id: (json['id'] as num?)?.toInt(),
  name: json['name'] as String?,
  count: (json['count'] as num?)?.toInt(),
);

Map<String, dynamic> _$BreedsSpeciesStatsItemToJson(
  BreedsSpeciesStatsItem instance,
) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'count': instance.count,
};
