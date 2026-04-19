import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_ru.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('ru'),
  ];

  /// No description provided for @animalAdd.
  ///
  /// In ru, this message translates to:
  /// **'Новое животное '**
  String get animalAdd;

  /// No description provided for @animalAdditionalInfo.
  ///
  /// In ru, this message translates to:
  /// **'Дополнительная информация'**
  String get animalAdditionalInfo;

  /// No description provided for @animalAdmitted.
  ///
  /// In ru, this message translates to:
  /// **'Поступил'**
  String get animalAdmitted;

  /// No description provided for @animalAge.
  ///
  /// In ru, this message translates to:
  /// **'Возраст'**
  String get animalAge;

  /// No description provided for @animalAgeAppox.
  ///
  /// In ru, this message translates to:
  /// **'Примерный'**
  String get animalAgeAppox;

  /// No description provided for @animalAgeExact.
  ///
  /// In ru, this message translates to:
  /// **'Точный'**
  String get animalAgeExact;

  /// No description provided for @animalAnimalFamily.
  ///
  /// In ru, this message translates to:
  /// **'Семейство животного'**
  String get animalAnimalFamily;

  /// No description provided for @animalAnimalKind.
  ///
  /// In ru, this message translates to:
  /// **'Вид животного'**
  String get animalAnimalKind;

  /// No description provided for @animalAnimalStatus.
  ///
  /// In ru, this message translates to:
  /// **'Статус животного'**
  String get animalAnimalStatus;

  /// No description provided for @animalApplicant.
  ///
  /// In ru, this message translates to:
  /// **'Заявитель'**
  String get animalApplicant;

  /// No description provided for @animalBirth.
  ///
  /// In ru, this message translates to:
  /// **'Дата рождения'**
  String get animalBirth;

  /// No description provided for @animalCardTitle.
  ///
  /// In ru, this message translates to:
  /// **'Карточка животного'**
  String get animalCardTitle;

  /// No description provided for @animalCatchPlace.
  ///
  /// In ru, this message translates to:
  /// **'Место отлова'**
  String get animalCatchPlace;

  /// No description provided for @animalCategory.
  ///
  /// In ru, this message translates to:
  /// **'Категория'**
  String get animalCategory;

  /// No description provided for @animalChip.
  ///
  /// In ru, this message translates to:
  /// **'Кольцо/чип'**
  String get animalChip;

  /// No description provided for @animalChipDate.
  ///
  /// In ru, this message translates to:
  /// **'Дата чипирования'**
  String get animalChipDate;

  /// No description provided for @animalColor.
  ///
  /// In ru, this message translates to:
  /// **'Окрас'**
  String get animalColor;

  /// No description provided for @animalComments.
  ///
  /// In ru, this message translates to:
  /// **'Комментарии'**
  String get animalComments;

  /// No description provided for @animalCommonInfo.
  ///
  /// In ru, this message translates to:
  /// **'Основная информация'**
  String get animalCommonInfo;

  /// No description provided for @animalCurator.
  ///
  /// In ru, this message translates to:
  /// **'Куратор'**
  String get animalCurator;

  /// No description provided for @animalCuratorAddress.
  ///
  /// In ru, this message translates to:
  /// **'Адрес'**
  String get animalCuratorAddress;

  /// No description provided for @animalCuratorEmail.
  ///
  /// In ru, this message translates to:
  /// **'E-mail'**
  String get animalCuratorEmail;

  /// No description provided for @animalCuratorLastName.
  ///
  /// In ru, this message translates to:
  /// **'Фамилия'**
  String get animalCuratorLastName;

  /// No description provided for @animalCuratorName.
  ///
  /// In ru, this message translates to:
  /// **'Имя'**
  String get animalCuratorName;

  /// No description provided for @animalCuratorPhone.
  ///
  /// In ru, this message translates to:
  /// **'Номер телефона'**
  String get animalCuratorPhone;

  /// No description provided for @animalDateAdmitt.
  ///
  /// In ru, this message translates to:
  /// **'Дата поступления'**
  String get animalDateAdmitt;

  /// No description provided for @animalDeleteAcceptMsg.
  ///
  /// In ru, this message translates to:
  /// **'Вы уверены, что хотите удалить'**
  String get animalDeleteAcceptMsg;

  /// No description provided for @animalEdit.
  ///
  /// In ru, this message translates to:
  /// **'Редактировать'**
  String get animalEdit;

  /// No description provided for @animalFamily.
  ///
  /// In ru, this message translates to:
  /// **'Семейство'**
  String get animalFamily;

  /// No description provided for @animalGenderFemale.
  ///
  /// In ru, this message translates to:
  /// **'Женский'**
  String get animalGenderFemale;

  /// No description provided for @animalGenderLess.
  ///
  /// In ru, this message translates to:
  /// **'Без пола'**
  String get animalGenderLess;

  /// No description provided for @animalGenderMale.
  ///
  /// In ru, this message translates to:
  /// **'Мужской'**
  String get animalGenderMale;

  /// No description provided for @animalGenderMiddle.
  ///
  /// In ru, this message translates to:
  /// **'Средний'**
  String get animalGenderMiddle;

  /// No description provided for @animalGenderUndefined.
  ///
  /// In ru, this message translates to:
  /// **'Неизвестен'**
  String get animalGenderUndefined;

  /// No description provided for @animalKind.
  ///
  /// In ru, this message translates to:
  /// **'Вид'**
  String get animalKind;

  /// No description provided for @animalMaxImagesCountIs.
  ///
  /// In ru, this message translates to:
  /// **'Максимальное число фото не должно превышать '**
  String get animalMaxImagesCountIs;

  /// No description provided for @animalName.
  ///
  /// In ru, this message translates to:
  /// **'Кличка'**
  String get animalName;

  /// No description provided for @animalPickCurator.
  ///
  /// In ru, this message translates to:
  /// **'Выбрать куратора'**
  String get animalPickCurator;

  /// No description provided for @animalPrescriptions.
  ///
  /// In ru, this message translates to:
  /// **'Назначения'**
  String get animalPrescriptions;

  /// No description provided for @animalQtyMonth.
  ///
  /// In ru, this message translates to:
  /// **'Кол-во месяцев'**
  String get animalQtyMonth;

  /// No description provided for @animalQtyYear.
  ///
  /// In ru, this message translates to:
  /// **'Кол-во лет'**
  String get animalQtyYear;

  /// No description provided for @animalReceiptDate.
  ///
  /// In ru, this message translates to:
  /// **'Дата поступления'**
  String get animalReceiptDate;

  /// No description provided for @animalSex.
  ///
  /// In ru, this message translates to:
  /// **'Пол'**
  String get animalSex;

  /// No description provided for @animalSocialLink.
  ///
  /// In ru, this message translates to:
  /// **'Ссылка на соцсети'**
  String get animalSocialLink;

  /// No description provided for @animalSpecSigns.
  ///
  /// In ru, this message translates to:
  /// **'Особые приметы'**
  String get animalSpecSigns;

  /// No description provided for @animalStatus.
  ///
  /// In ru, this message translates to:
  /// **'Статус'**
  String get animalStatus;

  /// No description provided for @animalStatusAndJoin.
  ///
  /// In ru, this message translates to:
  /// **'Статус и поступление'**
  String get animalStatusAndJoin;

  /// No description provided for @animalTransferAct.
  ///
  /// In ru, this message translates to:
  /// **'Акт приема-передачи'**
  String get animalTransferAct;

  /// No description provided for @animalUploadAct.
  ///
  /// In ru, this message translates to:
  /// **'Загрузить акт приема-передачи'**
  String get animalUploadAct;

  /// No description provided for @animalWeight.
  ///
  /// In ru, this message translates to:
  /// **'Вес, кг'**
  String get animalWeight;

  /// No description provided for @aninmalSize.
  ///
  /// In ru, this message translates to:
  /// **'Рост, см'**
  String get aninmalSize;

  /// No description provided for @applicantAdd.
  ///
  /// In ru, this message translates to:
  /// **'Новый заявитель'**
  String get applicantAdd;

  /// No description provided for @applicantEdit.
  ///
  /// In ru, this message translates to:
  /// **'Редактировать'**
  String get applicantEdit;

  /// No description provided for @commentDeletingFail.
  ///
  /// In ru, this message translates to:
  /// **'Не удалось удалить комментарий'**
  String get commentDeletingFail;

  /// No description provided for @commentTitleEdit.
  ///
  /// In ru, this message translates to:
  /// **'Редактирование'**
  String get commentTitleEdit;

  /// No description provided for @commentTitleNew.
  ///
  /// In ru, this message translates to:
  /// **'Новый комментарий'**
  String get commentTitleNew;

  /// No description provided for @common.
  ///
  /// In ru, this message translates to:
  /// **'общий'**
  String get common;

  /// No description provided for @commonAdd.
  ///
  /// In ru, this message translates to:
  /// **'Добавить'**
  String get commonAdd;

  /// No description provided for @commonAnimals.
  ///
  /// In ru, this message translates to:
  /// **'Животные'**
  String get commonAnimals;

  /// No description provided for @commonBegin.
  ///
  /// In ru, this message translates to:
  /// **'Начать'**
  String get commonBegin;

  /// No description provided for @commonCalendar.
  ///
  /// In ru, this message translates to:
  /// **'Календарь'**
  String get commonCalendar;

  /// No description provided for @commonCancel.
  ///
  /// In ru, this message translates to:
  /// **'Отмена'**
  String get commonCancel;

  /// No description provided for @commonClose.
  ///
  /// In ru, this message translates to:
  /// **'Закрыть'**
  String get commonClose;

  /// No description provided for @commonDay.
  ///
  /// In ru, this message translates to:
  /// **'день'**
  String get commonDay;

  /// No description provided for @commonDelete.
  ///
  /// In ru, this message translates to:
  /// **'Удалить'**
  String get commonDelete;

  /// No description provided for @commonDidNotImpl.
  ///
  /// In ru, this message translates to:
  /// **'Пока не реализовано :('**
  String get commonDidNotImpl;

  /// No description provided for @commonDone.
  ///
  /// In ru, this message translates to:
  /// **'Выполнено'**
  String get commonDone;

  /// No description provided for @commonDrugs.
  ///
  /// In ru, this message translates to:
  /// **'Медикаменты'**
  String get commonDrugs;

  /// No description provided for @commonEdit.
  ///
  /// In ru, this message translates to:
  /// **'Редактировать'**
  String get commonEdit;

  /// No description provided for @commonError.
  ///
  /// In ru, this message translates to:
  /// **'Ошибка'**
  String get commonError;

  /// No description provided for @commonErrorStubMsg.
  ///
  /// In ru, this message translates to:
  /// **'Не удалось загрузить данные.\nПожалуйста, попробуйте еще раз.'**
  String get commonErrorStubMsg;

  /// No description provided for @commonErrorStubTitle.
  ///
  /// In ru, this message translates to:
  /// **'Ой, что-то пошло не так...'**
  String get commonErrorStubTitle;

  /// No description provided for @commonErrorTryAgainMessage.
  ///
  /// In ru, this message translates to:
  /// **'Произошла ошибка. Попробуйте позже.'**
  String get commonErrorTryAgainMessage;

  /// No description provided for @commonLoading.
  ///
  /// In ru, this message translates to:
  /// **'Загрузка'**
  String get commonLoading;

  /// No description provided for @commonMonth.
  ///
  /// In ru, this message translates to:
  /// **'месяц'**
  String get commonMonth;

  /// No description provided for @commonNDays.
  ///
  /// In ru, this message translates to:
  /// **'{count,plural, =0{0 дней} =1{{count} {day}} =2{{count} дня} few{{count} дней} other{{count} дней}}'**
  String commonNDays(int count, Object day);

  /// No description provided for @commonNMonth.
  ///
  /// In ru, this message translates to:
  /// **'{count,plural, =0{0 месяцев} =1{{count} {month}} =2{{count} {month}а} few{{count} месяцев} other{{count} месяцев}}'**
  String commonNMonth(int count, Object month);

  /// No description provided for @commonNYears.
  ///
  /// In ru, this message translates to:
  /// **'{count,plural, =0{0 лет} =1{{count} {year}} =2{{count} {year}а} few{{count} лет} other{{count} лет}}'**
  String commonNYears(int count, Object year);

  /// No description provided for @commonNext.
  ///
  /// In ru, this message translates to:
  /// **'Далее'**
  String get commonNext;

  /// No description provided for @commonNoAppToOpenFileMsg.
  ///
  /// In ru, this message translates to:
  /// **'Нет подходящего приложения для открытия этого файла :('**
  String get commonNoAppToOpenFileMsg;

  /// No description provided for @commonNotCompleted.
  ///
  /// In ru, this message translates to:
  /// **'Не выполнено'**
  String get commonNotCompleted;

  /// No description provided for @commonNotFound.
  ///
  /// In ru, this message translates to:
  /// **'Ничего не нашлось :('**
  String get commonNotFound;

  /// No description provided for @commonReloadBtn.
  ///
  /// In ru, this message translates to:
  /// **'Обновить'**
  String get commonReloadBtn;

  /// No description provided for @commonRepeat.
  ///
  /// In ru, this message translates to:
  /// **'Повторить'**
  String get commonRepeat;

  /// No description provided for @commonReschedule.
  ///
  /// In ru, this message translates to:
  /// **'Перенести'**
  String get commonReschedule;

  /// No description provided for @commonSearch.
  ///
  /// In ru, this message translates to:
  /// **'Поиск'**
  String get commonSearch;

  /// No description provided for @commonShare.
  ///
  /// In ru, this message translates to:
  /// **'Поделиться'**
  String get commonShare;

  /// No description provided for @commonSort.
  ///
  /// In ru, this message translates to:
  /// **'Сортировка'**
  String get commonSort;

  /// No description provided for @commonToday.
  ///
  /// In ru, this message translates to:
  /// **'Сегодня'**
  String get commonToday;

  /// No description provided for @commonWarning.
  ///
  /// In ru, this message translates to:
  /// **'Внимание'**
  String get commonWarning;

  /// No description provided for @commonYear.
  ///
  /// In ru, this message translates to:
  /// **'год'**
  String get commonYear;

  /// No description provided for @curatorAdd.
  ///
  /// In ru, this message translates to:
  /// **'Новый куратор'**
  String get curatorAdd;

  /// No description provided for @curatorEdit.
  ///
  /// In ru, this message translates to:
  /// **'Редактирование'**
  String get curatorEdit;

  /// No description provided for @errorDefaultMsg.
  ///
  /// In ru, this message translates to:
  /// **'Что-то пошло не так, попробуйте еще раз позже'**
  String get errorDefaultMsg;

  /// No description provided for @errorInternetFail.
  ///
  /// In ru, this message translates to:
  /// **'Нет интернета :('**
  String get errorInternetFail;

  /// No description provided for @errorInternetFailMsg.
  ///
  /// In ru, this message translates to:
  /// **'Неустойчивое соединение, попробуйте еще раз позже'**
  String get errorInternetFailMsg;

  /// No description provided for @loginAuthorizeError.
  ///
  /// In ru, this message translates to:
  /// **'Неверный логин или пароль'**
  String get loginAuthorizeError;

  /// No description provided for @loginDescribeMsg.
  ///
  /// In ru, this message translates to:
  /// **'ACITS – Система контроля за животными\nвнутри организации'**
  String get loginDescribeMsg;

  /// No description provided for @loginEntryBtn.
  ///
  /// In ru, this message translates to:
  /// **'Войти'**
  String get loginEntryBtn;

  /// No description provided for @loginForgetPass.
  ///
  /// In ru, this message translates to:
  /// **'Забыли пароль?'**
  String get loginForgetPass;

  /// No description provided for @loginLoginHint.
  ///
  /// In ru, this message translates to:
  /// **'Введите почту или логин'**
  String get loginLoginHint;

  /// No description provided for @loginLoginLabel.
  ///
  /// In ru, this message translates to:
  /// **'Логин'**
  String get loginLoginLabel;

  /// No description provided for @loginPassLabel.
  ///
  /// In ru, this message translates to:
  /// **'Пароль'**
  String get loginPassLabel;

  /// No description provided for @loginToRegistration.
  ///
  /// In ru, this message translates to:
  /// **'Зарегистрироваться'**
  String get loginToRegistration;

  /// No description provided for @mainAddAppointments.
  ///
  /// In ru, this message translates to:
  /// **'Добавить назначение'**
  String get mainAddAppointments;

  /// No description provided for @mainAnimal.
  ///
  /// In ru, this message translates to:
  /// **'Животное'**
  String get mainAnimal;

  /// No description provided for @mainAppoinment.
  ///
  /// In ru, this message translates to:
  /// **'Назначение'**
  String get mainAppoinment;

  /// No description provided for @mainAppoinmentAuthor.
  ///
  /// In ru, this message translates to:
  /// **'Автор назначения'**
  String get mainAppoinmentAuthor;

  /// No description provided for @mainAppointments.
  ///
  /// In ru, this message translates to:
  /// **'Назначения'**
  String get mainAppointments;

  /// No description provided for @mainEmptyState.
  ///
  /// In ru, this message translates to:
  /// **'На сегодня назначений нет'**
  String get mainEmptyState;

  /// No description provided for @mainTitle.
  ///
  /// In ru, this message translates to:
  /// **'Сегодня'**
  String get mainTitle;

  /// No description provided for @onboardingDrugsMsg.
  ///
  /// In ru, this message translates to:
  /// **'Мы заранее подготовили максимальное количество медицинских назначений для организаций'**
  String get onboardingDrugsMsg;

  /// No description provided for @onboardingDrugsTitle.
  ///
  /// In ru, this message translates to:
  /// **'Гибкая система работы с назначениями'**
  String get onboardingDrugsTitle;

  /// No description provided for @onboardingFreeMsg.
  ///
  /// In ru, this message translates to:
  /// **'Весь функционал будет доступен для Вас в полном объеме, без ограничений'**
  String get onboardingFreeMsg;

  /// No description provided for @onboardingFreeTitle.
  ///
  /// In ru, this message translates to:
  /// **'Абсолютно бесплатно'**
  String get onboardingFreeTitle;

  /// No description provided for @onboardingNewsMsg.
  ///
  /// In ru, this message translates to:
  /// **'Карта ведется на протяжении всей жизни животного и не зависит от организации'**
  String get onboardingNewsMsg;

  /// No description provided for @onboardingNewsTitle.
  ///
  /// In ru, this message translates to:
  /// **'Единая карта животного'**
  String get onboardingNewsTitle;

  /// No description provided for @onboardingPlanMsg.
  ///
  /// In ru, this message translates to:
  /// **'Позволяет четко планировать рабочее время и своевременно оказывать медицинскую помощь животным'**
  String get onboardingPlanMsg;

  /// No description provided for @onboardingPlanTitle.
  ///
  /// In ru, this message translates to:
  /// **'Сводка назначений на текущий день'**
  String get onboardingPlanTitle;

  /// No description provided for @personChangePass.
  ///
  /// In ru, this message translates to:
  /// **'Сменить пароль'**
  String get personChangePass;

  /// No description provided for @personChangeShelter.
  ///
  /// In ru, this message translates to:
  /// **'Сменить организацию'**
  String get personChangeShelter;

  /// No description provided for @personFeedback.
  ///
  /// In ru, this message translates to:
  /// **'Обратная связь'**
  String get personFeedback;

  /// No description provided for @personLogout.
  ///
  /// In ru, this message translates to:
  /// **'Выйти'**
  String get personLogout;

  /// No description provided for @personMyData.
  ///
  /// In ru, this message translates to:
  /// **'Мои данные'**
  String get personMyData;

  /// No description provided for @personMyShelters.
  ///
  /// In ru, this message translates to:
  /// **'Мои организации'**
  String get personMyShelters;

  /// No description provided for @personalChangeErrorMsg.
  ///
  /// In ru, this message translates to:
  /// **'Не удалось изменить пароль\n'**
  String get personalChangeErrorMsg;

  /// No description provided for @personalChangePass.
  ///
  /// In ru, this message translates to:
  /// **'Изменить пароль'**
  String get personalChangePass;

  /// No description provided for @personalEmptyFieldErrorMsg.
  ///
  /// In ru, this message translates to:
  /// **'Заполните значения'**
  String get personalEmptyFieldErrorMsg;

  /// No description provided for @personalNewPass.
  ///
  /// In ru, this message translates to:
  /// **' Новый пароль'**
  String get personalNewPass;

  /// No description provided for @personalOldPass.
  ///
  /// In ru, this message translates to:
  /// **' Старый пароль'**
  String get personalOldPass;

  /// No description provided for @personalPassChanged.
  ///
  /// In ru, this message translates to:
  /// **'Пароль успешно изменен'**
  String get personalPassChanged;

  /// No description provided for @personalRePass.
  ///
  /// In ru, this message translates to:
  /// **' Повторить пароль'**
  String get personalRePass;

  /// No description provided for @prescriptionAnimal.
  ///
  /// In ru, this message translates to:
  /// **'Животное*'**
  String get prescriptionAnimal;

  /// No description provided for @prescriptionCantChangeAnimalMsg.
  ///
  /// In ru, this message translates to:
  /// **'Нельзя изменить животное при редактировании назначения'**
  String get prescriptionCantChangeAnimalMsg;

  /// No description provided for @prescriptionComment.
  ///
  /// In ru, this message translates to:
  /// **'Комментарий'**
  String get prescriptionComment;

  /// No description provided for @prescriptionCurrent.
  ///
  /// In ru, this message translates to:
  /// **'Текущие'**
  String get prescriptionCurrent;

  /// No description provided for @prescriptionDaily.
  ///
  /// In ru, this message translates to:
  /// **'Ежедневно'**
  String get prescriptionDaily;

  /// No description provided for @prescriptionDate.
  ///
  /// In ru, this message translates to:
  /// **'Дата'**
  String get prescriptionDate;

  /// No description provided for @prescriptionDrug.
  ///
  /// In ru, this message translates to:
  /// **'Лекарство'**
  String get prescriptionDrug;

  /// No description provided for @prescriptionPast.
  ///
  /// In ru, this message translates to:
  /// **'Прошедшие'**
  String get prescriptionPast;

  /// No description provided for @prescriptionPickAnimalMsg.
  ///
  /// In ru, this message translates to:
  /// **'Выберите животное'**
  String get prescriptionPickAnimalMsg;

  /// No description provided for @prescriptionTime.
  ///
  /// In ru, this message translates to:
  /// **'Время'**
  String get prescriptionTime;

  /// No description provided for @prescriptionTitleAdd.
  ///
  /// In ru, this message translates to:
  /// **'Новое назначение'**
  String get prescriptionTitleAdd;

  /// No description provided for @prescriptionTitleEdit.
  ///
  /// In ru, this message translates to:
  /// **'Редактирование'**
  String get prescriptionTitleEdit;

  /// No description provided for @prescriptionWaitLoadingMsg.
  ///
  /// In ru, this message translates to:
  /// **'Дождитесь окончания загрузки'**
  String get prescriptionWaitLoadingMsg;

  /// No description provided for @prescriptionWeekly.
  ///
  /// In ru, this message translates to:
  /// **'Еженедельно'**
  String get prescriptionWeekly;

  /// No description provided for @regAboutOrg.
  ///
  /// In ru, this message translates to:
  /// **'Информация об организации'**
  String get regAboutOrg;

  /// No description provided for @regAboutYou.
  ///
  /// In ru, this message translates to:
  /// **'Информация о Вас'**
  String get regAboutYou;

  /// No description provided for @regAdminRegMsg.
  ///
  /// In ru, this message translates to:
  /// **'Человек, данные которого указаны, автоматически будет назначен администратором'**
  String get regAdminRegMsg;

  /// No description provided for @regAgreePersonalDataPart0.
  ///
  /// In ru, this message translates to:
  /// **'Я даю согласие на обработку '**
  String get regAgreePersonalDataPart0;

  /// No description provided for @regAgreePersonalDataPart1.
  ///
  /// In ru, this message translates to:
  /// **'персональных данных'**
  String get regAgreePersonalDataPart1;

  /// No description provided for @regCity.
  ///
  /// In ru, this message translates to:
  /// **'Город *'**
  String get regCity;

  /// No description provided for @regCountry.
  ///
  /// In ru, this message translates to:
  /// **'Страна *'**
  String get regCountry;

  /// No description provided for @regEmaiConfirmation.
  ///
  /// In ru, this message translates to:
  /// **'Подтверждение eMail'**
  String get regEmaiConfirmation;

  /// No description provided for @regEmailConfirmSentMsg.
  ///
  /// In ru, this message translates to:
  /// **'Если вы администратор организации, вы сможете сразу войти на сервис, если вы сотрудник или гость, необходимо подождать подтверждение регистрации от администратора.'**
  String get regEmailConfirmSentMsg;

  /// No description provided for @regEmailConfirmed.
  ///
  /// In ru, this message translates to:
  /// **'Ваш e-mail подтвержден'**
  String get regEmailConfirmed;

  /// No description provided for @regEmployee.
  ///
  /// In ru, this message translates to:
  /// **'Сотрудник'**
  String get regEmployee;

  /// No description provided for @regFathersName.
  ///
  /// In ru, this message translates to:
  /// **'Отчество'**
  String get regFathersName;

  /// No description provided for @regFieldEmptyError.
  ///
  /// In ru, this message translates to:
  /// **'Поле не должно быть пустым'**
  String get regFieldEmptyError;

  /// No description provided for @regGuest.
  ///
  /// In ru, this message translates to:
  /// **'Гость'**
  String get regGuest;

  /// No description provided for @regHaveAccount.
  ///
  /// In ru, this message translates to:
  /// **'Уже есть аккаунт?'**
  String get regHaveAccount;

  /// No description provided for @regLeast8Symbols.
  ///
  /// In ru, this message translates to:
  /// **'Минимум 8 символов'**
  String get regLeast8Symbols;

  /// No description provided for @regNeedConfirmPolicy.
  ///
  /// In ru, this message translates to:
  /// **'Необходимо дать согласие на обработку данных'**
  String get regNeedConfirmPolicy;

  /// No description provided for @regOrg.
  ///
  /// In ru, this message translates to:
  /// **'ОРГАНИЗАЦИЯ'**
  String get regOrg;

  /// No description provided for @regOrgName.
  ///
  /// In ru, this message translates to:
  /// **'Название организации/реаб.центра *'**
  String get regOrgName;

  /// No description provided for @regPassSymbols.
  ///
  /// In ru, this message translates to:
  /// **'Латинские буквы, цифры, символы'**
  String get regPassSymbols;

  /// No description provided for @regPhoneMask.
  ///
  /// In ru, this message translates to:
  /// **'+7(ххх)ххх-хх-хх'**
  String get regPhoneMask;

  /// No description provided for @regRegion.
  ///
  /// In ru, this message translates to:
  /// **'Область '**
  String get regRegion;

  /// No description provided for @regRegisterRejectMsg.
  ///
  /// In ru, this message translates to:
  /// **'Пожалуйста, заполните все поля регистрации честно и мы вновь рассмотрим вашу заявку.'**
  String get regRegisterRejectMsg;

  /// No description provided for @regRegisterRejectTitle.
  ///
  /// In ru, this message translates to:
  /// **'К сожалению, вам отказано в регистрации :('**
  String get regRegisterRejectTitle;

  /// No description provided for @regTUPmsg.
  ///
  /// In ru, this message translates to:
  /// **'Вы будете перенаправлены\nна страницу входа.'**
  String get regTUPmsg;

  /// No description provided for @regTUPtitle.
  ///
  /// In ru, this message translates to:
  /// **'Спасибо, мы все записали!'**
  String get regTUPtitle;

  /// No description provided for @regTitle.
  ///
  /// In ru, this message translates to:
  /// **'Регистрация'**
  String get regTitle;

  /// No description provided for @regUser.
  ///
  /// In ru, this message translates to:
  /// **'ПОЛЬЗОВАТЕЛЬ'**
  String get regUser;

  /// No description provided for @regUserRole.
  ///
  /// In ru, this message translates to:
  /// **'Роль пользователя'**
  String get regUserRole;

  /// No description provided for @regWriteCity.
  ///
  /// In ru, this message translates to:
  /// **'Укажите город'**
  String get regWriteCity;

  /// No description provided for @regWriteCountry.
  ///
  /// In ru, this message translates to:
  /// **'Укажите страну'**
  String get regWriteCountry;

  /// No description provided for @regWriteRegion.
  ///
  /// In ru, this message translates to:
  /// **'Укажите область'**
  String get regWriteRegion;

  /// No description provided for @shelterSelectShelter.
  ///
  /// In ru, this message translates to:
  /// **'Выберите организацию'**
  String get shelterSelectShelter;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'ru'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'ru':
      return AppLocalizationsRu();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
