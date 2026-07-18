// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:json_annotation/json_annotation.dart';

import 'release_serializers.dart';

part 'paginated_release_serializers_list.g.dart';

@JsonSerializable()
class PaginatedReleaseSerializersList {
  const PaginatedReleaseSerializersList({
    this.count,
    this.next,
    this.previous,
    this.results,
  });
  
  factory PaginatedReleaseSerializersList.fromJson(Map<String, Object?> json) => _$PaginatedReleaseSerializersListFromJson(json);
  
  final int? count;
  final String? next;
  final String? previous;
  final List<ReleaseSerializers>? results;

  Map<String, Object?> toJson() => _$PaginatedReleaseSerializersListToJson(this);
}
