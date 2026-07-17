import 'package:acits_api/acits_api.dart';

/// Реалистичные AnimalDto для тестов data-слоя. Формы позаимствованы у
/// packages/acits_api/test/fixtures/animals_fixtures.dart, но собраны сразу в
/// DTO (маппер/репозиторий работают с DTO, не с сырым JSON).

ImageThumbnailsDto _thumbs(String base) =>
    ImageThumbnailsDto(large: '$base/large.jpg', medium: '$base/medium.jpg', small: '$base/small.jpg');

/// Полностью заполнено: два фото (primary — второе), spec, curator/applicant,
/// атрибуты, статус IN_THE_SHELTER.
AnimalDto fullAnimalDto({String? status = 'IN_THE_SHELTER'}) => AnimalDto(
  id: 501,
  uuid: '3f2504e0-4f89-41d3-9a0c-0305e82c3301',
  url: 'https://api.acits.ru/api/v1/animals/501/',
  name: 'Барсик',
  images: [
    AnimalImageDto(id: 9000, filename: 'first.jpg', image: _thumbs('https://cdn.acits.ru/501/first'), isPrimary: false),
    AnimalImageDto(id: 9001, filename: 'barsik.jpg', image: _thumbs('https://cdn.acits.ru/501'), isPrimary: true),
  ],
  spec: const SpeciesDto(
    id: 12,
    name: 'Кошка домашняя',
    level: 3,
    parentId: 4,
    parentName: 'Кошки',
    categoryName: 'Млекопитающие',
  ),
  status: status,
  dateJoined: DateTime.utc(2024, 1, 15, 10, 30),
  birthDate: DateTime.utc(2020, 6, 1),
  defaultImageId: 9001,
  placeOfCatch: 'ул. Пушкина, д. 10',
  dateOfChipping: DateTime.utc(2024, 2, 1, 9),
  chippingCode: '643098100012345',
  height: '30.5',
  weight: '4.20',
  hasDocuments: true,
  shelter: 50,
  curator: CuratorDto(
    id: 77,
    url: 'https://api.acits.ru/api/v1/curators/77/',
    shelter: 'Пушистые попки',
    firstName: 'Иван',
    lastName: 'Петров',
    email: 'ivan@example.com',
    phoneNumber: '+79001234567',
    address: 'г. Москва',
    createdBy: 'admin',
    updatedBy: 'admin',
    createdAt: DateTime.utc(2023, 11, 1, 8),
    updatedAt: DateTime.utc(2024, 1, 10, 12),
  ),
  applicant: ApplicantDto(
    id: 88,
    url: 'https://api.acits.ru/api/v1/applicants/88/',
    shelter: 50,
    firstName: 'Мария',
    lastName: 'Сидорова',
    phoneNumber: '+79007654321',
    contactDetails: 'Telegram @maria',
    createdBy: 'admin',
    updatedBy: 'admin',
    createdAt: DateTime.utc(2024, 1, 5, 8),
    updatedAt: DateTime.utc(2024, 1, 6, 8),
    animalId: 501,
  ),
  animalAttributes: const [
    AnimalAttributeDto(attrId: 1, name: 'sex', value: 'Самец', isRequired: true),
    AnimalAttributeDto(attrId: 2, name: 'color', value: 'Рыжий', isRequired: false),
  ],
  canBeShared: true,
);

/// Минимально: без имени, без фото, статус null, без spec/curator/applicant.
AnimalDto minimalAnimalDto() => AnimalDto(
  id: 502,
  uuid: '3f2504e0-4f89-41d3-9a0c-0305e82c3302',
  url: 'https://api.acits.ru/api/v1/animals/502/',
  images: const [],
  dateJoined: DateTime.utc(2024, 3, 20),
  placeOfCatch: 'Не указано',
  shelter: 50,
  animalAttributes: const [],
);

/// Одно фото, не помеченное primary — маппер должен взять первое.
AnimalDto singleNonPrimaryImageDto() => AnimalDto(
  id: 504,
  uuid: '3f2504e0-4f89-41d3-9a0c-0305e82c3304',
  url: 'https://api.acits.ru/api/v1/animals/504/',
  name: 'Мурка',
  images: [
    AnimalImageDto(id: 9100, filename: 'murka.jpg', image: _thumbs('https://cdn.acits.ru/504'), isPrimary: false),
  ],
  spec: const SpeciesDto(id: 5, name: 'Собака', level: 2),
  status: 'HOSPITAL',
  dateJoined: DateTime.utc(2024, 4, 1),
  placeOfCatch: 'Двор',
  shelter: 50,
  animalAttributes: const [],
);
