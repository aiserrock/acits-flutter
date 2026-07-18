// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:json_annotation/json_annotation.dart';

import 'image_thumbnails.dart';

part 'animal_image_read.g.dart';

/// Animal Image read serializer.
@JsonSerializable()
class AnimalImageRead {
  const AnimalImageRead({
    required this.id,
    required this.filename,
    required this.image,
    this.isPrimary,
  });
  
  factory AnimalImageRead.fromJson(Map<String, Object?> json) => _$AnimalImageReadFromJson(json);
  
  final int id;
  @JsonKey(name: 'is_primary')
  final bool? isPrimary;
  final String filename;
  final ImageThumbnails image;

  Map<String, Object?> toJson() => _$AnimalImageReadToJson(this);
}
