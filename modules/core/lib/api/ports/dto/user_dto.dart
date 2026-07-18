import 'package:json_annotation/json_annotation.dart';

part 'user_dto.g.dart';

/// The signed-in user's own profile (`/api/v1/users/me/`).
///
/// OUR DTO — mirrors `UserSerializers` on the wire. Distinct from the auth
/// slice's admin/worker DTOs (those are registration payloads); this is the
/// self profile the personal screen reads and edits.
@JsonSerializable()
class UserDto {
  const UserDto({
    required this.id,
    required this.username,
    required this.firstName,
    required this.lastName,
    required this.fullName,
    required this.email,
    required this.dateJoined,
    required this.isVerified,
    this.fathersName,
    this.phoneNumber,
    this.address,
    this.isOfferSigned,
  });

  factory UserDto.fromJson(Map<String, dynamic> json) => _$UserDtoFromJson(json);

  final int id;
  final String username;
  @JsonKey(name: 'first_name')
  final String firstName;
  @JsonKey(name: 'last_name')
  final String lastName;
  @JsonKey(name: 'fathers_name')
  final String? fathersName;
  @JsonKey(name: 'full_name')
  final String fullName;
  final String email;
  @JsonKey(name: 'phone_number')
  final String? phoneNumber;
  final String? address;
  @JsonKey(name: 'date_joined')
  final DateTime dateJoined;
  @JsonKey(name: 'is_verified')
  final bool isVerified;
  @JsonKey(name: 'is_offer_signed')
  final bool? isOfferSigned;

  Map<String, dynamic> toJson() => _$UserDtoToJson(this);
}
