import 'package:animals/animals.dart';
import 'package:flutter_test/flutter_test.dart';

import '../fixtures/animal_dto_fixtures.dart';

void main() {
  group('AnimalListItemMapper', () {
    test('maps core fields and picks primary image thumb', () {
      final item = AnimalListItemMapper(fullAnimalDto()).toEntity();

      expect(item.id, 501);
      expect(item.name, 'Барсик');
      expect(item.status, AnimalStatus.inTheShelter);
      expect(item.speciesParentName, 'Кошки');
      expect(item.speciesName, 'Кошка домашняя');
      expect(item.dateJoined, DateTime.utc(2024, 1, 15, 10, 30));
      // primary — второе фото (id 9001) → его small
      expect(item.thumbUrl, 'https://cdn.acits.ru/501/small.jpg');
    });

    test('falls back to first image when none is primary', () {
      final item = AnimalListItemMapper(singleNonPrimaryImageDto()).toEntity();
      expect(item.thumbUrl, 'https://cdn.acits.ru/504/small.jpg');
    });

    test('null thumb when no images', () {
      final item = AnimalListItemMapper(minimalAnimalDto()).toEntity();
      expect(item.thumbUrl, isNull);
      expect(item.name, '');
      expect(item.speciesParentName, isNull);
      expect(item.speciesName, isNull);
      // dateJoined всегда присутствует в DTO (required) — маппится напрямую.
      expect(item.dateJoined, DateTime.utc(2024, 3, 20));
    });

    test('null status wire → AnimalStatus.unknown', () {
      final item = AnimalListItemMapper(minimalAnimalDto()).toEntity();
      expect(item.status, AnimalStatus.unknown);
    });

    test('unrecognised status wire → AnimalStatus.unknown', () {
      final item = AnimalListItemMapper(fullAnimalDto(status: 'BRAND_NEW_BACKEND_STATUS')).toEntity();
      expect(item.status, AnimalStatus.unknown);
    });

    for (final entry in <String, AnimalStatus>{
      'IN_THE_SHELTER': AnimalStatus.inTheShelter,
      'HOSPITAL': AnimalStatus.hospital,
      'OVEREXPOSURE': AnimalStatus.overexposure,
      'ATTACHED': AnimalStatus.attached,
      'PREPARING_TO_RELEASE': AnimalStatus.preparingToRelease,
      'RELEASED': AnimalStatus.released,
      'DEATH': AnimalStatus.death,
      'EUTHANASIA': AnimalStatus.euthanasia,
      'IN_CLINIC': AnimalStatus.inClinic,
    }.entries) {
      test('status wire ${entry.key} → ${entry.value}', () {
        final item = AnimalListItemMapper(fullAnimalDto(status: entry.key)).toEntity();
        expect(item.status, entry.value);
      });
    }
  });
}
