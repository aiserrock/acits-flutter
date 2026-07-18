import 'package:json_annotation/json_annotation.dart';

part 'token_refresh_dto.g.dart';

/// Result of `POST /api/token/refresh/`.
///
/// `refresh` is nullable: the backend (SimpleJWT without ROTATE_REFRESH_TOKENS)
/// returns `refresh=null` on refresh, keeping the old token valid.
@JsonSerializable()
class TokenRefreshDto {
  const TokenRefreshDto({required this.access, this.refresh});

  factory TokenRefreshDto.fromJson(Map<String, dynamic> json) => _$TokenRefreshDtoFromJson(json);

  final String access;
  final String? refresh;

  Map<String, dynamic> toJson() => _$TokenRefreshDtoToJson(this);

  @override
  bool operator ==(Object other) =>
      identical(this, other) || (other is TokenRefreshDto && other.access == access && other.refresh == refresh);

  @override
  int get hashCode => Object.hash(access, refresh);
}
