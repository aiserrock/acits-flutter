// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:json_annotation/json_annotation.dart';

import 'adopter.dart';

part 'paginated_adopter_list.g.dart';

@JsonSerializable()
class PaginatedAdopterList {
  const PaginatedAdopterList({
    this.count,
    this.next,
    this.previous,
    this.results,
  });
  
  factory PaginatedAdopterList.fromJson(Map<String, Object?> json) => _$PaginatedAdopterListFromJson(json);
  
  final int? count;
  final String? next;
  final String? previous;
  final List<Adopter>? results;

  Map<String, Object?> toJson() => _$PaginatedAdopterListToJson(this);
}
