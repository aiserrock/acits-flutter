/// Ключи локализации, которые использует UI модуля «Личный кабинет /
/// комментарии».
///
/// Модуль не тянет сгенерированный `LocaleKeys` приложения (тот живёт в app),
/// но easy_localization резолвит `.tr()` по строковому ключу из бандла
/// переводов, загруженного приложением. Значения ниже совпадают со строковыми
/// значениями соответствующих `LocaleKeys.*` (ключ == значение в en/ru.json),
/// как в modules/auth / modules/animals / modules/prescriptions.
abstract final class PersonalL10nKeys {
  // Личный кабинет
  static const personMyData = 'personMyData';
  static const loginLoginLabel = 'loginLoginLabel';
  static const loginPassLabel = 'loginPassLabel';
  static const animalCuratorName = 'animalCuratorName';
  static const animalCuratorLastName = 'animalCuratorLastName';
  static const animalCuratorPhone = 'animalCuratorPhone';
  static const animalCuratorEmail = 'animalCuratorEmail';
  static const regFathersName = 'regFathersName';
  static const commonLanguage = 'commonLanguage';

  // Смена пароля
  static const personalChangePass = 'personalChangePass';
  static const personalOldPass = 'personalOldPass';
  static const personalNewPass = 'personalNewPass';
  static const personalRePass = 'personalRePass';
  static const personalEmptyFieldErrorMsg = 'personalEmptyFieldErrorMsg';
  static const personalPassChanged = 'personalPassChanged';
  static const personalChangeErrorMsg = 'personalChangeErrorMsg';
  static const commonCancel = 'commonCancel';
  static const commonEdit = 'commonEdit';

  // Комментарии
  static const commentTitleEdit = 'commentTitleEdit';
  static const commentTitleNew = 'commentTitleNew';
  static const commentDeletingFail = 'commentDeletingFail';
  static const commonDelete = 'commonDelete';
  static const commonReloadBtn = 'commonReloadBtn';
  static const commonErrorStubMsg = 'commonErrorStubMsg';
  static const commonErrorTryAgainMessage = 'commonErrorTryAgainMessage';
  static const commonNoAppToOpenFileMsg = 'commonNoAppToOpenFileMsg';
}
