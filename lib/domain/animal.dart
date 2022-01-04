import 'package:acits_flutter/di/di_container.dart';

import 'package:acits_flutter/service/config/config_service.dart';
import 'package:acits_flutter/export.dart';
import 'package:flutter/material.dart';

extension AnimalX on Animal {
  String? get statusString {
    final _service = getIt<ConfigService>();
    return _service.getStatus131Name(status);
  }

  String? get sexString {
    return animalAttributes
        ?.firstWhereOrNull((attr) => (attr.name ?? '') == 'sex')
        ?.value;
  }
  String? get colorString {
    return animalAttributes
        ?.firstWhereOrNull((attr) => (attr.name ?? '') == 'color')
        ?.value;
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
      return StringRes.current
          .commonNMonth((days / 30).floor(), StringRes.current.commonMonth);
    }
    return StringRes.current
        .commonNYears((days / 365).floor(), StringRes.current.commonYear);
  }

  String? get specFamily {
    return spec['parent_name'];
  }

  String? get specKind {
    return spec['name'];
  }

  String? get specCategory {
    return spec['category_name'];
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
}
