import 'package:core/api.dart' show UserDto, UserWriteDto;
import 'package:core/domain.dart' show Transformable;

import 'package:personal/domain/domain.dart';

/// DTO → [UserProfile].
class UserProfileMapper implements Transformable<UserProfile> {
  const UserProfileMapper(this._dto);

  final UserDto _dto;

  @override
  UserProfile toEntity() => UserProfile(
    id: _dto.id,
    username: _dto.username,
    firstName: _dto.firstName,
    lastName: _dto.lastName,
    fullName: _dto.fullName,
    email: _dto.email,
    dateJoined: _dto.dateJoined,
    isVerified: _dto.isVerified,
    fathersName: _dto.fathersName,
    phoneNumber: _dto.phoneNumber,
    address: _dto.address,
    isOfferSigned: _dto.isOfferSigned,
  );
}

/// [UserProfile] → write-DTO. PUT ждёт целую запись, поэтому read-only поля
/// (username/fullName/dateJoined/…) переносятся без изменений.
class UserProfileWriteMapper {
  const UserProfileWriteMapper(this._entity);

  final UserProfile _entity;

  UserWriteDto toDto() => UserWriteDto(
    id: _entity.id,
    username: _entity.username,
    firstName: _entity.firstName,
    lastName: _entity.lastName,
    fullName: _entity.fullName,
    email: _entity.email,
    dateJoined: _entity.dateJoined,
    isVerified: _entity.isVerified,
    fathersName: _entity.fathersName,
    phoneNumber: _entity.phoneNumber,
    address: _entity.address,
    isOfferSigned: _entity.isOfferSigned,
  );
}
