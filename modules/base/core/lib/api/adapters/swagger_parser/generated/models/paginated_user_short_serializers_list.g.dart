// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'paginated_user_short_serializers_list.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PaginatedUserShortSerializersList _$PaginatedUserShortSerializersListFromJson(
  Map<String, dynamic> json,
) => PaginatedUserShortSerializersList(
  count: (json['count'] as num?)?.toInt(),
  next: json['next'] as String?,
  previous: json['previous'] as String?,
  results: (json['results'] as List<dynamic>?)
      ?.map((e) => UserShortSerializers.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$PaginatedUserShortSerializersListToJson(
  PaginatedUserShortSerializersList instance,
) => <String, dynamic>{
  'count': instance.count,
  'next': instance.next,
  'previous': instance.previous,
  'results': instance.results,
};
