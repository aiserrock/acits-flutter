/// Ключи локализации, которые использует UI модуля «Назначения».
///
/// Модуль не тянет сгенерированный `LocaleKeys` приложения (тот живёт в app),
/// но easy_localization резолвит `.tr()` по строковому ключу из бандла
/// переводов, загруженного приложением. Значения ниже совпадают со строковыми
/// значениями соответствующих `LocaleKeys.*` (ключ == значение в en/ru.json),
/// как в modules/auth / modules/animals / modules/applicants.
abstract final class PrescriptionsL10nKeys {
  static const prescriptionTitleAdd = 'prescriptionTitleAdd';
  static const prescriptionTitleEdit = 'prescriptionTitleEdit';
  static const prescriptionAnimal = 'prescriptionAnimal';
  static const prescriptionComment = 'prescriptionComment';
  static const prescriptionDrug = 'prescriptionDrug';
  static const prescriptionDate = 'prescriptionDate';
  static const prescriptionTime = 'prescriptionTime';
  static const prescriptionDaily = 'prescriptionDaily';
  static const prescriptionWeekly = 'prescriptionWeekly';
  static const prescriptionCurrent = 'prescriptionCurrent';
  static const prescriptionPast = 'prescriptionPast';
  static const prescriptionPickAnimalMsg = 'prescriptionPickAnimalMsg';
  static const prescriptionCantChangeAnimalMsg = 'prescriptionCantChangeAnimalMsg';
  static const prescriptionWaitLoadingMsg = 'prescriptionWaitLoadingMsg';

  static const animalPrescriptions = 'animalPrescriptions';
  static const animalComments = 'animalComments';

  static const mainAnimal = 'mainAnimal';
  static const mainAppoinment = 'mainAppoinment';
  static const mainAppoinmentAuthor = 'mainAppoinmentAuthor';

  static const commonAccept = 'commonAccept';
  static const commonDone = 'commonDone';
  static const commonReschedule = 'commonReschedule';
  static const commonNotCompleted = 'commonNotCompleted';
  static const commonEdit = 'commonEdit';
  static const commonDelete = 'commonDelete';
}
