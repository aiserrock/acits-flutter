import 'package:animals/animals.dart';
import 'package:flutter_test/flutter_test.dart';

import '../fixtures/animal_dto_fixtures.dart';

void main() {
  group('AnimalMapper', () {
    test('maps full DTO into rich Animal', () {
      final animal = AnimalMapper(fullAnimalDto()).toEntity();

      expect(animal.id, 501);
      expect(animal.name, 'Барсик');
      expect(animal.shelterId, 50);
      expect(animal.status, AnimalStatus.inTheShelter);
      expect(animal.speciesId, 12);
      expect(animal.speciesName, 'Кошка домашняя');
      expect(animal.speciesParentName, 'Кошки');
      expect(animal.speciesCategoryName, 'Млекопитающие');
      expect(animal.chippingCode, '643098100012345');
      expect(animal.dateOfChipping, DateTime.utc(2024, 2, 1, 9));
      expect(animal.height, '30.5');
      expect(animal.weight, '4.20');
      expect(animal.placeOfCatch, 'ул. Пушкина, д. 10');
      expect(animal.canBeShared, isTrue);
      expect(animal.dateJoined, DateTime.utc(2024, 1, 15, 10, 30));
      expect(animal.birthDate, DateTime.utc(2020, 6, 1));
    });

    test('images map with primary flag and thumb order; avatar is primary', () {
      final animal = AnimalMapper(fullAnimalDto()).toEntity();

      expect(animal.images, hasLength(2));
      final primary = animal.images.firstWhere((i) => i.isPrimary);
      expect(primary.id, 9001);
      expect(primary.small, 'https://cdn.acits.ru/501/small.jpg');
      expect(animal.avatar?.id, 9001);
      expect(animal.thumb, 'https://cdn.acits.ru/501/small.jpg');
    });

    test('attributes flatten to name→value map (sex/color helpers)', () {
      final animal = AnimalMapper(fullAnimalDto()).toEntity();

      expect(animal.attributes, {'sex': 'Самец', 'color': 'Рыжий'});
      expect(animal.sex, 'Самец');
      expect(animal.color, 'Рыжий');
    });

    test('curator.extra = address, applicant.extra = contactDetails', () {
      final animal = AnimalMapper(fullAnimalDto()).toEntity();

      expect(animal.curator?.fullName, 'Иван Петров');
      expect(animal.curator?.extra, 'г. Москва');
      expect(animal.curator?.email, 'ivan@example.com');
      expect(animal.applicant?.fullName, 'Мария Сидорова');
      expect(animal.applicant?.extra, 'Telegram @maria');
    });

    test('minimal DTO: empty name/images/attributes, null species/contacts, unknown status', () {
      final animal = AnimalMapper(minimalAnimalDto()).toEntity();

      expect(animal.name, '');
      expect(animal.images, isEmpty);
      expect(animal.attributes, isEmpty);
      expect(animal.speciesId, isNull);
      expect(animal.speciesName, isNull);
      expect(animal.curator, isNull);
      expect(animal.applicant, isNull);
      expect(animal.status, AnimalStatus.unknown);
      expect(animal.canBeShared, isFalse);
    });

    test('unknown status wire preserved as AnimalStatus.unknown', () {
      final animal = AnimalMapper(fullAnimalDto(status: 'BRAND_NEW_BACKEND_STATUS')).toEntity();
      expect(animal.status, AnimalStatus.unknown);
    });
  });
}
