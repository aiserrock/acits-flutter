// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'token_refresh.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TokenRefresh _$TokenRefreshFromJson(Map<String, dynamic> json) => TokenRefresh(
  access: json['access'] as String?,
  refresh: json['refresh'] as String?,
  additionalProperties:
      TokenRefresh._extras(json, 'additionalProperties') == null
      ? const {}
      : TokenRefresh._readExtras(
          TokenRefresh._extras(json, 'additionalProperties'),
        ),
);

Map<String, dynamic> _$TokenRefreshToJson(TokenRefresh instance) =>
    <String, dynamic>{'access': ?instance.access, 'refresh': ?instance.refresh};
