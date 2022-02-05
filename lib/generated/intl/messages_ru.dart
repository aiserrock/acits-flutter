// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a ru locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names, avoid_escaping_inner_quotes
// ignore_for_file:unnecessary_string_interpolations, unnecessary_string_escapes

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'ru';

  static String m0(count, day) =>
      "${Intl.plural(count, zero: '0 дней', one: '${count} ${day}', two: '${count} дня', few: '${count} дней', other: '${count} дней')}";

  static String m1(count, month) =>
      "${Intl.plural(count, zero: '0 месяцев', one: '${count} ${month}', two: '${count} ${month}а', few: '${count} месяцев', other: '${count} месяцев')}";

  static String m2(count, year) =>
      "${Intl.plural(count, zero: '0 лет', one: '${count} ${year}', two: '${count} ${year}а', few: '${count} лет', other: '${count} лет')}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "animalAdd": MessageLookupByLibrary.simpleMessage("Новое животное"),
        "animalAdditionalInfo":
            MessageLookupByLibrary.simpleMessage("Дополнительная информация"),
        "animalAdmitted": MessageLookupByLibrary.simpleMessage("Поступил"),
        "animalAge": MessageLookupByLibrary.simpleMessage("Возраст"),
        "animalAgeAppox": MessageLookupByLibrary.simpleMessage("Примерный"),
        "animalAgeExact": MessageLookupByLibrary.simpleMessage("Точный"),
        "animalAnimalFamily":
            MessageLookupByLibrary.simpleMessage("Семейство животного"),
        "animalAnimalKind":
            MessageLookupByLibrary.simpleMessage("Вид животного"),
        "animalAnimalStatus":
            MessageLookupByLibrary.simpleMessage("Статус животного"),
        "animalApplicant": MessageLookupByLibrary.simpleMessage("Заявитель"),
        "animalBirth": MessageLookupByLibrary.simpleMessage("Дата рождения"),
        "animalCardTitle":
            MessageLookupByLibrary.simpleMessage("Карточка животного"),
        "animalCatchPlace":
            MessageLookupByLibrary.simpleMessage("Место отлова"),
        "animalCategory": MessageLookupByLibrary.simpleMessage("Категория"),
        "animalChip": MessageLookupByLibrary.simpleMessage("Кольцо/чип"),
        "animalChipDate":
            MessageLookupByLibrary.simpleMessage("Дата чипирования"),
        "animalColor": MessageLookupByLibrary.simpleMessage("Окрас"),
        "animalComments": MessageLookupByLibrary.simpleMessage("Комментарии"),
        "animalCommonInfo":
            MessageLookupByLibrary.simpleMessage("Основная информация"),
        "animalCurator": MessageLookupByLibrary.simpleMessage("Куратор"),
        "animalCuratorAddress": MessageLookupByLibrary.simpleMessage("Адрес"),
        "animalCuratorEmail": MessageLookupByLibrary.simpleMessage("E-mail"),
        "animalCuratorLastName":
            MessageLookupByLibrary.simpleMessage("Фамилия"),
        "animalCuratorName": MessageLookupByLibrary.simpleMessage("Имя"),
        "animalCuratorPhone":
            MessageLookupByLibrary.simpleMessage("Номер телефона"),
        "animalDateAdmitt":
            MessageLookupByLibrary.simpleMessage("Дата поступления"),
        "animalEdit": MessageLookupByLibrary.simpleMessage("Редактировать"),
        "animalFamily": MessageLookupByLibrary.simpleMessage("Семейство"),
        "animalGenderFemale": MessageLookupByLibrary.simpleMessage("Женский"),
        "animalGenderLess": MessageLookupByLibrary.simpleMessage("Без пола"),
        "animalGenderMale": MessageLookupByLibrary.simpleMessage("Мужской"),
        "animalGenderMiddle": MessageLookupByLibrary.simpleMessage("Средний"),
        "animalGenderUndefined":
            MessageLookupByLibrary.simpleMessage("Неизвестен"),
        "animalKind": MessageLookupByLibrary.simpleMessage("Вид"),
        "animalName": MessageLookupByLibrary.simpleMessage("Кличка"),
        "animalPickCurator":
            MessageLookupByLibrary.simpleMessage("Выбрать куратора"),
        "animalPrescriptions":
            MessageLookupByLibrary.simpleMessage("Назначения"),
        "animalQtyMonth":
            MessageLookupByLibrary.simpleMessage("Кол-во месяцев"),
        "animalQtyYear": MessageLookupByLibrary.simpleMessage("Кол-во лет"),
        "animalReceiptDate":
            MessageLookupByLibrary.simpleMessage("Дата поступления"),
        "animalSex": MessageLookupByLibrary.simpleMessage("Пол"),
        "animalSocialLink":
            MessageLookupByLibrary.simpleMessage("Ссылка на соцсети"),
        "animalSpecSigns":
            MessageLookupByLibrary.simpleMessage("Особые приметы"),
        "animalStatus": MessageLookupByLibrary.simpleMessage("Статус"),
        "animalStatusAndJoin":
            MessageLookupByLibrary.simpleMessage("Статус и поступление"),
        "animalTransferAct":
            MessageLookupByLibrary.simpleMessage("Акт приема-передачи"),
        "animalUploadAct": MessageLookupByLibrary.simpleMessage(
            "Загрузить акт приема-передачи"),
        "animalWeight": MessageLookupByLibrary.simpleMessage("Вес, кг"),
        "aninmalSize": MessageLookupByLibrary.simpleMessage("Рост, см"),
        "common": MessageLookupByLibrary.simpleMessage("общий"),
        "commonAdd": MessageLookupByLibrary.simpleMessage("Добавить"),
        "commonAnimals": MessageLookupByLibrary.simpleMessage("Животные"),
        "commonBegin": MessageLookupByLibrary.simpleMessage("Начать"),
        "commonCalendar": MessageLookupByLibrary.simpleMessage("Календарь"),
        "commonCancel": MessageLookupByLibrary.simpleMessage("Отмена"),
        "commonDay": MessageLookupByLibrary.simpleMessage("день"),
        "commonDelete": MessageLookupByLibrary.simpleMessage("Удалить"),
        "commonDone": MessageLookupByLibrary.simpleMessage("Выполнено"),
        "commonDrugs": MessageLookupByLibrary.simpleMessage("Медикаменты"),
        "commonEdit": MessageLookupByLibrary.simpleMessage("Редактировать"),
        "commonErrorStubMsg": MessageLookupByLibrary.simpleMessage(
            "Не удалось загрузить данные.\nПожалуйста, попробуйте еще раз."),
        "commonErrorStubTitle":
            MessageLookupByLibrary.simpleMessage("Ой, что-то пошло не так..."),
        "commonMonth": MessageLookupByLibrary.simpleMessage("месяц"),
        "commonNDays": m0,
        "commonNMonth": m1,
        "commonNYears": m2,
        "commonNext": MessageLookupByLibrary.simpleMessage("Далее"),
        "commonNotCompleted":
            MessageLookupByLibrary.simpleMessage("Не выполнено"),
        "commonReloadBtn": MessageLookupByLibrary.simpleMessage("Обновить"),
        "commonReschedule": MessageLookupByLibrary.simpleMessage("Перенести"),
        "commonSearch": MessageLookupByLibrary.simpleMessage("Поиск"),
        "commonSort": MessageLookupByLibrary.simpleMessage("Сортировка"),
        "commonToday": MessageLookupByLibrary.simpleMessage("Сегодня"),
        "commonYear": MessageLookupByLibrary.simpleMessage("год"),
        "loginAuthorizeError":
            MessageLookupByLibrary.simpleMessage("Неверный логин или пароль"),
        "loginDescribeMsg": MessageLookupByLibrary.simpleMessage(
            "ACITS – Система контроля за животными\nвнутри приюта"),
        "loginEntryBtn": MessageLookupByLibrary.simpleMessage("Войти"),
        "loginForgetPass":
            MessageLookupByLibrary.simpleMessage("Забыли пароль?"),
        "loginLoginHint":
            MessageLookupByLibrary.simpleMessage("Введите почту или логин"),
        "loginLoginLabel": MessageLookupByLibrary.simpleMessage("Логин"),
        "loginPassLabel": MessageLookupByLibrary.simpleMessage("Пароль"),
        "loginToRegistration":
            MessageLookupByLibrary.simpleMessage("Зарегистрироваться"),
        "mainAddAppointments":
            MessageLookupByLibrary.simpleMessage("Добавить назначение"),
        "mainAnimal": MessageLookupByLibrary.simpleMessage("Животное"),
        "mainAppoinment": MessageLookupByLibrary.simpleMessage("Назначение"),
        "mainAppoinmentAuthor":
            MessageLookupByLibrary.simpleMessage("Автор назначения"),
        "mainAppointments": MessageLookupByLibrary.simpleMessage("Назначения"),
        "mainEmptyState":
            MessageLookupByLibrary.simpleMessage("На сегодня назначений нет"),
        "mainTitle": MessageLookupByLibrary.simpleMessage("Сегодня"),
        "onboardingDrugsMsg": MessageLookupByLibrary.simpleMessage(
            "Мы заранее подготовили максимальное количество медицинских назначений для приютов"),
        "onboardingDrugsTitle": MessageLookupByLibrary.simpleMessage(
            "Гибкая система работы с назначениями"),
        "onboardingFreeMsg": MessageLookupByLibrary.simpleMessage(
            "Весь функционал будет доступен для Вас в полном объеме, без ограничений"),
        "onboardingFreeTitle":
            MessageLookupByLibrary.simpleMessage("Абсолютно бесплатно"),
        "onboardingNewsMsg": MessageLookupByLibrary.simpleMessage(
            "Карта ведется на протяжении всей жизни животного и не зависит от приюта"),
        "onboardingNewsTitle":
            MessageLookupByLibrary.simpleMessage("Единая карта животного"),
        "onboardingPlanMsg": MessageLookupByLibrary.simpleMessage(
            "Позволяет четко планировать рабочее время и своевременно оказывать медицинскую помощь животным"),
        "onboardingPlanTitle": MessageLookupByLibrary.simpleMessage(
            "Сводка назначений на текущий день"),
        "shelterSelectShelter":
            MessageLookupByLibrary.simpleMessage("Выберите приют")
      };
}
