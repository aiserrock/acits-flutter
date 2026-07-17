// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'token_pair_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TokenPairDto _$TokenPairDtoFromJson(Map<String, dynamic> json) =>
    TokenPairDto(access: json['access'] as String, refresh: json['refresh'] as String);

Map<String, dynamic> _$TokenPairDtoToJson(TokenPairDto instance) => <String, dynamic>{
  'access': instance.access,
  'refresh': instance.refresh,
};
