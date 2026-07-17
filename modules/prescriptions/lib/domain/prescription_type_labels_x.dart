import 'package:easy_localization/easy_localization.dart';
import 'package:get_it/get_it.dart';
import 'package:acits_l10n/acits_l10n.dart';

import 'package:prescriptions/domain/domain.dart';

/// UI-расширения для человекочитаемого имени типа назначения.
///
/// Имя типа резолвится через порт [PrescriptionTypeLabels] (мостится в
/// приложении к `ConfigService`). Порт берётся лениво из общего `GetIt.instance`
/// — тот же синглтон-контейнер, что и в приложении (карточки/виджеты без cubit'а
/// не могут получить порт через конструктор). Зеркалит прежний
/// `getIt<ConfigService>().getMyTypeName(...)` из app `domain/prescription.dart`.
extension PrescriptionTypeX on PrescriptionType {
  /// Человекочитаемое имя типа назначения (из серверного конфига).
  String? get typeString => GetIt.instance.isRegistered<PrescriptionTypeLabels>()
      ? GetIt.instance<PrescriptionTypeLabels>().nameForWire(wire)
      : null;

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
