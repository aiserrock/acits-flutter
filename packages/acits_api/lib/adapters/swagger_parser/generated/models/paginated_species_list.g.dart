// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'paginated_species_list.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PaginatedSpeciesList _$PaginatedSpeciesListFromJson(
  Map<String, dynamic> json,
) => PaginatedSpeciesList(
  count: (json['count'] as num?)?.toInt(),
  next: json['next'] as String?,
  previous: json['previous'] as String?,
  results: (json['results'] as List<dynamic>?)
      ?.map((e) => Species.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$PaginatedSpeciesListToJson(
  PaginatedSpeciesList instance,
) => <String, dynamic>{
  'count': instance.count,
  'next': instance.next,
  'previous': instance.previous,
  'results': instance.results,
};
