// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'token_refresh_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TokenRefreshDto _$TokenRefreshDtoFromJson(Map<String, dynamic> json) =>
    TokenRefreshDto(access: json['access'] as String, refresh: json['refresh'] as String?);

Map<String, dynamic> _$TokenRefreshDtoToJson(TokenRefreshDto instance) => <String, dynamic>{
  'access': instance.access,
  'refresh': instance.refresh,
};
