// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'date_joined_inner_species_counts.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DateJoinedInnerSpeciesCounts _$DateJoinedInnerSpeciesCountsFromJson(
  Map<String, dynamic> json,
) => DateJoinedInnerSpeciesCounts(
  id: DateJoinedInnerSpeciesCounts._read_id(json['id']),
  name: json['name'] as String?,
  count: DateJoinedInnerSpeciesCounts._read_count(json['count']),
  breeds: (json['breeds'] as List<dynamic>?)
      ?.map((e) => BreedsSpeciesStatsItem.fromJson(e as Map<String, dynamic>))
      .toList(),
  additionalProperties:
      DateJoinedInnerSpeciesCounts._extras(json, 'additionalProperties') == null
      ? const {}
      : DateJoinedInnerSpeciesCounts._readExtras(
          DateJoinedInnerSpeciesCounts._extras(json, 'additionalProperties'),
        ),
);

Map<String, dynamic> _$DateJoinedInnerSpeciesCountsToJson(
  DateJoinedInnerSpeciesCounts instance,
) => <String, dynamic>{
  'id': ?DateJoinedInnerSpeciesCounts._write_id(instance.id),
  'name': ?instance.name,
  'count': ?DateJoinedInnerSpeciesCounts._write_count(instance.count),
  'breeds': ?instance.breeds?.map((e) => e.toJson()).toList(),
};
