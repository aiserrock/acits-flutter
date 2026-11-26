import 'package:equatable/equatable.dart';

import 'animal_sex.dart';
import 'applicant.dart';
import 'curator.dart';

/// Доменная сущность животного. Плоская и wire-независимая: строковые атрибуты
/// (sex/color/special_signs) и статусы из API уже разобраны в поля на этапе
/// маппинга (feature.data), домен ими не занимается.
class Animal extends Equatable {
  const Animal({
    required this.id,
    required this.name,
    required this.shelterId,
    required this.dateJoined,
    required this.sex,
    this.thumbUrl,
    this.speciesName,
    this.statusCode,
    this.birthDate,
    this.chippingCode,
    this.curator,
    this.applicant,
    this.canBeShared = false,
  });

  final int id;
  final String name;
  final int shelterId;
  final DateTime dateJoined;
  final AnimalSex sex;
  final String? thumbUrl;
  final String? speciesName;
  final String? statusCode;
  final DateTime? birthDate;
  final String? chippingCode;
  final Curator? curator;
  final Applicant? applicant;
  final bool canBeShared;

  @override
  List<Object?> get props => [
    id,
    name,
    shelterId,
    dateJoined,
    sex,
    thumbUrl,
    speciesName,
    statusCode,
    birthDate,
    chippingCode,
    curator,
    applicant,
    canBeShared,
  ];
}
