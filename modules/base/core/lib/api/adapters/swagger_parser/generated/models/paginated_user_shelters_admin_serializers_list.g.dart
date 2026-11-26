// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'paginated_user_shelters_admin_serializers_list.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PaginatedUserSheltersAdminSerializersList
_$PaginatedUserSheltersAdminSerializersListFromJson(
  Map<String, dynamic> json,
) => PaginatedUserSheltersAdminSerializersList(
  count: (json['count'] as num?)?.toInt(),
  next: json['next'] as String?,
  previous: json['previous'] as String?,
  results: (json['results'] as List<dynamic>?)
      ?.map(
        (e) => UserSheltersAdminSerializers.fromJson(e as Map<String, dynamic>),
      )
      .toList(),
);

Map<String, dynamic> _$PaginatedUserSheltersAdminSerializersListToJson(
  PaginatedUserSheltersAdminSerializersList instance,
) => <String, dynamic>{
  'count': instance.count,
  'next': instance.next,
  'previous': instance.previous,
  'results': instance.results,
};
