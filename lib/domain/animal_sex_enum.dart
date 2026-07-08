import 'package:acits_flutter/gen/l10n/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';

enum AnimalGender { male, female, middle, genderless, undefined }

extension AnimalGenderX on AnimalGender {
  String get value {
    switch (this) {
      case AnimalGender.male:
        return LocaleKeys.animalGenderMale.tr();
      case AnimalGender.female:
        return LocaleKeys.animalGenderFemale.tr();
      case AnimalGender.middle:
        return LocaleKeys.animalGenderMiddle.tr();
      case AnimalGender.genderless:
        return LocaleKeys.animalGenderLess.tr();
      case AnimalGender.undefined:
        return LocaleKeys.animalGenderUndefined.tr();
    }
  }
}
