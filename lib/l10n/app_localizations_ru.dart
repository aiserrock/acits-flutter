// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Russian (`ru`).
class AppLocalizationsRu extends AppLocalizations {
  AppLocalizationsRu([String locale = 'ru']) : super(locale);

  @override
  String get animalAdd => 'Новое животное ';

  @override
  String get animalAdditionalInfo => 'Дополнительная информация';

  @override
  String get animalAdmitted => 'Поступил';

  @override
  String get animalAge => 'Возраст';

  @override
  String get animalAgeAppox => 'Примерный';

  @override
  String get animalAgeExact => 'Точный';

  @override
  String get animalAnimalFamily => 'Семейство животного';

  @override
  String get animalAnimalKind => 'Вид животного';

  @override
  String get animalAnimalStatus => 'Статус животного';

  @override
  String get animalApplicant => 'Заявитель';

  @override
  String get animalBirth => 'Дата рождения';

  @override
  String get animalCardTitle => 'Карточка животного';

  @override
  String get animalCatchPlace => 'Место отлова';

  @override
  String get animalCategory => 'Категория';

  @override
  String get animalChip => 'Кольцо/чип';

  @override
  String get animalChipDate => 'Дата чипирования';

  @override
  String get animalColor => 'Окрас';

  @override
  String get animalComments => 'Комментарии';

  @override
  String get animalCommonInfo => 'Основная информация';

  @override
  String get animalCurator => 'Куратор';

  @override
  String get animalCuratorAddress => 'Адрес';

  @override
  String get animalCuratorEmail => 'E-mail';

  @override
  String get animalCuratorLastName => 'Фамилия';

  @override
  String get animalCuratorName => 'Имя';

  @override
  String get animalCuratorPhone => 'Номер телефона';

  @override
  String get animalDateAdmitt => 'Дата поступления';

  @override
  String get animalDeleteAcceptMsg => 'Вы уверены, что хотите удалить';

  @override
  String get animalEdit => 'Редактировать';

  @override
  String get animalFamily => 'Семейство';

  @override
  String get animalGenderFemale => 'Женский';

  @override
  String get animalGenderLess => 'Без пола';

  @override
  String get animalGenderMale => 'Мужской';

  @override
  String get animalGenderMiddle => 'Средний';

  @override
  String get animalGenderUndefined => 'Неизвестен';

  @override
  String get animalKind => 'Вид';

  @override
  String get animalMaxImagesCountIs => 'Максимальное число фото не должно превышать ';

  @override
  String get animalName => 'Кличка';

  @override
  String get animalPickCurator => 'Выбрать куратора';

  @override
  String get animalPrescriptions => 'Назначения';

  @override
  String get animalQtyMonth => 'Кол-во месяцев';

  @override
  String get animalQtyYear => 'Кол-во лет';

  @override
  String get animalReceiptDate => 'Дата поступления';

  @override
  String get animalSex => 'Пол';

  @override
  String get animalSocialLink => 'Ссылка на соцсети';

  @override
  String get animalSpecSigns => 'Особые приметы';

  @override
  String get animalStatus => 'Статус';

  @override
  String get animalStatusAndJoin => 'Статус и поступление';

  @override
  String get animalTransferAct => 'Акт приема-передачи';

  @override
  String get animalUploadAct => 'Загрузить акт приема-передачи';

  @override
  String get animalWeight => 'Вес, кг';

  @override
  String get aninmalSize => 'Рост, см';

  @override
  String get applicantAdd => 'Новый заявитель';

  @override
  String get applicantEdit => 'Редактировать';

  @override
  String get commentDeletingFail => 'Не удалось удалить комментарий';

  @override
  String get commentTitleEdit => 'Редактирование';

  @override
  String get commentTitleNew => 'Новый комментарий';

  @override
  String get common => 'общий';

  @override
  String get commonAdd => 'Добавить';

  @override
  String get commonAnimals => 'Животные';

  @override
  String get commonBegin => 'Начать';

  @override
  String get commonCalendar => 'Календарь';

  @override
  String get commonCancel => 'Отмена';

  @override
  String get commonClose => 'Закрыть';

  @override
  String get commonDay => 'день';

  @override
  String get commonDelete => 'Удалить';

  @override
  String get commonDidNotImpl => 'Пока не реализовано :(';

  @override
  String get commonDone => 'Выполнено';

  @override
  String get commonDrugs => 'Медикаменты';

  @override
  String get commonEdit => 'Редактировать';

  @override
  String get commonError => 'Ошибка';

  @override
  String get commonErrorStubMsg => 'Не удалось загрузить данные.\nПожалуйста, попробуйте еще раз.';

  @override
  String get commonErrorStubTitle => 'Ой, что-то пошло не так...';

  @override
  String get commonErrorTryAgainMessage => 'Произошла ошибка. Попробуйте позже.';

  @override
  String get commonLoading => 'Загрузка';

  @override
  String get commonMonth => 'месяц';

  @override
  String commonNDays(int count, Object day) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count дней',
      few: '$count дней',
      two: '$count дня',
      one: '$count $day',
      zero: '0 дней',
    );
    return '$_temp0';
  }

  @override
  String commonNMonth(int count, Object month) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count месяцев',
      few: '$count месяцев',
      two: '$count $monthа',
      one: '$count $month',
      zero: '0 месяцев',
    );
    return '$_temp0';
  }

  @override
  String commonNYears(int count, Object year) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count лет',
      few: '$count лет',
      two: '$count $yearа',
      one: '$count $year',
      zero: '0 лет',
    );
    return '$_temp0';
  }

  @override
  String get commonNext => 'Далее';

  @override
  String get commonNoAppToOpenFileMsg => 'Нет подходящего приложения для открытия этого файла :(';

  @override
  String get commonNotCompleted => 'Не выполнено';

  @override
  String get commonNotFound => 'Ничего не нашлось :(';

  @override
  String get commonReloadBtn => 'Обновить';

  @override
  String get commonRepeat => 'Повторить';

  @override
  String get commonReschedule => 'Перенести';

  @override
  String get commonSearch => 'Поиск';

  @override
  String get commonShare => 'Поделиться';

  @override
  String get commonSort => 'Сортировка';

  @override
  String get commonToday => 'Сегодня';

  @override
  String get commonWarning => 'Внимание';

  @override
  String get commonYear => 'год';

  @override
  String get curatorAdd => 'Новый куратор';

  @override
  String get curatorEdit => 'Редактирование';

  @override
  String get errorDefaultMsg => 'Что-то пошло не так, попробуйте еще раз позже';

  @override
  String get errorInternetFail => 'Нет интернета :(';

  @override
  String get errorInternetFailMsg => 'Неустойчивое соединение, попробуйте еще раз позже';

  @override
  String get loginAuthorizeError => 'Неверный логин или пароль';

  @override
  String get loginDescribeMsg => 'ACITS – Система контроля за животными\nвнутри организации';

  @override
  String get loginEntryBtn => 'Войти';

  @override
  String get loginForgetPass => 'Забыли пароль?';

  @override
  String get loginLoginHint => 'Введите почту или логин';

  @override
  String get loginLoginLabel => 'Логин';

  @override
  String get loginPassLabel => 'Пароль';

  @override
  String get loginToRegistration => 'Зарегистрироваться';

  @override
  String get mainAddAppointments => 'Добавить назначение';

  @override
  String get mainAnimal => 'Животное';

  @override
  String get mainAppoinment => 'Назначение';

  @override
  String get mainAppoinmentAuthor => 'Автор назначения';

  @override
  String get mainAppointments => 'Назначения';

  @override
  String get mainEmptyState => 'На сегодня назначений нет';

  @override
  String get mainTitle => 'Сегодня';

  @override
  String get onboardingDrugsMsg =>
      'Мы заранее подготовили максимальное количество медицинских назначений для организаций';

  @override
  String get onboardingDrugsTitle => 'Гибкая система работы с назначениями';

  @override
  String get onboardingFreeMsg =>
      'Весь функционал будет доступен для Вас в полном объеме, без ограничений';

  @override
  String get onboardingFreeTitle => 'Абсолютно бесплатно';

  @override
  String get onboardingNewsMsg =>
      'Карта ведется на протяжении всей жизни животного и не зависит от организации';

  @override
  String get onboardingNewsTitle => 'Единая карта животного';

  @override
  String get onboardingPlanMsg =>
      'Позволяет четко планировать рабочее время и своевременно оказывать медицинскую помощь животным';

  @override
  String get onboardingPlanTitle => 'Сводка назначений на текущий день';

  @override
  String get personChangePass => 'Сменить пароль';

  @override
  String get personChangeShelter => 'Сменить организацию';

  @override
  String get personFeedback => 'Обратная связь';

  @override
  String get personLogout => 'Выйти';

  @override
  String get personMyData => 'Мои данные';

  @override
  String get personMyShelters => 'Мои организации';

  @override
  String get personalChangeErrorMsg => 'Не удалось изменить пароль\n';

  @override
  String get personalChangePass => 'Изменить пароль';

  @override
  String get personalEmptyFieldErrorMsg => 'Заполните значения';

  @override
  String get personalNewPass => ' Новый пароль';

  @override
  String get personalOldPass => ' Старый пароль';

  @override
  String get personalPassChanged => 'Пароль успешно изменен';

  @override
  String get personalRePass => ' Повторить пароль';

  @override
  String get prescriptionAnimal => 'Животное*';

  @override
  String get prescriptionCantChangeAnimalMsg =>
      'Нельзя изменить животное при редактировании назначения';

  @override
  String get prescriptionComment => 'Комментарий';

  @override
  String get prescriptionCurrent => 'Текущие';

  @override
  String get prescriptionDaily => 'Ежедневно';

  @override
  String get prescriptionDate => 'Дата';

  @override
  String get prescriptionDrug => 'Лекарство';

  @override
  String get prescriptionPast => 'Прошедшие';

  @override
  String get prescriptionPickAnimalMsg => 'Выберите животное';

  @override
  String get prescriptionTime => 'Время';

  @override
  String get prescriptionTitleAdd => 'Новое назначение';

  @override
  String get prescriptionTitleEdit => 'Редактирование';

  @override
  String get prescriptionWaitLoadingMsg => 'Дождитесь окончания загрузки';

  @override
  String get prescriptionWeekly => 'Еженедельно';

  @override
  String get regAboutOrg => 'Информация об организации';

  @override
  String get regAboutYou => 'Информация о Вас';

  @override
  String get regAdminRegMsg =>
      'Человек, данные которого указаны, автоматически будет назначен администратором';

  @override
  String get regAgreePersonalDataPart0 => 'Я даю согласие на обработку ';

  @override
  String get regAgreePersonalDataPart1 => 'персональных данных';

  @override
  String get regCity => 'Город *';

  @override
  String get regCountry => 'Страна *';

  @override
  String get regEmaiConfirmation => 'Подтверждение eMail';

  @override
  String get regEmailConfirmSentMsg =>
      'Если вы администратор организации, вы сможете сразу войти на сервис, если вы сотрудник или гость, необходимо подождать подтверждение регистрации от администратора.';

  @override
  String get regEmailConfirmed => 'Ваш e-mail подтвержден';

  @override
  String get regEmployee => 'Сотрудник';

  @override
  String get regFathersName => 'Отчество';

  @override
  String get regFieldEmptyError => 'Поле не должно быть пустым';

  @override
  String get regGuest => 'Гость';

  @override
  String get regHaveAccount => 'Уже есть аккаунт?';

  @override
  String get regLeast8Symbols => 'Минимум 8 символов';

  @override
  String get regNeedConfirmPolicy => 'Необходимо дать согласие на обработку данных';

  @override
  String get regOrg => 'ОРГАНИЗАЦИЯ';

  @override
  String get regOrgName => 'Название организации/реаб.центра *';

  @override
  String get regPassSymbols => 'Латинские буквы, цифры, символы';

  @override
  String get regPhoneMask => '+7(ххх)ххх-хх-хх';

  @override
  String get regRegion => 'Область ';

  @override
  String get regRegisterRejectMsg =>
      'Пожалуйста, заполните все поля регистрации честно и мы вновь рассмотрим вашу заявку.';

  @override
  String get regRegisterRejectTitle => 'К сожалению, вам отказано в регистрации :(';

  @override
  String get regTUPmsg => 'Вы будете перенаправлены\nна страницу входа.';

  @override
  String get regTUPtitle => 'Спасибо, мы все записали!';

  @override
  String get regTitle => 'Регистрация';

  @override
  String get regUser => 'ПОЛЬЗОВАТЕЛЬ';

  @override
  String get regUserRole => 'Роль пользователя';

  @override
  String get regWriteCity => 'Укажите город';

  @override
  String get regWriteCountry => 'Укажите страну';

  @override
  String get regWriteRegion => 'Укажите область';

  @override
  String get shelterSelectShelter => 'Выберите организацию';

  @override
  String get commonBack => 'Вернуться';

  @override
  String get animalEditSuccessTitle => 'Готово!';

  @override
  String get animalEditSuccessMessage => 'Изменения сохранены.';

  @override
  String get commonAccept => 'Принять';
}
