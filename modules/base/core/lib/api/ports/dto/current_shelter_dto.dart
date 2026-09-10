import 'package:json_annotation/json_annotation.dart';

part 'current_shelter_dto.g.dart';

/// Current shelter + the caller's role/permissions in it
/// (`GET /api/v1/users/me/shelters/current/`).
@JsonSerializable()
class CurrentShelterDto {
  const CurrentShelterDto({
    required this.currentShelter,
    required this.currentShelterUserRole,
    required this.isUserCanEdit,
    required this.isUserCanDelete,
  });

  factory CurrentShelterDto.fromJson(Map<String, dynamic> json) => _$CurrentShelterDtoFromJson(json);

  @JsonKey(name: 'current_shelter')
  final int currentShelter;
  @JsonKey(name: 'current_shelter_user_role')
  final String currentShelterUserRole;
  @JsonKey(name: 'is_user_can_edit')
  final bool isUserCanEdit;
  @JsonKey(name: 'is_user_can_delete')
  final bool isUserCanDelete;

  Map<String, dynamic> toJson() => _$CurrentShelterDtoToJson(this);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CurrentShelterDto &&
          other.currentShelter == currentShelter &&
          other.currentShelterUserRole == currentShelterUserRole &&
          other.isUserCanEdit == isUserCanEdit &&
          other.isUserCanDelete == isUserCanDelete);

  @override
  int get hashCode => Object.hash(currentShelter, currentShelterUserRole, isUserCanEdit, isUserCanDelete);
}
