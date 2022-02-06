import 'package:collection/collection.dart';

import 'package:acits_flutter/di/di_container.dart';

import 'package:acits_flutter/service/config/config_service.dart';
import 'package:acits_flutter/export.dart';
import 'package:flutter/material.dart';

extension AnimalX on AnimalRead {
  String? get statusString {
    final _service = getIt<ConfigService>();
    return _service.getStatus131Name(status);
  }

  String? get sexString {
    return animalAttributes?.firstWhereOrNull((attr) => (attr.name ?? '') == 'sex')?.value;
  }

  String? get colorString {
    return animalAttributes?.firstWhereOrNull((attr) => (attr.name ?? '') == 'color')?.value;
  }

  String? get specialSignsString {
    return animalAttributes
        ?.firstWhereOrNull((attr) => (attr.name ?? '') == 'special_signs')
        ?.value;
  }

  String? get ageString {
    if (birthDate == null) return null;
    final days = DateTime.now().difference(birthDate!).inDays;
    if (days < 30) {
      return StringRes.current.commonNDays(days, StringRes.current.commonDay);
    }
    if (days < 365) {
      return StringRes.current.commonNMonth((days / 30).floor(), StringRes.current.commonMonth);
    }
    return StringRes.current.commonNYears((days / 365).floor(), StringRes.current.commonYear);
  }

  String? get specFamily {
    return spec?['parent_name'];
  }

  String? get specKind {
    return spec?['name'];
  }

  String? get specCategory {
    return spec?['category_name'];
  }

  int? get idSpec {
    return spec?['id'];
  }

  Color get statusColor {
    switch (status) {
      case Status131Enum.released:
        return const Color(0xFF54d4d4);
      case Status131Enum.inTheShelter:
        return const Color(0xFF6775e0);
      case Status131Enum.overexposure:
        return const Color(0xFFf2984a);
      case Status131Enum.hospital:
        return const Color(0xFFa156eb);
      case Status131Enum.attached:
        return const Color(0xFF279754);
      //TODO: добавить цвета статусов
      case Status131Enum.preparingToRelease:
        return ColorRes.textSecondary;
      case Status131Enum.swaggerGeneratedUnknown:
        return ColorRes.textSecondary;
      case Status131Enum.death:
        return ColorRes.textSecondary;
      case Status131Enum.euthanasia:
        return ColorRes.textSecondary;
      default:
        return ColorRes.textSecondary;
    }
  }

  String? get curatorFullName {
    if (curator is! Map<String, dynamic>) return null;
    final data = curator as Map<String, dynamic>;
    return '${data['first_name']} ${data['last_name']}';
  }

  String? get curatorPhone {
    if (curator is! Map<String, dynamic>) return null;
    final data = curator as Map<String, dynamic>;
    return data['phone_number'];
  }

  String? get curatorEmail {
    if (curator is! Map<String, dynamic>) return null;
    final data = curator as Map<String, dynamic>;
    return data['email'];
  }

  String? get curatorAddress {
    if (curator is! Map<String, dynamic>) return null;
    final data = curator as Map<String, dynamic>;
    return data['address'];
  }

  String? get applicantFullName {
    if (applicant is! Map<String, dynamic>) return null;
    final data = applicant as Map<String, dynamic>;
    return '${data['first_name']} ${data['last_name']}';
  }

  String? get applicantPhone {
    if (applicant is! Map<String, dynamic>) return null;
    final data = applicant as Map<String, dynamic>;
    return data['phone_number'];
  }

  String? get applicantEmail {
    if (applicant is! Map<String, dynamic>) return null;
    final data = applicant as Map<String, dynamic>;
    return data['email'];
  }

  AnimalImageRead? get avatar {
    return images?.firstOrNull;
  }

  String? get thumb {
    return (avatar?.image?.small ?? avatar?.image?.medium) ?? avatar?.image?.large;
  }

  AnimalWrite get write {
    return AnimalWrite(
      name: name,
      // TODO: исправить (конверт в base64) для новых фотографий
      // images: _imageWriteList ?? [],
      images: [],
      validImages: _validImages,
      specId: spec['id'],
      status: status,
      dateJoined: dateJoined,
      birthDate: birthDate,
      deathDate: deathDate,
      deathReason: deathReason,
      placeOfCatch: placeOfCatch,
      placeOfRelease: placeOfRelease,
      dateOfChipping: dateOfChipping,
      chippingCode: chippingCode,
      height: height,
      weight: weight,
      shelter: shelter,
      curatorId: curator['id'],
      applicantId: applicant['id'],
      animalAttributes: animalAttributes,
    );
  }

  List<AnimalImageWrite>? get _imageWriteList {
    final out = images
        ?.map(
          (read) => AnimalImageWrite(
            image: read.image?.large,
            isPrimary: read.isPrimary,
            name: read.filename,
          ),
        )
        .toList();
    return out;
  }

  List<int> get _validImages {
    return images?.map<int?>((e) => e.id).whereNotNull().toList() ?? [];
  }
}

extension StatusX on Status131Enum {
  Color get statusColor {
    switch (this) {
      case Status131Enum.released:
        return const Color(0xFF54d4d4);
      case Status131Enum.inTheShelter:
        return const Color(0xFF6775e0);
      case Status131Enum.overexposure:
        return const Color(0xFFf2984a);
      case Status131Enum.hospital:
        return const Color(0xFFa156eb);
      case Status131Enum.attached:
        return const Color(0xFF279754);
      //TODO: добавить цвета статусов
      case Status131Enum.preparingToRelease:
        return ColorRes.textSecondary;
      case Status131Enum.swaggerGeneratedUnknown:
        return ColorRes.textSecondary;
      case Status131Enum.death:
        return ColorRes.textSecondary;
      case Status131Enum.euthanasia:
        return ColorRes.textSecondary;
      default:
        return ColorRes.textSecondary;
    }
  }

  String? get statusString {
    final _service = getIt<ConfigService>();
    return _service.getStatus131Name(this);
  }
}

extension CuratorX on Curator {
  String? get fullName {
    return '$firstName $lastName';
  }
}
