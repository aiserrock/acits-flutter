/// Ключи локализации, которые использует UI модуля авторизации.
///
/// Модуль не тянет сгенерированный `LocaleKeys` приложения (тот живёт в app),
/// но easy_localization резолвит `.tr()` по строковому ключу из бандла
/// переводов, загруженного приложением. Значения ниже совпадают со строковыми
/// значениями соответствующих `LocaleKeys.*` (ключ == значение в en/ru.json).
abstract final class AuthL10nKeys {
  static const loginAuthorizeError = 'loginAuthorizeError';
  static const loginToRegistration = 'loginToRegistration';
  static const loginDescribeMsg = 'loginDescribeMsg';
  static const loginForgetPass = 'loginForgetPass';
  static const loginLoginHint = 'loginLoginHint';
  static const loginLoginLabel = 'loginLoginLabel';
  static const loginPassLabel = 'loginPassLabel';
  static const loginEntryBtn = 'loginEntryBtn';

  static const commonBegin = 'commonBegin';
  static const commonNext = 'commonNext';
  static const commonClose = 'commonClose';
  static const commonRepeat = 'commonRepeat';

  static const errorDefaultMsg = 'errorDefaultMsg';

  static const shelterSelectShelter = 'shelterSelectShelter';

  static const animalCuratorEmail = 'animalCuratorEmail';
  static const animalCuratorPhone = 'animalCuratorPhone';
  static const animalCuratorLastName = 'animalCuratorLastName';
  static const animalCuratorName = 'animalCuratorName';

  static const onboardingNewsTitle = 'onboardingNewsTitle';
  static const onboardingNewsMsg = 'onboardingNewsMsg';
  static const onboardingPlanTitle = 'onboardingPlanTitle';
  static const onboardingPlanMsg = 'onboardingPlanMsg';
  static const onboardingDrugsTitle = 'onboardingDrugsTitle';
  static const onboardingDrugsMsg = 'onboardingDrugsMsg';
  static const onboardingFreeTitle = 'onboardingFreeTitle';
  static const onboardingFreeMsg = 'onboardingFreeMsg';

  static const regOrg = 'regOrg';
  static const regUser = 'regUser';
  static const regAboutYou = 'regAboutYou';
  static const regAboutOrg = 'regAboutOrg';
  static const regAdminRegMsg = 'regAdminRegMsg';
  static const regAgreePersonalDataPart0 = 'regAgreePersonalDataPart0';
  static const regAgreePersonalDataPart1 = 'regAgreePersonalDataPart1';
  static const regCity = 'regCity';
  static const regCountry = 'regCountry';
  static const regRegion = 'regRegion';
  static const regWriteCity = 'regWriteCity';
  static const regWriteCountry = 'regWriteCountry';
  static const regWriteRegion = 'regWriteRegion';
  static const regOrgName = 'regOrgName';
  static const regFathersName = 'regFathersName';
  static const regFieldEmptyError = 'regFieldEmptyError';
  static const regLeast8Symbols = 'regLeast8Symbols';
  static const regPassSymbols = 'regPassSymbols';
  static const regPhoneMask = 'regPhoneMask';
  static const regNeedConfirmPolicy = 'regNeedConfirmPolicy';
  static const regHaveAccount = 'regHaveAccount';
  static const regEmployee = 'regEmployee';
  static const regGuest = 'regGuest';
  static const regUserRole = 'regUserRole';
  static const regTUPtitle = 'regTUPtitle';
  static const regTUPmsg = 'regTUPmsg';
  static const regEmaiConfirmation = 'regEmaiConfirmation';
  static const regEmailConfirmed = 'regEmailConfirmed';
  static const regEmailConfirmSentMsg = 'regEmailConfirmSentMsg';
  static const regRegisterRejectTitle = 'regRegisterRejectTitle';
  static const regRegisterRejectMsg = 'regRegisterRejectMsg';
}
