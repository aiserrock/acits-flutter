// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'paginated_user_shelters_admin_serializers_list.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PaginatedUserSheltersAdminSerializersList
_$PaginatedUserSheltersAdminSerializersListFromJson(
  Map<String, dynamic> json,
) => PaginatedUserSheltersAdminSerializersList(
  count: PaginatedUserSheltersAdminSerializersList._read_count(json['count']),
  next: json['next'] as String?,
  previous: json['previous'] as String?,
  results: (json['results'] as List<dynamic>?)
      ?.map(
        (e) => UserSheltersAdminSerializers.fromJson(e as Map<String, dynamic>),
      )
      .toList(),
  additionalProperties:
      PaginatedUserSheltersAdminSerializersList._extras(
            json,
            'additionalProperties',
          ) ==
          null
      ? const {}
      : PaginatedUserSheltersAdminSerializersList._readExtras(
          PaginatedUserSheltersAdminSerializersList._extras(
            json,
            'additionalProperties',
          ),
        ),
);

Map<String, dynamic> _$PaginatedUserSheltersAdminSerializersListToJson(
  PaginatedUserSheltersAdminSerializersList instance,
) => <String, dynamic>{
  'count': ?PaginatedUserSheltersAdminSerializersList._write_count(
    instance.count,
  ),
  'next': ?instance.next,
  'previous': ?instance.previous,
  'results': ?instance.results?.map((e) => e.toJson()).toList(),
};
