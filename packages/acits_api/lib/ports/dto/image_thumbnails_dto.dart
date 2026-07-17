import 'package:json_annotation/json_annotation.dart';

part 'image_thumbnails_dto.g.dart';

/// Set of resized image URLs for a single animal image.
///
/// OUR DTO — mirrors the wire shape (snake_case keys) but is generator-agnostic.
@JsonSerializable()
class ImageThumbnailsDto {
  const ImageThumbnailsDto({required this.large, required this.medium, required this.small});

  factory ImageThumbnailsDto.fromJson(Map<String, dynamic> json) => _$ImageThumbnailsDtoFromJson(json);

  final String large;
  final String medium;
  final String small;

  Map<String, dynamic> toJson() => _$ImageThumbnailsDtoToJson(this);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ImageThumbnailsDto && other.large == large && other.medium == medium && other.small == small;

  @override
  int get hashCode => Object.hash(large, medium, small);
}
