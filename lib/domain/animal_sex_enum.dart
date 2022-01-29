import 'package:acits_flutter/generated/l10n.dart';

enum AnimalGender {
  male,
  female,
  middle,
  genderless,
  undefined,
}

extension AnimalGenderX on AnimalGender {
  String get value {
    switch (this) {
      case AnimalGender.male:
        return StringRes.current.animalGenderMale;
      case AnimalGender.female:
        return StringRes.current.animalGenderFemale;
      case AnimalGender.middle:
        return StringRes.current.animalGenderMiddle;
      case AnimalGender.genderless:
        return StringRes.current.animalGenderLess;
      case AnimalGender.undefined:
        return StringRes.current.animalGenderUndefined;
    }
  }
}
