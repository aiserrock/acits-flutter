// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'paginated_overstay_list.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PaginatedOverstayList _$PaginatedOverstayListFromJson(
  Map<String, dynamic> json,
) => PaginatedOverstayList(
  count: PaginatedOverstayList._read_count(json['count']),
  next: json['next'] as String?,
  previous: json['previous'] as String?,
  results: (json['results'] as List<dynamic>?)
      ?.map((e) => Overstay.fromJson(e as Map<String, dynamic>))
      .toList(),
  additionalProperties:
      PaginatedOverstayList._extras(json, 'additionalProperties') == null
      ? const {}
      : PaginatedOverstayList._readExtras(
          PaginatedOverstayList._extras(json, 'additionalProperties'),
        ),
);

Map<String, dynamic> _$PaginatedOverstayListToJson(
  PaginatedOverstayList instance,
) => <String, dynamic>{
  'count': ?PaginatedOverstayList._write_count(instance.count),
  'next': ?instance.next,
  'previous': ?instance.previous,
  'results': ?instance.results?.map((e) => e.toJson()).toList(),
};
