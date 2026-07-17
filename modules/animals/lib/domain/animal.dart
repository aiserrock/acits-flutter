import 'package:equatable/equatable.dart';

import 'package:animals/domain/domain.dart';

/// Полная сущность животного для карточки/редактирования.
///
/// Строковые атрибуты API (sex/color/special_signs) уже разобраны в [attributes]
/// (name → value) на этапе маппинга — домен не знает про wire-форму.
class Animal extends Equatable {
  const Animal({
    required this.id,
    required this.name,
    required this.shelterId,
    required this.status,
    required this.images,
    required this.attributes,
    this.speciesId,
    this.speciesName,
    this.speciesParentName,
    this.speciesCategoryName,
    this.birthDate,
    this.dateJoined,
    this.dateOfChipping,
    this.chippingCode,
    this.height,
    this.weight,
    this.placeOfCatch,
    this.placeOfRelease,
    this.curator,
    this.applicant,
    this.canBeShared = false,
  });

  final int id;
  final String name;
  final int shelterId;
  final AnimalStatus status;
  final List<AnimalImage> images;
  final Map<String, String> attributes;
  final int? speciesId;
  final String? speciesName;
  final String? speciesParentName;
  final String? speciesCategoryName;
  final DateTime? birthDate;
  final DateTime? dateJoined;
  final DateTime? dateOfChipping;
  final String? chippingCode;
  final String? height;
  final String? weight;
  final String? placeOfCatch;
  final String? placeOfRelease;
  final AnimalContact? curator;
  final AnimalContact? applicant;
  final bool canBeShared;

  AnimalImage? get avatar {
    for (final image in images) {
      if (image.isPrimary) return image;
    }
    return images.isEmpty ? null : images.first;
  }

  String? get thumb => avatar?.thumb;
  String? get sex => attributes['sex'];
  String? get color => attributes['color'];
  String? get specialSigns => attributes['special_signs'];

  @override
  List<Object?> get props => [
    id,
    name,
    shelterId,
    status,
    images,
    attributes,
    speciesId,
    speciesName,
    speciesParentName,
    speciesCategoryName,
    birthDate,
    dateJoined,
    dateOfChipping,
    chippingCode,
    height,
    weight,
    placeOfCatch,
    placeOfRelease,
    curator,
    applicant,
    canBeShared,
  ];
}
