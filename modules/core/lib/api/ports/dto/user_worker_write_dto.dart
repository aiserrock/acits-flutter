import 'package:json_annotation/json_annotation.dart';

part 'user_worker_write_dto.g.dart';

/// Worker-registration payload (`POST /api/v1/users/worker-register/`).
///
/// Wire shape mirrors `UserShelterWorkerSerializers` (write direction).
/// `role` is the raw wire string (`WORKER`/`GUEST`); `shelter` is the target
/// shelter id (nullable — the form may submit without a picked shelter).
@JsonSerializable(includeIfNull: false)
class UserWorkerWriteDto {
  const UserWorkerWriteDto({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.password,
    required this.rePassword,
    required this.role,
    required this.isOfferSigned,
    this.shelter,
    this.fathersName,
    this.phoneNumber,
    this.address,
  });

  factory UserWorkerWriteDto.fromJson(Map<String, dynamic> json) => _$UserWorkerWriteDtoFromJson(json);

  @JsonKey(name: 'first_name')
  final String firstName;
  @JsonKey(name: 'last_name')
  final String lastName;
  @JsonKey(name: 'fathers_name')
  final String? fathersName;
  final String email;
  @JsonKey(name: 'phone_number')
  final String? phoneNumber;
  final String? address;
  final String password;
  @JsonKey(name: 're_password')
  final String rePassword;
  final int? shelter;

  /// Raw wire role value (`WORKER`, `GUEST`).
  final String role;
  @JsonKey(name: 'is_offer_signed')
  final bool isOfferSigned;

  Map<String, dynamic> toJson() => _$UserWorkerWriteDtoToJson(this);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is UserWorkerWriteDto &&
          other.firstName == firstName &&
          other.lastName == lastName &&
          other.fathersName == fathersName &&
          other.email == email &&
          other.phoneNumber == phoneNumber &&
          other.address == address &&
          other.password == password &&
          other.rePassword == rePassword &&
          other.shelter == shelter &&
          other.role == role &&
          other.isOfferSigned == isOfferSigned);

  @override
  int get hashCode => Object.hash(
    firstName,
    lastName,
    fathersName,
    email,
    phoneNumber,
    address,
    password,
    rePassword,
    shelter,
    role,
    isOfferSigned,
  );
}
