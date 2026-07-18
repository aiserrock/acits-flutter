import 'package:json_annotation/json_annotation.dart';

part 'token_pair_dto.g.dart';

/// Access + refresh token pair returned by `POST /api/token/` (login).
///
/// OUR DTO — mirrors the wire shape, generator-agnostic.
@JsonSerializable()
class TokenPairDto {
  const TokenPairDto({required this.access, required this.refresh});

  factory TokenPairDto.fromJson(Map<String, dynamic> json) => _$TokenPairDtoFromJson(json);

  final String access;
  final String refresh;

  Map<String, dynamic> toJson() => _$TokenPairDtoToJson(this);

  @override
  bool operator ==(Object other) =>
      identical(this, other) || (other is TokenPairDto && other.access == access && other.refresh == refresh);

  @override
  int get hashCode => Object.hash(access, refresh);
}
