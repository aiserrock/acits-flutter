// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'date_joined_stats_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DateJoinedStatsItem _$DateJoinedStatsItemFromJson(Map<String, dynamic> json) =>
    DateJoinedStatsItem(
      dateJoined: json['date_joined'] == null
          ? null
          : DateTime.parse(json['date_joined'] as String),
      count: (json['count'] as num?)?.toInt(),
      species: (json['species'] as List<dynamic>?)
          ?.map(
            (e) => DateJoinedInnerSpeciesCounts.fromJson(
              e as Map<String, dynamic>,
            ),
          )
          .toList(),
    );

Map<String, dynamic> _$DateJoinedStatsItemToJson(
  DateJoinedStatsItem instance,
) => <String, dynamic>{
  'date_joined': instance.dateJoined?.toIso8601String(),
  'count': instance.count,
  'species': instance.species,
};
