// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'paginated_animal_sitter_list.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PaginatedAnimalSitterList _$PaginatedAnimalSitterListFromJson(
  Map<String, dynamic> json,
) => PaginatedAnimalSitterList(
  count: PaginatedAnimalSitterList._read_count(json['count']),
  next: json['next'] as String?,
  previous: json['previous'] as String?,
  results: (json['results'] as List<dynamic>?)
      ?.map((e) => AnimalSitter.fromJson(e as Map<String, dynamic>))
      .toList(),
  additionalProperties:
      PaginatedAnimalSitterList._extras(json, 'additionalProperties') == null
      ? const {}
      : PaginatedAnimalSitterList._readExtras(
          PaginatedAnimalSitterList._extras(json, 'additionalProperties'),
        ),
);

Map<String, dynamic> _$PaginatedAnimalSitterListToJson(
  PaginatedAnimalSitterList instance,
) => <String, dynamic>{
  'count': ?PaginatedAnimalSitterList._write_count(instance.count),
  'next': ?instance.next,
  'previous': ?instance.previous,
  'results': ?instance.results?.map((e) => e.toJson()).toList(),
};
