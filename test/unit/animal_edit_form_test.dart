import 'package:acits_domain/acits_domain.dart' show Applicant, Curator;
import 'package:acits_flutter/ui/screen/animal_edit/data/animal_edit_data_holder.dart';
import 'package:animals/animals.dart';
import 'package:flutter_test/flutter_test.dart';

/// Форма правки животного собирает write-вход из доменного состояния —
/// проверяем, что seed из [Animal] и последующие мутации страниц дают корректный
/// [Animal]/атрибуты/retain-ids для submit (без chopper/gen).
void main() {
  Animal seed() => Animal(
    id: 501,
    name: 'Барсик',
    shelterId: 50,
    status: AnimalStatus.inTheShelter,
    images: const [
      AnimalImage(id: 9001, small: 's', medium: 'm', large: 'l', isPrimary: true),
      AnimalImage(id: 9002, small: 's2'),
    ],
    attributes: const {'sex': 'M', 'color': 'black'},
    speciesId: 12,
    speciesName: 'Кошка домашняя',
    speciesParentName: 'Кошки',
    speciesCategoryName: 'Млекопитающие',
    dateJoined: DateTime.utc(2024, 1, 15),
    placeOfCatch: 'ул. Пушкина',
    curator: const AnimalContact(id: 77, firstName: 'Иван', lastName: 'Петров', phoneNumber: '+7', extra: 'адрес'),
    applicant: const AnimalContact(id: 88, firstName: 'Мария', lastName: 'С'),
    canBeShared: true,
  );

  test('init seeds domain fields, curator/applicant and images from the entity', () {
    final holder = AnimalEditHolder()..init(seed());
    final s = holder.state;

    expect(s.name, 'Барсик');
    expect(s.specId, 12);
    expect(s.specCategoryName, 'Млекопитающие');
    expect(s.specKindName, 'Кошка домашняя');
    expect(s.status, AnimalStatus.inTheShelter);
    expect(s.placeOfCatch, 'ул. Пушкина');
    expect(s.shelterId, 50);
    expect(s.curator, isA<Curator>());
    expect(s.curator!.id, 77);
    expect(s.curator!.fullName, 'Иван Петров');
    expect(s.curator!.address, 'адрес');
    expect(s.applicant, isA<Applicant>());
    expect(s.applicant!.id, 88);
    // retain ids come from seed images.
    expect(s.retainImageIds, [9001, 9002]);
    // primary image thumb prefers small → medium → large.
    expect(s.thumb, 's');
  });

  test('page mutations flow into toAnimal + attributes for submit', () {
    final holder = AnimalEditHolder()..init(seed());

    // Common-info page: rename + pick a new kind.
    holder.update((p) => p.copyWith(name: 'Мурзик', specId: 34, specKindName: 'Сфинкс'));
    // Add-info page: explicit attributes with attrId.
    holder.update(
      (p) => p.copyWith(
        attributes: const [AnimalAttributeInput(attrId: 1, name: 'sex', value: 'F', isRequired: true)],
        height: '30',
        weight: '4.2',
      ),
    );
    // Curator page: swap curator.
    holder.update(
      (p) => p.copyWith(
        curator: const Curator(id: 99, firstName: 'Оля', lastName: 'К', phoneNumber: '+7'),
      ),
    );

    final s = holder.state;
    final animal = s.toAnimal();

    expect(animal.name, 'Мурзик');
    expect(animal.speciesId, 34);
    expect(animal.status, AnimalStatus.inTheShelter);
    expect(animal.placeOfCatch, 'ул. Пушкина');
    expect(animal.shelterId, 50);
    expect(animal.height, '30');
    expect(animal.weight, '4.2');
    // curator id carried into the domain contact for the write DTO.
    expect(animal.curator!.id, 99);
    expect(animal.applicant!.id, 88);

    // Submit inputs the screen forwards to the cubit.
    expect(s.specId, 34);
    expect(s.attributes.single.attrId, 1);
    expect(s.attributes.single.value, 'F');
    expect(s.retainImageIds, [9001, 9002]);
  });

  test('isEdited tracks divergence from the seeded state', () {
    final holder = AnimalEditHolder()..init(seed());
    expect(holder.isEdited, isFalse);
    holder.update((p) => p.copyWith(name: 'Изменён'));
    expect(holder.isEdited, isTrue);
  });
}
