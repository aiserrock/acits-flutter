// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:json_annotation/json_annotation.dart';

import 'curator.dart';

part 'paginated_curator_list.g.dart';

@JsonSerializable()
class PaginatedCuratorList {
  const PaginatedCuratorList({
    this.count,
    this.next,
    this.previous,
    this.results,
  });
  
  factory PaginatedCuratorList.fromJson(Map<String, Object?> json) => _$PaginatedCuratorListFromJson(json);
  
  final int? count;
  final String? next;
  final String? previous;
  final List<Curator>? results;

  Map<String, Object?> toJson() => _$PaginatedCuratorListToJson(this);
}
