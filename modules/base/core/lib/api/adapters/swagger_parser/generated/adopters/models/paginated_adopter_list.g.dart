// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'paginated_adopter_list.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PaginatedAdopterList _$PaginatedAdopterListFromJson(
  Map<String, dynamic> json,
) => PaginatedAdopterList(
  count: PaginatedAdopterList._read_count(json['count']),
  next: json['next'] as String?,
  previous: json['previous'] as String?,
  results: (json['results'] as List<dynamic>?)
      ?.map((e) => Adopter.fromJson(e as Map<String, dynamic>))
      .toList(),
  additionalProperties:
      PaginatedAdopterList._extras(json, 'additionalProperties') == null
      ? const {}
      : PaginatedAdopterList._readExtras(
          PaginatedAdopterList._extras(json, 'additionalProperties'),
        ),
);

Map<String, dynamic> _$PaginatedAdopterListToJson(
  PaginatedAdopterList instance,
) => <String, dynamic>{
  'count': ?PaginatedAdopterList._write_count(instance.count),
  'next': ?instance.next,
  'previous': ?instance.previous,
  'results': ?instance.results?.map((e) => e.toJson()).toList(),
};
