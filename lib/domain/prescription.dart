import 'package:acits_flutter/api/openapi.swagger.dart';
import 'package:acits_flutter/di/di_container.dart';
import 'package:acits_flutter/generated/l10n.dart';
import 'package:acits_flutter/service/config/config_service.dart';

extension PrescriptionShortX on PrescriptionShort {
  String? get typeString {
    final _service = getIt<ConfigService>();
    return _service.getMyTypeName(myType);
  }
}

extension MyTypeEnumX on MyTypeEnum {

  String? get typeString {
    final _service = getIt<ConfigService>();
    return _service.getMyTypeName(this);
  }

  String get startDateLabel {
    switch (this) {
      case MyTypeEnum.courseOfTreatment:
        return StringRes.current.prescriptionCurrent;
      case MyTypeEnum.swaggerGeneratedUnknown:
        return '';
      case MyTypeEnum.appointment:
        return StringRes.current.prescriptionCurrent;
      case MyTypeEnum.readmission:
        return StringRes.current.prescriptionCurrent;
      case MyTypeEnum.removingStitches:
        return StringRes.current.prescriptionCurrent;
      case MyTypeEnum.woundHealing:
        return StringRes.current.prescriptionCurrent;
      case MyTypeEnum.analysis:
        return StringRes.current.prescriptionCurrent;
    }
  }
}
