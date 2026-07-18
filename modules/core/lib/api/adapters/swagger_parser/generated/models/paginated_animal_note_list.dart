// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:json_annotation/json_annotation.dart';

import 'animal_note.dart';

part 'paginated_animal_note_list.g.dart';

@JsonSerializable()
class PaginatedAnimalNoteList {
  const PaginatedAnimalNoteList({
    this.count,
    this.next,
    this.previous,
    this.results,
  });
  
  factory PaginatedAnimalNoteList.fromJson(Map<String, Object?> json) => _$PaginatedAnimalNoteListFromJson(json);
  
  final int? count;
  final String? next;
  final String? previous;
  final List<AnimalNote>? results;

  Map<String, Object?> toJson() => _$PaginatedAnimalNoteListToJson(this);
}
