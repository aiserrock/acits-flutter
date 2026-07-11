import 'package:acits_flutter/gen/api/openapi.swagger.dart';
import 'package:acits_flutter/di/di_container.dart';
import 'package:acits_flutter/gen/l10n/locale_keys.g.dart';
import 'package:acits_flutter/service/config/config_service.dart';
import 'package:easy_localization/easy_localization.dart';

extension PrescriptionShortX on PrescriptionShort {
  String? get typeString {
    final service = getIt<ConfigService>();
    return service.getMyTypeName(myType);
  }
}

extension PrescriptionShortMyTypeEnumX on PrescriptionShortMyTypeEnum {
  String? get typeString {
    final service = getIt<ConfigService>();
    return service.getMyTypeName(this);
  }

  String get startDateLabel {
    switch (this) {
      case PrescriptionShortMyTypeEnum.swaggerGeneratedUnknown:
        return '';
      case PrescriptionShortMyTypeEnum.courseOfTreatment:
      case PrescriptionShortMyTypeEnum.appointment:
      case PrescriptionShortMyTypeEnum.readmission:
      case PrescriptionShortMyTypeEnum.removingStitches:
      case PrescriptionShortMyTypeEnum.woundHealing:
      case PrescriptionShortMyTypeEnum.analysis:
      case PrescriptionShortMyTypeEnum.parasitesTreatment:
      case PrescriptionShortMyTypeEnum.vaccination:
      case PrescriptionShortMyTypeEnum.other:
        return LocaleKeys.prescriptionCurrent.tr();
    }
  }
}
