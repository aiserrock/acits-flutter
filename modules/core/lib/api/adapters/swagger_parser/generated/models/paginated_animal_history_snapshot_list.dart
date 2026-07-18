// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:json_annotation/json_annotation.dart';

import 'animal_history_snapshot.dart';

part 'paginated_animal_history_snapshot_list.g.dart';

@JsonSerializable()
class PaginatedAnimalHistorySnapshotList {
  const PaginatedAnimalHistorySnapshotList({
    this.count,
    this.next,
    this.previous,
    this.results,
  });
  
  factory PaginatedAnimalHistorySnapshotList.fromJson(Map<String, Object?> json) => _$PaginatedAnimalHistorySnapshotListFromJson(json);
  
  final int? count;
  final String? next;
  final String? previous;
  final List<AnimalHistorySnapshot>? results;

  Map<String, Object?> toJson() => _$PaginatedAnimalHistorySnapshotListToJson(this);
}
