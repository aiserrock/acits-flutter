// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:json_annotation/json_annotation.dart';

part 'image_thumbnails.g.dart';

@JsonSerializable()
class ImageThumbnails {
  const ImageThumbnails({
    required this.large,
    required this.medium,
    required this.small,
  });
  
  factory ImageThumbnails.fromJson(Map<String, Object?> json) => _$ImageThumbnailsFromJson(json);
  
  final String large;
  final String medium;
  final String small;

  Map<String, Object?> toJson() => _$ImageThumbnailsToJson(this);
}
