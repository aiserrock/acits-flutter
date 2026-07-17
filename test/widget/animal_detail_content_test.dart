import 'package:acits_flutter/ui/screen/animal_detail/animal_content_card.dart';
import 'package:animals/animals.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

/// Smoke-тест миграции карточки животного на сущность [Animal]: вкладки
/// куратора/заявителя рендерят ФИО/телефон из [AnimalContact] богатой сущности
/// (а не из старого AnimalRead DTO). Полный SliverAppBar не голденим — проверяем
/// именно entity→UI поток данных через тот же [AnimalContentCard], что и экран.
Animal _animal() => const Animal(
  id: 501,
  name: 'Барсик',
  shelterId: 50,
  status: AnimalStatus.inTheShelter,
  images: [],
  attributes: {'sex': 'Самец', 'color': 'Рыжий'},
  curator: AnimalContact(
    id: 77,
    firstName: 'Иван',
    lastName: 'Петров',
    phoneNumber: '+79001234567',
    email: 'ivan@example.com',
    extra: 'г. Москва',
  ),
  applicant: AnimalContact(
    id: 88,
    firstName: 'Мария',
    lastName: 'Сидорова',
    phoneNumber: '+79007654321',
    extra: 'Telegram @maria',
  ),
);

Widget _card(List<CardData> data) => MaterialApp(
  home: Scaffold(body: Column(children: [AnimalContentCard(data)])),
);

void main() {
  testWidgets('curator block renders fullName / phone / email from Animal entity', (tester) async {
    final animal = _animal();
    final curator = animal.curator;
    await tester.pumpWidget(
      _card([
        CardData(firstCaption: 'ФИО', firstValue: curator?.fullName),
        CardData(firstCaption: 'Телефон', firstValue: curator?.phoneNumber),
        CardData(firstCaption: 'Email', firstValue: curator?.email),
        CardData(firstCaption: 'Адрес', firstValue: curator?.extra),
      ]),
    );

    expect(find.text('Иван Петров'), findsOneWidget);
    expect(find.text('+79001234567'), findsOneWidget);
    expect(find.text('ivan@example.com'), findsOneWidget);
    expect(find.text('г. Москва'), findsOneWidget);
  });

  testWidgets('applicant block renders fullName / phone from Animal entity', (tester) async {
    final applicant = _animal().applicant;
    await tester.pumpWidget(
      _card([
        CardData(firstCaption: 'ФИО', firstValue: applicant?.fullName),
        CardData(firstCaption: 'Телефон', firstValue: applicant?.phoneNumber),
      ]),
    );

    expect(find.text('Мария Сидорова'), findsOneWidget);
    expect(find.text('+79007654321'), findsOneWidget);
  });

  testWidgets('common-info reads sex/color from entity attributes', (tester) async {
    final animal = _animal();
    await tester.pumpWidget(
      _card([
        CardData(firstCaption: 'Пол', firstValue: animal.sex),
        CardData(firstCaption: 'Окрас', firstValue: animal.color),
      ]),
    );

    expect(find.text('Самец'), findsOneWidget);
    expect(find.text('Рыжий'), findsOneWidget);
  });
}
