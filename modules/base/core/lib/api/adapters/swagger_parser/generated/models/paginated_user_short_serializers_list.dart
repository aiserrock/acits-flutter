// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:json_annotation/json_annotation.dart';

import 'user_short_serializers.dart';

part 'paginated_user_short_serializers_list.g.dart';

@JsonSerializable()
class PaginatedUserShortSerializersList {
  const PaginatedUserShortSerializersList({
    this.count,
    this.next,
    this.previous,
    this.results,
  });
  
  factory PaginatedUserShortSerializersList.fromJson(Map<String, Object?> json) => _$PaginatedUserShortSerializersListFromJson(json);
  
  final int? count;
  final String? next;
  final String? previous;
  final List<UserShortSerializers>? results;

  Map<String, Object?> toJson() => _$PaginatedUserShortSerializersListToJson(this);
}
