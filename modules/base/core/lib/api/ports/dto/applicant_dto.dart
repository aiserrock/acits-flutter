import 'package:json_annotation/json_annotation.dart';

part 'applicant_dto.g.dart';

/// Person applying to adopt / foster an animal.
///
/// OUR DTO — mirrors `Applicant` on the wire. `applicantFiles` is left as raw
/// JSON maps here (the animals reference slice never reads file internals).
@JsonSerializable()
class ApplicantDto {
  const ApplicantDto({
    required this.id,
    required this.url,
    required this.shelter,
    required this.firstName,
    required this.lastName,
    required this.phoneNumber,
    required this.createdBy,
    required this.updatedBy,
    required this.createdAt,
    required this.updatedAt,
    this.email,
    this.contactDetails,
    this.animalId,
    this.applicantFiles,
  });

  factory ApplicantDto.fromJson(Map<String, dynamic> json) => _$ApplicantDtoFromJson(json);

  final int id;
  final String url;
  final int shelter;
  @JsonKey(name: 'first_name')
  final String firstName;
  @JsonKey(name: 'last_name')
  final String lastName;
  final String? email;
  @JsonKey(name: 'phone_number')
  final String phoneNumber;
  @JsonKey(name: 'contact_details')
  final String? contactDetails;
  @JsonKey(name: 'created_by')
  final String createdBy;
  @JsonKey(name: 'updated_by')
  final String updatedBy;
  @JsonKey(name: 'created_at')
  final DateTime createdAt;
  @JsonKey(name: 'updated_at')
  final DateTime updatedAt;
  @JsonKey(name: 'animal_id')
  final int? animalId;
  @JsonKey(name: 'applicant_files')
  final List<Map<String, dynamic>>? applicantFiles;

  Map<String, dynamic> toJson() => _$ApplicantDtoToJson(this);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ApplicantDto &&
          other.id == id &&
          other.url == url &&
          other.shelter == shelter &&
          other.firstName == firstName &&
          other.lastName == lastName &&
          other.email == email &&
          other.phoneNumber == phoneNumber &&
          other.contactDetails == contactDetails &&
          other.createdBy == createdBy &&
          other.updatedBy == updatedBy &&
          other.createdAt == createdAt &&
          other.updatedAt == updatedAt &&
          other.animalId == animalId;

  @override
  int get hashCode => Object.hash(
    id,
    url,
    shelter,
    firstName,
    lastName,
    email,
    phoneNumber,
    contactDetails,
    createdBy,
    updatedBy,
    createdAt,
    updatedAt,
    animalId,
  );
}
