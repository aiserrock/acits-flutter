// Wire JSON fixtures for the prescriptions + drugs slice — the shapes the app
// historically parsed off the backend.

/// A prescription list page (by animal) with two items: a course-of-treatment
/// (with drugs + executions) and one with an unknown/absent `my_type`.
Map<String, dynamic> prescriptionListByAnimalJson() => {
  'count': 2,
  'next': null,
  'previous': null,
  'results': [
    {
      'id': 11,
      'url': 'https://api.acits.ru/api/v1/prescriptions/11/',
      'animal': 501,
      'my_type': 'COURSE_OF_TREATMENT',
      'duration': 'EVERY_WEEK',
      'description': 'Курс антибиотиков',
      'created_by': 'Иванов И.',
      'updated_by': 'Петров П.',
      'drugs': [
        {
          'drug_id': 7,
          'drug_name': 'Амоксициллин',
          'drug_dosage': 2.5,
          'usage_instruction': 'После еды',
          'form_of_drug': 'Таблетка',
        },
      ],
      'executions': [
        {'id': 100, 'execute_at': '2024-05-01T09:00:00Z', 'status': 'IN_PROGRESS'},
        {'id': 101, 'execute_at': '2024-05-08T09:00:00Z', 'status': 'DONE'},
      ],
      'extra_type_attributes': {'foo': 'bar'},
    },
    {
      'id': 12,
      'animal': 501,
      // my_type отсутствует — плоский DTO должен это стерпеть (unknown).
      'drugs': [],
      'executions': [],
    },
  ],
};

/// A single prescription (retrieve) with a not-yet-known `my_type` value —
/// must NOT crash (the generated sealed type would throw here).
Map<String, dynamic> prescriptionUnknownTypeJson() => {
  'id': 99,
  'animal': 501,
  'my_type': 'SOME_FUTURE_TYPE',
  'drugs': [],
  'executions': [
    {'id': 1, 'execute_at': '2024-06-01T12:00:00Z', 'status': 'CANCELLED'},
  ],
};

/// Today executions page — embeds a PrescriptionShort with an AnimalShort.
Map<String, dynamic> todayExecutionsJson() => {
  'count': 1,
  'next': null,
  'previous': null,
  'results': [
    {
      'id': 900,
      'execute_at': '2024-05-01T09:00:00Z',
      'prescription': {
        'id': 11,
        'my_type': 'VACCINATION',
        'extra_type_attributes': null,
        'description': 'Ежегодная вакцинация',
        'animal': {
          'id': 501,
          'uuid': '3f2504e0-4f89-41d3-9a0c-0305e82c3301',
          'name': 'Барсик',
          'spec_name': 'Кошка',
          'spec_parent_name': 'Кошачьи',
          'avatar': 'https://cdn.acits.ru/small.jpg',
          'default_image_id': 3,
        },
        'drugs': [
          {
            'drug_id': 7,
            'drug_name': 'Вакцина',
            'drug_dosage': 1.0,
            'usage_instruction': '',
            'form_of_drug': 'Инъекция',
          },
        ],
        'created_by': 'Иванов И.',
        'updated_by': 'Иванов И.',
        'files': null,
      },
    },
  ],
};

/// Drug catalogue list page (ShelterDrug envelope: `{drug: Drug, drug_residues_count}`).
Map<String, dynamic> drugListJson() => {
  'count': 1,
  'next': null,
  'previous': null,
  'results': [
    {
      'drug': {
        'id': 7,
        'name': 'Амоксициллин',
        'usage_instruction': 'После еды',
        'form_of_drug': 3,
        'form_of_drug_name': 'Таблетка',
      },
      'drug_residues_count': 42,
    },
  ],
};
