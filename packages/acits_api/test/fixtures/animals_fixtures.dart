/// Realistic wire-shape JSON fixtures for the animals endpoint group.
///
/// These mirror what the ACITS backend returns for `GET /api/v1/animals/`
/// (paginated) and `GET /api/v1/animals/{id}/` (single). They are the parity
/// anchor: the same JSON the app's chopper client parses into
/// `PaginatedAnimalReadList` / `AnimalRead` must parse into the
/// swagger_parser-generated models and map onto OUR DTOs identically.
library;

/// A fully-populated animal — every nullable field present, real enum wire
/// value, nested spec/curator/applicant objects, attributes, and the
/// adoption/release/overstay URI strings.
Map<String, dynamic> fullAnimalJson() => <String, dynamic>{
  'id': 501,
  'uuid': '3f2504e0-4f89-41d3-9a0c-0305e82c3301',
  'url': 'https://api.acits.ru/api/v1/animals/501/',
  'name': 'Барсик',
  'images': <dynamic>[
    <String, dynamic>{
      'id': 9001,
      'is_primary': true,
      'filename': 'barsik.jpg',
      'image': <String, dynamic>{
        'large': 'https://cdn.acits.ru/501/large.jpg',
        'medium': 'https://cdn.acits.ru/501/medium.jpg',
        'small': 'https://cdn.acits.ru/501/small.jpg',
      },
    },
  ],
  'spec': <String, dynamic>{
    'id': 12,
    'name': 'Кошка домашняя',
    'level': 3,
    'parent_id': 4,
    'parent_name': 'Кошки',
    'category_name': 'Млекопитающие',
  },
  'status': 'IN_THE_SHELTER',
  'date_joined': '2024-01-15T10:30:00Z',
  'birth_date': '2020-06-01T00:00:00Z',
  'death_date': null,
  'death_reason': null,
  'default_image_id': 9001,
  'place_of_catch': 'ул. Пушкина, д. 10',
  'place_of_release': null,
  'date_of_chipping': '2024-02-01T09:00:00Z',
  'chipping_code': '643098100012345',
  'height': '30.5',
  'weight': '4.20',
  'has_documents': true,
  'shelter': 50,
  'curator': <String, dynamic>{
    'id': 77,
    'url': 'https://api.acits.ru/api/v1/curators/77/',
    'shelter': 'Пушистые попки',
    'first_name': 'Иван',
    'last_name': 'Петров',
    'email': 'ivan@example.com',
    'phone_number': '+79001234567',
    'address': 'г. Москва',
    'created_by': 'admin',
    'updated_by': 'admin',
    'created_at': '2023-11-01T08:00:00Z',
    'updated_at': '2024-01-10T12:00:00Z',
  },
  'applicant': <String, dynamic>{
    'id': 88,
    'url': 'https://api.acits.ru/api/v1/applicants/88/',
    'shelter': 50,
    'first_name': 'Мария',
    'last_name': 'Сидорова',
    'email': null,
    'phone_number': '+79007654321',
    'contact_details': 'Telegram @maria',
    'created_by': 'admin',
    'updated_by': 'admin',
    'created_at': '2024-01-05T08:00:00Z',
    'updated_at': '2024-01-06T08:00:00Z',
    'animal_id': 501,
    'applicant_files': <dynamic>[
      <String, dynamic>{
        'id': 1,
        'file': 'https://cdn.acits.ru/files/1.pdf',
        'name': 'Паспорт',
        'filename': 'passport.pdf',
        'created_at': '2024-01-05T08:05:00Z',
      },
    ],
  },
  'animal_attributes': <dynamic>[
    <String, dynamic>{'attr_id': 1, 'name': 'Стерилизация', 'value': 'Да', 'is_required': true},
    <String, dynamic>{'attr_id': 2, 'name': 'Окрас', 'value': 'Рыжий', 'is_required': false},
  ],
  'deleted_at': null,
  'adoption': 'https://api.acits.ru/api/v1/animals/501/adoptions/3/',
  'release': null,
  'overstay': null,
  'can_be_shared': true,
};

/// A minimal animal — only required fields, all optionals omitted or null,
/// empty attribute list. Proves the adapter tolerates sparse payloads.
Map<String, dynamic> minimalAnimalJson() => <String, dynamic>{
  'id': 502,
  'uuid': '3f2504e0-4f89-41d3-9a0c-0305e82c3302',
  'url': 'https://api.acits.ru/api/v1/animals/502/',
  'name': null,
  'images': <dynamic>[],
  'spec': <String, dynamic>{
    'id': 1,
    'name': 'Неизвестно',
    'level': 1,
    'parent_id': null,
    'parent_name': null,
    'category_name': null,
  },
  'status': null,
  'date_joined': '2024-03-20T00:00:00Z',
  'place_of_catch': 'Не указано',
  // `has_documents` is required (and non-nullable) in the spec, even in the
  // sparsest real payload — the generated model enforces this.
  'has_documents': false,
  'shelter': 50,
  'curator': <String, dynamic>{
    'id': 78,
    'url': 'https://api.acits.ru/api/v1/curators/78/',
    'shelter': 'Пушистые попки',
    'first_name': '',
    'last_name': '',
    'phone_number': '',
    'address': '',
    'created_by': 'admin',
    'updated_by': 'admin',
    'created_at': '2024-03-20T00:00:00Z',
    'updated_at': '2024-03-20T00:00:00Z',
  },
  'applicant': <String, dynamic>{
    'id': 89,
    'url': 'https://api.acits.ru/api/v1/applicants/89/',
    'shelter': 50,
    'first_name': '',
    'last_name': '',
    'phone_number': '',
    'created_by': 'admin',
    'updated_by': 'admin',
    'created_at': '2024-03-20T00:00:00Z',
    'updated_at': '2024-03-20T00:00:00Z',
  },
  'animal_attributes': <dynamic>[],
  'deleted_at': null,
  'adoption': null,
  'release': null,
  'overstay': null,
};

/// An animal whose `status` carries an enum value NOT in the current schema.
/// Proves unknown enum wire values survive (the raw string is preserved).
Map<String, dynamic> unknownStatusAnimalJson() => <String, dynamic>{
  ...minimalAnimalJson(),
  'id': 503,
  'uuid': '3f2504e0-4f89-41d3-9a0c-0305e82c3303',
  'url': 'https://api.acits.ru/api/v1/animals/503/',
  'status': 'BRAND_NEW_BACKEND_STATUS',
};

/// A paginated `GET /api/v1/animals/` envelope with two results.
Map<String, dynamic> paginatedAnimalsJson() => <String, dynamic>{
  'count': 2,
  'next': 'https://api.acits.ru/api/v1/animals/?limit=2&offset=2',
  'previous': null,
  'results': <dynamic>[fullAnimalJson(), minimalAnimalJson()],
};

/// An empty paginated envelope (no results, no next page).
Map<String, dynamic> emptyPaginatedAnimalsJson() => <String, dynamic>{
  'count': 0,
  'next': null,
  'previous': null,
  'results': <dynamic>[],
};

/// A DRF-style write/validation error body (400) for `POST /api/v1/animals/`.
/// Kept for parity documentation — the read adapter never parses it, but it
/// records the error shape the write slice must handle in a later step.
Map<String, dynamic> validationErrorJson() => <String, dynamic>{
  'place_of_catch': <dynamic>['This field is required.'],
  'spec': <dynamic>['Invalid pk "9999" - object does not exist.'],
};
