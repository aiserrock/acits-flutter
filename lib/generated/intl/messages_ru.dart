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
      "{count,plural, =0{0 дней} =1{${count} {день}} =2{${count} дня} few{${count} дней} other{${count} дней}}";

  static String m1(count, month) =>
      "{count,plural, =0{0 месяцев} =1{${count} {месяц}} =2{${count} {месяц}а} few{${count} месяцев} other{${count} месяцев}}";

  static String m2(count, year) =>
      "{count,plural, =0{0 лет} =1{${count} {год}} =2{${count} {год}а} few{${count} лет} other{${count} лет}}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "animalAdmitted": MessageLookupByLibrary.simpleMessage("Поступил"),
        "animalAge": MessageLookupByLibrary.simpleMessage("Возраст"),
        "animalApplicant": MessageLookupByLibrary.simpleMessage("Заявитель"),
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
        "animalFamily": MessageLookupByLibrary.simpleMessage("Семейство"),
        "animalKind": MessageLookupByLibrary.simpleMessage("Вид"),
        "animalPrescriptions":
            MessageLookupByLibrary.simpleMessage("Назначения"),
        "animalReceiptDate":
            MessageLookupByLibrary.simpleMessage("Дата поступления"),
        "animalSex": MessageLookupByLibrary.simpleMessage("Пол"),
        "animalSpecSigns":
            MessageLookupByLibrary.simpleMessage("Особые приметы"),
        "animalStatus": MessageLookupByLibrary.simpleMessage("Статус"),
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
        "commonMonth": MessageLookupByLibrary.simpleMessage("месяц"),
        "commonNDays": m0,
        "commonNMonth": m1,
        "commonNYears": m2,
        "commonNext": MessageLookupByLibrary.simpleMessage("Далее"),
        "commonNotCompleted":
            MessageLookupByLibrary.simpleMessage("Не выполнено"),
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
