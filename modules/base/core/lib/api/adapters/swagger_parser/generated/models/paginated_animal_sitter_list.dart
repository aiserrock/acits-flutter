// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:json_annotation/json_annotation.dart';

import 'animal_sitter.dart';

part 'paginated_animal_sitter_list.g.dart';

@JsonSerializable()
class PaginatedAnimalSitterList {
  const PaginatedAnimalSitterList({
    this.count,
    this.next,
    this.previous,
    this.results,
  });
  
  factory PaginatedAnimalSitterList.fromJson(Map<String, Object?> json) => _$PaginatedAnimalSitterListFromJson(json);
  
  final int? count;
  final String? next;
  final String? previous;
  final List<AnimalSitter>? results;

  Map<String, Object?> toJson() => _$PaginatedAnimalSitterListToJson(this);
}
