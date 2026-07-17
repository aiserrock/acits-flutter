import 'package:acits_flutter/di/di_container.dart';
import 'package:acits_flutter/domain/prescription/prescription.dart';
import 'package:acits_flutter/domain/prescription/prescription_execution_today.dart';
import 'package:acits_flutter/domain/prescription/prescription_type.dart';
import 'package:acits_flutter/gen/l10n/locale_keys.g.dart';
import 'package:acits_flutter/service/config/config_service.dart';
import 'package:easy_localization/easy_localization.dart';

// Реэкспорт доменных сущностей назначений — экраны/виджеты берут их отсюда
// (файл уже реэкспортится из export.dart).
export 'package:acits_flutter/domain/prescription/prescription_barrel.dart';

extension PrescriptionTypeX on PrescriptionType {
  /// Человекочитаемое имя типа назначения (из серверного конфига).
  String? get typeString => getIt<ConfigService>().getMyTypeName(wire);

  String get startDateLabel {
    switch (this) {
      case PrescriptionType.unknown:
        return '';
      case PrescriptionType.courseOfTreatment:
      case PrescriptionType.appointment:
      case PrescriptionType.readmission:
      case PrescriptionType.removingStitches:
      case PrescriptionType.woundHealing:
      case PrescriptionType.analysis:
      case PrescriptionType.parasitesTreatment:
      case PrescriptionType.vaccination:
      case PrescriptionType.other:
        return LocaleKeys.prescriptionCurrent.tr();
    }
  }
}

extension PrescriptionX on Prescription {
  String? get typeString => type.typeString;
}

extension PrescriptionShortEntityX on PrescriptionShortEntity {
  String? get typeString => type.typeString;
}
