// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'paginated_adopter_list.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PaginatedAdopterList _$PaginatedAdopterListFromJson(
  Map<String, dynamic> json,
) => PaginatedAdopterList(
  count: (json['count'] as num?)?.toInt(),
  next: json['next'] as String?,
  previous: json['previous'] as String?,
  results: (json['results'] as List<dynamic>?)
      ?.map((e) => Adopter.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$PaginatedAdopterListToJson(
  PaginatedAdopterList instance,
) => <String, dynamic>{
  'count': instance.count,
  'next': instance.next,
  'previous': instance.previous,
  'results': instance.results,
};
