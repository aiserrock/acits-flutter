// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'breeds_species_stats_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BreedsSpeciesStatsItem _$BreedsSpeciesStatsItemFromJson(
  Map<String, dynamic> json,
) => BreedsSpeciesStatsItem(
  id: BreedsSpeciesStatsItem._read_id(json['id']),
  name: json['name'] as String?,
  count: BreedsSpeciesStatsItem._read_count(json['count']),
  additionalProperties:
      BreedsSpeciesStatsItem._extras(json, 'additionalProperties') == null
      ? const {}
      : BreedsSpeciesStatsItem._readExtras(
          BreedsSpeciesStatsItem._extras(json, 'additionalProperties'),
        ),
);

Map<String, dynamic> _$BreedsSpeciesStatsItemToJson(
  BreedsSpeciesStatsItem instance,
) => <String, dynamic>{
  'id': ?BreedsSpeciesStatsItem._write_id(instance.id),
  'name': ?instance.name,
  'count': ?BreedsSpeciesStatsItem._write_count(instance.count),
};
