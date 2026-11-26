// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'paginated_animal_read_list.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PaginatedAnimalReadList _$PaginatedAnimalReadListFromJson(
  Map<String, dynamic> json,
) => PaginatedAnimalReadList(
  count: PaginatedAnimalReadList._read_count(json['count']),
  next: json['next'] as String?,
  previous: json['previous'] as String?,
  results: (json['results'] as List<dynamic>?)
      ?.map((e) => AnimalRead.fromJson(e as Map<String, dynamic>))
      .toList(),
  additionalProperties:
      PaginatedAnimalReadList._extras(json, 'additionalProperties') == null
      ? const {}
      : PaginatedAnimalReadList._readExtras(
          PaginatedAnimalReadList._extras(json, 'additionalProperties'),
        ),
);

Map<String, dynamic> _$PaginatedAnimalReadListToJson(
  PaginatedAnimalReadList instance,
) => <String, dynamic>{
  'count': ?PaginatedAnimalReadList._write_count(instance.count),
  'next': ?instance.next,
  'previous': ?instance.previous,
  'results': ?instance.results?.map((e) => e.toJson()).toList(),
};
