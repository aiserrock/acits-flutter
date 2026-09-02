// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'date_joined_inner_species_counts.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DateJoinedInnerSpeciesCounts _$DateJoinedInnerSpeciesCountsFromJson(
  Map<String, dynamic> json,
) => DateJoinedInnerSpeciesCounts(
  id: (json['id'] as num?)?.toInt(),
  name: json['name'] as String?,
  count: (json['count'] as num?)?.toInt(),
  breeds: (json['breeds'] as List<dynamic>?)
      ?.map((e) => BreedsSpeciesStatsItem.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$DateJoinedInnerSpeciesCountsToJson(
  DateJoinedInnerSpeciesCounts instance,
) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'count': instance.count,
  'breeds': instance.breeds,
};
