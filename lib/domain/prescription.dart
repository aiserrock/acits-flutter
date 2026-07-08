import 'package:acits_flutter/api/openapi.swagger.dart';
import 'package:acits_flutter/di/di_container.dart';
import 'package:acits_flutter/generated/locale_keys.g.dart';
import 'package:acits_flutter/service/config/config_service.dart';
import 'package:easy_localization/easy_localization.dart';

extension PrescriptionShortX on PrescriptionShort {
  String? get typeString {
    final service = getIt<ConfigService>();
    return service.getMyTypeName(myType);
  }
}

extension MyTypeEnumX on MyTypeEnum {
  String? get typeString {
    final service = getIt<ConfigService>();
    return service.getMyTypeName(this);
  }

  String get startDateLabel {
    switch (this) {
      case MyTypeEnum.courseOfTreatment:
        return LocaleKeys.prescriptionCurrent.tr();
      case MyTypeEnum.swaggerGeneratedUnknown:
        return '';
      case MyTypeEnum.appointment:
        return LocaleKeys.prescriptionCurrent.tr();
      case MyTypeEnum.readmission:
        return LocaleKeys.prescriptionCurrent.tr();
      case MyTypeEnum.removingStitches:
        return LocaleKeys.prescriptionCurrent.tr();
      case MyTypeEnum.woundHealing:
        return LocaleKeys.prescriptionCurrent.tr();
      case MyTypeEnum.analysis:
        return LocaleKeys.prescriptionCurrent.tr();
    }
  }
}
