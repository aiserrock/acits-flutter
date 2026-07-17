import 'package:flutter/material.dart';

import 'package:animals/domain/domain.dart';

/// Цвет-заглушка для статусов без назначенного цвета. Статус-цвета — это данные
/// (не chrome темы), поэтому литералы, а не токены темы. Значения перенесены
/// из старого `AnimalX.statusColor`.
const Color _fallbackStatusColor = Color(0xFF9395A7);

/// Цвет индикатора-точки статуса в карточке списка.
extension AnimalStatusColorX on AnimalStatus {
  Color get dotColor {
    switch (this) {
      case AnimalStatus.released:
        return const Color(0xFF54D4D4);
      case AnimalStatus.inTheShelter:
        return const Color(0xFF6775E0);
      case AnimalStatus.overexposure:
        return const Color(0xFFF2984A);
      case AnimalStatus.hospital:
        return const Color(0xFFA156EB);
      case AnimalStatus.attached:
        return const Color(0xFF279754);
      case AnimalStatus.preparingToRelease:
      case AnimalStatus.death:
      case AnimalStatus.euthanasia:
      case AnimalStatus.inClinic:
      case AnimalStatus.unknown:
        return _fallbackStatusColor;
    }
  }
}
