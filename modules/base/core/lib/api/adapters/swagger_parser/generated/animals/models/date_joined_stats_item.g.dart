// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'date_joined_stats_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DateJoinedStatsItem _$DateJoinedStatsItemFromJson(Map<String, dynamic> json) =>
    DateJoinedStatsItem(
      dateJoined: DateJoinedStatsItem._read_dateJoined(json['date_joined']),
      count: DateJoinedStatsItem._read_count(json['count']),
      species: (json['species'] as List<dynamic>?)
          ?.map(
            (e) => DateJoinedInnerSpeciesCounts.fromJson(
              e as Map<String, dynamic>,
            ),
          )
          .toList(),
      additionalProperties:
          DateJoinedStatsItem._extras(json, 'additionalProperties') == null
          ? const {}
          : DateJoinedStatsItem._readExtras(
              DateJoinedStatsItem._extras(json, 'additionalProperties'),
            ),
    );

Map<String, dynamic> _$DateJoinedStatsItemToJson(
  DateJoinedStatsItem instance,
) => <String, dynamic>{
  'date_joined': ?DateJoinedStatsItem._write_dateJoined(instance.dateJoined),
  'count': ?DateJoinedStatsItem._write_count(instance.count),
  'species': ?instance.species?.map((e) => e.toJson()).toList(),
};
