// Wire JSON fixtures for the animal notes slice.

/// Notes list page for an animal (two notes, newest first).
Map<String, dynamic> animalNotesListJson() => {
  'count': 2,
  'next': null,
  'previous': null,
  'results': [
    {
      'id': 5,
      'url': 'https://api.acits.ru/api/v1/animals/notes/5/',
      'animal': 501,
      'content': 'Второй комментарий',
      'files': [
        {
          'id': 3,
          'file': 'https://cdn.acits.ru/note5.pdf',
          'name': 'note5',
          'filename': 'note5.pdf',
          'created_at': '2024-05-02T10:00:00Z',
        },
      ],
      'created_at': '2024-05-02T10:00:00Z',
      'updated_at': '2024-05-02T10:00:00Z',
      'created_by': 'Иванов И.',
      'updated_by': 'Иванов И.',
      'is_user_can_edit_or_delete': true,
    },
    {
      'id': 4,
      'url': 'https://api.acits.ru/api/v1/animals/notes/4/',
      'animal': 501,
      'content': 'Первый комментарий',
      'files': null,
      'created_at': '2024-05-01T10:00:00Z',
      'updated_at': '2024-05-01T10:00:00Z',
      'created_by': 'Петров П.',
      'updated_by': 'Петров П.',
      'is_user_can_edit_or_delete': false,
    },
  ],
};

/// A single created note (response to POST).
Map<String, dynamic> createdAnimalNoteJson() => {
  'id': 6,
  'url': 'https://api.acits.ru/api/v1/animals/notes/6/',
  'animal': 501,
  'content': 'Новый комментарий',
  'files': null,
  'created_at': '2024-05-03T10:00:00Z',
  'updated_at': '2024-05-03T10:00:00Z',
  'created_by': 'Иванов И.',
  'updated_by': 'Иванов И.',
  'is_user_can_edit_or_delete': true,
};
