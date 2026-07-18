// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'paginated_animal_note_list.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PaginatedAnimalNoteList _$PaginatedAnimalNoteListFromJson(
  Map<String, dynamic> json,
) => PaginatedAnimalNoteList(
  count: (json['count'] as num?)?.toInt(),
  next: json['next'] as String?,
  previous: json['previous'] as String?,
  results: (json['results'] as List<dynamic>?)
      ?.map((e) => AnimalNote.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$PaginatedAnimalNoteListToJson(
  PaginatedAnimalNoteList instance,
) => <String, dynamic>{
  'count': instance.count,
  'next': instance.next,
  'previous': instance.previous,
  'results': instance.results,
};
