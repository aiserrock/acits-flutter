// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:json_annotation/json_annotation.dart';

import 'animal_read.dart';

part 'paginated_animal_read_list.g.dart';

@JsonSerializable()
class PaginatedAnimalReadList {
  const PaginatedAnimalReadList({
    this.count,
    this.next,
    this.previous,
    this.results,
  });
  
  factory PaginatedAnimalReadList.fromJson(Map<String, Object?> json) => _$PaginatedAnimalReadListFromJson(json);
  
  final int? count;
  final String? next;
  final String? previous;
  final List<AnimalRead>? results;

  Map<String, Object?> toJson() => _$PaginatedAnimalReadListToJson(this);
}
