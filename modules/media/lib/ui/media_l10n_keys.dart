/// Ключи локализации, которые использует UI медиа-модуля (галерея, поиск).
///
/// Модуль не тянет сгенерированный `LocaleKeys` приложения (тот живёт в app),
/// но easy_localization резолвит `.tr()` по строковому ключу из бандла
/// переводов, загруженного приложением. Значения ниже совпадают со строковыми
/// значениями соответствующих `LocaleKeys.*` (ключ == значение в en/ru.json),
/// как в modules/auth / modules/animals / modules/applicants / modules/prescriptions.
abstract final class MediaL10nKeys {
  static const commonNotFound = 'commonNotFound';
  static const commonError = 'commonError';
  static const animalMaxImagesCountIs = 'animalMaxImagesCountIs';
}
