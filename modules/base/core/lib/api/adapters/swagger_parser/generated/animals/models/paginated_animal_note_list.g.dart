// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'paginated_animal_note_list.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PaginatedAnimalNoteList _$PaginatedAnimalNoteListFromJson(
  Map<String, dynamic> json,
) => PaginatedAnimalNoteList(
  count: PaginatedAnimalNoteList._read_count(json['count']),
  next: json['next'] as String?,
  previous: json['previous'] as String?,
  results: (json['results'] as List<dynamic>?)
      ?.map((e) => AnimalNote.fromJson(e as Map<String, dynamic>))
      .toList(),
  additionalProperties:
      PaginatedAnimalNoteList._extras(json, 'additionalProperties') == null
      ? const {}
      : PaginatedAnimalNoteList._readExtras(
          PaginatedAnimalNoteList._extras(json, 'additionalProperties'),
        ),
);

Map<String, dynamic> _$PaginatedAnimalNoteListToJson(
  PaginatedAnimalNoteList instance,
) => <String, dynamic>{
  'count': ?PaginatedAnimalNoteList._write_count(instance.count),
  'next': ?instance.next,
  'previous': ?instance.previous,
  'results': ?instance.results?.map((e) => e.toJson()).toList(),
};
