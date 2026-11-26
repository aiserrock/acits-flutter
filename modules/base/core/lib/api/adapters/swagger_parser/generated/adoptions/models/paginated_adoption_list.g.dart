// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'paginated_adoption_list.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PaginatedAdoptionList _$PaginatedAdoptionListFromJson(
  Map<String, dynamic> json,
) => PaginatedAdoptionList(
  count: PaginatedAdoptionList._read_count(json['count']),
  next: json['next'] as String?,
  previous: json['previous'] as String?,
  results: (json['results'] as List<dynamic>?)
      ?.map((e) => Adoption.fromJson(e as Map<String, dynamic>))
      .toList(),
  additionalProperties:
      PaginatedAdoptionList._extras(json, 'additionalProperties') == null
      ? const {}
      : PaginatedAdoptionList._readExtras(
          PaginatedAdoptionList._extras(json, 'additionalProperties'),
        ),
);

Map<String, dynamic> _$PaginatedAdoptionListToJson(
  PaginatedAdoptionList instance,
) => <String, dynamic>{
  'count': ?PaginatedAdoptionList._write_count(instance.count),
  'next': ?instance.next,
  'previous': ?instance.previous,
  'results': ?instance.results?.map((e) => e.toJson()).toList(),
};
