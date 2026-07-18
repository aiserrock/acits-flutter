// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:json_annotation/json_annotation.dart';

import 'user_shelters_admin_serializers.dart';

part 'paginated_user_shelters_admin_serializers_list.g.dart';

@JsonSerializable()
class PaginatedUserSheltersAdminSerializersList {
  const PaginatedUserSheltersAdminSerializersList({
    this.count,
    this.next,
    this.previous,
    this.results,
  });
  
  factory PaginatedUserSheltersAdminSerializersList.fromJson(Map<String, Object?> json) => _$PaginatedUserSheltersAdminSerializersListFromJson(json);
  
  final int? count;
  final String? next;
  final String? previous;
  final List<UserSheltersAdminSerializers>? results;

  Map<String, Object?> toJson() => _$PaginatedUserSheltersAdminSerializersListToJson(this);
}
