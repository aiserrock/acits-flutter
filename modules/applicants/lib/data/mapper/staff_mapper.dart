import 'package:core/api.dart';
import 'package:core/domain.dart';

/// DTO → доменный [Applicant]. Пустые строки вместо null: форма редактирования
/// работает с непустыми обязательными полями.
class ApplicantMapper implements Transformable<Applicant> {
  const ApplicantMapper(this._dto);

  final ApplicantDto _dto;

  @override
  Applicant toEntity() => Applicant(
    id: _dto.id,
    firstName: _dto.firstName ?? '',
    lastName: _dto.lastName ?? '',
    phoneNumber: _dto.phoneNumber ?? '',
    email: _dto.email,
    contactDetails: _dto.contactDetails,
  );
}

/// DTO → доменный [Curator].
class CuratorMapper implements Transformable<Curator> {
  const CuratorMapper(this._dto);

  final CuratorDto _dto;

  @override
  Curator toEntity() => Curator(
    id: _dto.id,
    firstName: _dto.firstName ?? '',
    lastName: _dto.lastName ?? '',
    phoneNumber: _dto.phoneNumber ?? '',
    email: _dto.email,
    address: _dto.address,
  );
}

/// Сущность → write-DTO. Приют берётся из текущего скоупа ([shelterId]) —
/// как и раньше, сущность его не носит.
ApplicantWriteDto applicantToWriteDto(Applicant a, {int? shelterId}) => ApplicantWriteDto(
  id: a.id,
  shelter: shelterId,
  firstName: a.firstName,
  lastName: a.lastName,
  phoneNumber: a.phoneNumber,
  email: a.email,
  contactDetails: a.contactDetails,
);

/// Сущность → write-DTO. `shelter` куратора уходит строкой (контракт API).
CuratorWriteDto curatorToWriteDto(Curator c, {int? shelterId}) => CuratorWriteDto(
  id: c.id,
  shelter: shelterId?.toString(),
  firstName: c.firstName,
  lastName: c.lastName,
  phoneNumber: c.phoneNumber,
  email: c.email,
  address: c.address ?? '',
);
