import 'package:core/api.dart';
import 'package:core/domain.dart' show Transformable;

import 'package:animals/domain/domain.dart';

/// DTO → доменный [Animal] (богатая карточка). Строковые атрибуты API
/// (sex/color/special_signs и пр.) разворачиваются в [Animal.attributes]
/// (name → value); куратор/заявитель сводятся к общему [AnimalContact],
/// где `extra` = адрес (куратор) либо контактные детали (заявитель).
class AnimalMapper implements Transformable<Animal> {
  const AnimalMapper(this._dto);

  final AnimalDto _dto;

  @override
  Animal toEntity() => Animal(
    id: _dto.id,
    name: _dto.name ?? '',
    shelterId: _dto.shelter,
    status: AnimalStatus.fromWire(_dto.status),
    images: _dto.images.map(_mapImage).toList(growable: false),
    attributes: _mapAttributes(_dto.animalAttributes),
    speciesId: _dto.spec?.id,
    speciesName: _dto.spec?.name,
    speciesParentName: _dto.spec?.parentName,
    speciesCategoryName: _dto.spec?.categoryName,
    birthDate: _dto.birthDate,
    dateJoined: _dto.dateJoined,
    dateOfChipping: _dto.dateOfChipping,
    chippingCode: _dto.chippingCode,
    height: _dto.height,
    weight: _dto.weight,
    placeOfCatch: _dto.placeOfCatch,
    placeOfRelease: _dto.placeOfRelease,
    curator: _mapCurator(_dto.curator),
    applicant: _mapApplicant(_dto.applicant),
    canBeShared: _dto.canBeShared ?? false,
  );

  static AnimalImage _mapImage(AnimalImageDto i) => AnimalImage(
    id: i.id,
    small: i.image.small,
    medium: i.image.medium,
    large: i.image.large,
    isPrimary: i.isPrimary ?? false,
    filename: i.filename,
  );

  static Map<String, String> _mapAttributes(List<AnimalAttributeDto> attrs) => {for (final a in attrs) a.name: a.value};

  static AnimalContact? _mapCurator(CuratorDto? c) {
    if (c == null) return null;
    return AnimalContact(
      id: c.id,
      firstName: c.firstName ?? '',
      lastName: c.lastName ?? '',
      phoneNumber: c.phoneNumber,
      email: c.email,
      extra: c.address,
    );
  }

  static AnimalContact? _mapApplicant(ApplicantDto? a) {
    if (a == null) return null;
    return AnimalContact(
      id: a.id,
      firstName: a.firstName ?? '',
      lastName: a.lastName ?? '',
      phoneNumber: a.phoneNumber,
      email: a.email,
      extra: a.contactDetails,
    );
  }
}
