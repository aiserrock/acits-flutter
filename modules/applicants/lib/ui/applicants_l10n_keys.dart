/// Ключи локализации, которые использует UI модуля «Заявители/кураторы».
///
/// Модуль не тянет сгенерированный `LocaleKeys` приложения (тот живёт в app),
/// но easy_localization резолвит `.tr()` по строковому ключу из бандла
/// переводов, загруженного приложением. Значения ниже совпадают со строковыми
/// значениями соответствующих `LocaleKeys.*` (ключ == значение в en/ru.json).
abstract final class ApplicantsL10nKeys {
  static const applicantEdit = 'applicantEdit';
  static const applicantAdd = 'applicantAdd';
  static const curatorEdit = 'curatorEdit';
  static const curatorAdd = 'curatorAdd';

  static const animalCuratorName = 'animalCuratorName';
  static const animalCuratorLastName = 'animalCuratorLastName';
  static const animalCuratorPhone = 'animalCuratorPhone';
  static const animalCuratorEmail = 'animalCuratorEmail';
  static const animalCuratorAddress = 'animalCuratorAddress';
  static const animalSocialLink = 'animalSocialLink';
}
