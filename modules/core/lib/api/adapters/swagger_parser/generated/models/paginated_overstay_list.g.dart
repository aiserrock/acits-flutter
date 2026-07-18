// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'paginated_overstay_list.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PaginatedOverstayList _$PaginatedOverstayListFromJson(
  Map<String, dynamic> json,
) => PaginatedOverstayList(
  count: (json['count'] as num?)?.toInt(),
  next: json['next'] as String?,
  previous: json['previous'] as String?,
  results: (json['results'] as List<dynamic>?)
      ?.map((e) => Overstay.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$PaginatedOverstayListToJson(
  PaginatedOverstayList instance,
) => <String, dynamic>{
  'count': instance.count,
  'next': instance.next,
  'previous': instance.previous,
  'results': instance.results,
};
