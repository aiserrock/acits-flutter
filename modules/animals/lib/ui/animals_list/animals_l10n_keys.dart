/// Ключи локализации, которые использует UI списка животных.
///
/// Модуль не тянет сгенерированный `LocaleKeys` приложения (тот живёт в app),
/// но easy_localization резолвит `.tr()` по строковому ключу из бандла
/// переводов, загруженного приложением. Значения ниже совпадают со строковыми
/// значениями соответствующих `LocaleKeys.*` (ключ == значение в en/ru.json).
abstract final class AnimalsL10nKeys {
  static const commonAnimals = 'commonAnimals';
  static const commonSearch = 'commonSearch';
  static const commonNotFound = 'commonNotFound';
  static const commonError = 'commonError';
  static const commonSort = 'commonSort';
  static const commonWarning = 'commonWarning';
  static const commonDelete = 'commonDelete';
  static const commonCancel = 'commonCancel';
  static const animalsEmptyState = 'animalsEmptyState';
  static const animalAdmitted = 'animalAdmitted';
  static const animalDeleteAcceptMsg = 'animalDeleteAcceptMsg';
  static const errorDefaultMsg = 'errorDefaultMsg';

  static const sortNewest = 'sortNewest';
  static const sortOldest = 'sortOldest';
  static const sortNameAsc = 'sortNameAsc';
  static const sortNameDesc = 'sortNameDesc';
  static const sortSpec = 'sortSpec';
  static const sortStatus = 'sortStatus';
  static const sortYoung = 'sortYoung';
  static const sortOld = 'sortOld';
}
