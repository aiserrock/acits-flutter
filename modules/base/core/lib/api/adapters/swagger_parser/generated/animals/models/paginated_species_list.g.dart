// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'paginated_species_list.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PaginatedSpeciesList _$PaginatedSpeciesListFromJson(
  Map<String, dynamic> json,
) => PaginatedSpeciesList(
  count: PaginatedSpeciesList._read_count(json['count']),
  next: json['next'] as String?,
  previous: json['previous'] as String?,
  results: (json['results'] as List<dynamic>?)
      ?.map((e) => Species.fromJson(e as Map<String, dynamic>))
      .toList(),
  additionalProperties:
      PaginatedSpeciesList._extras(json, 'additionalProperties') == null
      ? const {}
      : PaginatedSpeciesList._readExtras(
          PaginatedSpeciesList._extras(json, 'additionalProperties'),
        ),
);

Map<String, dynamic> _$PaginatedSpeciesListToJson(
  PaginatedSpeciesList instance,
) => <String, dynamic>{
  'count': ?PaginatedSpeciesList._write_count(instance.count),
  'next': ?instance.next,
  'previous': ?instance.previous,
  'results': ?instance.results?.map((e) => e.toJson()).toList(),
};
