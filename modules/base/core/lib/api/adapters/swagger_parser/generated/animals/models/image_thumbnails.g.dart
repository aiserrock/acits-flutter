// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'image_thumbnails.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ImageThumbnails _$ImageThumbnailsFromJson(Map<String, dynamic> json) =>
    ImageThumbnails(
      large: json['large'] as String?,
      medium: json['medium'] as String?,
      small: json['small'] as String?,
      additionalProperties:
          ImageThumbnails._extras(json, 'additionalProperties') == null
          ? const {}
          : ImageThumbnails._readExtras(
              ImageThumbnails._extras(json, 'additionalProperties'),
            ),
    );

Map<String, dynamic> _$ImageThumbnailsToJson(ImageThumbnails instance) =>
    <String, dynamic>{
      'large': ?instance.large,
      'medium': ?instance.medium,
      'small': ?instance.small,
    };
