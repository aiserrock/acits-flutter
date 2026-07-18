// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'paginated_animal_sitter_list.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PaginatedAnimalSitterList _$PaginatedAnimalSitterListFromJson(
  Map<String, dynamic> json,
) => PaginatedAnimalSitterList(
  count: (json['count'] as num?)?.toInt(),
  next: json['next'] as String?,
  previous: json['previous'] as String?,
  results: (json['results'] as List<dynamic>?)
      ?.map((e) => AnimalSitter.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$PaginatedAnimalSitterListToJson(
  PaginatedAnimalSitterList instance,
) => <String, dynamic>{
  'count': instance.count,
  'next': instance.next,
  'previous': instance.previous,
  'results': instance.results,
};
