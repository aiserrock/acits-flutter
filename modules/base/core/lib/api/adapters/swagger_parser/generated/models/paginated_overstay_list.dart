// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:json_annotation/json_annotation.dart';

import 'overstay.dart';

part 'paginated_overstay_list.g.dart';

@JsonSerializable()
class PaginatedOverstayList {
  const PaginatedOverstayList({
    this.count,
    this.next,
    this.previous,
    this.results,
  });
  
  factory PaginatedOverstayList.fromJson(Map<String, Object?> json) => _$PaginatedOverstayListFromJson(json);
  
  final int? count;
  final String? next;
  final String? previous;
  final List<Overstay>? results;

  Map<String, Object?> toJson() => _$PaginatedOverstayListToJson(this);
}
