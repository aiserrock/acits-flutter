// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'image_thumbnails_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ImageThumbnailsDto _$ImageThumbnailsDtoFromJson(Map<String, dynamic> json) =>
    ImageThumbnailsDto(
      large: json['large'] as String,
      medium: json['medium'] as String,
      small: json['small'] as String,
    );

Map<String, dynamic> _$ImageThumbnailsDtoToJson(ImageThumbnailsDto instance) =>
    <String, dynamic>{
      'large': instance.large,
      'medium': instance.medium,
      'small': instance.small,
    };
