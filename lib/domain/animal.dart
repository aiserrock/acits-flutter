import 'package:acits_flutter/di/di_container.dart';

import 'package:acits_flutter/service/config/config_service.dart';
import 'package:acits_flutter/export.dart';
import 'package:flutter/material.dart';

/// Цвет-заглушка для статусов без назначенного цвета. Статус-цвета — это данные
/// (не chrome темы) и живут вне контекста темы, поэтому остаётся литералом.
const Color _fallbackStatusColor = Color(0xFF9395A7);

extension AnimalX on AnimalRead {
  String? get statusString {
    final service = getIt<ConfigService>();
    return service.getStatus131Name(status);
  }

  String? get sexString {
    return animalAttributes.firstWhereOrNull((attr) => attr.name == 'sex')?.value;
  }

  String? get colorString {
    return animalAttributes.firstWhereOrNull((attr) => attr.name == 'color')?.value;
  }

  String? get specialSignsString {
    return animalAttributes.firstWhereOrNull((attr) => attr.name == 'special_signs')?.value;
  }

  String? get ageString {
    if (birthDate == null) return null;
    final days = DateTime.now().difference(birthDate!).inDays;
    if (days < 30) {
      return LocaleKeys.commonNDays.plural(days);
    }
    if (days < 365) {
      return LocaleKeys.commonNMonth.plural((days / 30).floor());
    }
    return LocaleKeys.commonNYears.plural((days / 365).floor());
  }

  String? get specFamily {
    return spec?.parentName;
  }

  String? get specKind {
    return spec?.name;
  }

  String? get specCategory {
    return spec?.categoryName;
  }

  int? get idSpec {
    return spec?.id;
  }

  Color get statusColor {
    switch (status) {
      case Status69fEnum.released:
        return const Color(0xFF54d4d4);
      case Status69fEnum.inTheShelter:
        return const Color(0xFF6775e0);
      case Status69fEnum.overexposure:
        return const Color(0xFFf2984a);
      case Status69fEnum.hospital:
        return const Color(0xFFa156eb);
      case Status69fEnum.attached:
        return const Color(0xFF279754);
      //TODO: добавить цвета статусов
      case Status69fEnum.preparingToRelease:
        return _fallbackStatusColor;
      case Status69fEnum.swaggerGeneratedUnknown:
        return _fallbackStatusColor;
      case Status69fEnum.death:
        return _fallbackStatusColor;
      case Status69fEnum.euthanasia:
        return _fallbackStatusColor;
      default:
        return _fallbackStatusColor;
    }
  }

  String? get curatorFullName {
    final data = curator;
    if (data == null) return null;
    return '${data.firstName} ${data.lastName}';
  }

  String? get curatorPhone {
    return curator?.phoneNumber;
  }

  String? get curatorEmail {
    return curator?.email;
  }

  String? get curatorAddress {
    return curator?.address;
  }

  String? get applicantFullName {
    final data = applicant;
    if (data == null) return null;
    return '${data.firstName} ${data.lastName}';
  }

  String? get applicantPhone {
    return applicant?.phoneNumber;
  }

  String? get applicantEmail {
    return applicant?.email;
  }

  AnimalImageRead? get avatar {
    return images.firstWhereOrNull((image) => image.isPrimary ?? false) ?? images.firstOrNull;
  }

  String? get thumb {
    return (avatar?.image.small ?? avatar?.image.medium) ?? avatar?.image.large;
  }

  AnimalWrite get write {
    return AnimalWrite(
      name: name,
      // TODO: исправить (конверт в base64) для новых фотографий
      // images: _imageWriteList ?? [],
      images: [],
      validImages: _validImages,
      specId: spec?.id,
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
      curatorId: curator?.id,
      applicantId: applicant?.id,
      animalAttributes: animalAttributes,
      canBeShared: canBeShared ?? false,
    );
  }

  //ignore: unused_element
  List<AnimalImageWrite>? get _imageWriteList {
    final out = images
        .map(
          (read) => AnimalImageWrite(
            image: read.image.large,
            isPrimary: read.isPrimary,
            name: read.filename ?? '',
          ),
        )
        .toList();
    return out;
  }

  List<int> get _validImages {
    return images.map<int?>((e) => e.id).nonNulls.toList();
  }
}

extension StatusX on Status69fEnum {
  Color get statusColor {
    switch (this) {
      case Status69fEnum.released:
        return const Color(0xFF54d4d4);
      case Status69fEnum.inTheShelter:
        return const Color(0xFF6775e0);
      case Status69fEnum.overexposure:
        return const Color(0xFFf2984a);
      case Status69fEnum.hospital:
        return const Color(0xFFa156eb);
      case Status69fEnum.attached:
        return const Color(0xFF279754);
      //TODO: добавить цвета статусов
      case Status69fEnum.preparingToRelease:
        return _fallbackStatusColor;
      case Status69fEnum.swaggerGeneratedUnknown:
        return _fallbackStatusColor;
      case Status69fEnum.death:
        return _fallbackStatusColor;
      case Status69fEnum.euthanasia:
        return _fallbackStatusColor;
      case Status69fEnum.inClinic:
        return _fallbackStatusColor;
    }
  }

  String? get statusString {
    final service = getIt<ConfigService>();
    return service.getStatus131Name(this);
  }
}

extension CuratorX on Curator {
  String? get fullName {
    return '$firstName $lastName';
  }
}
