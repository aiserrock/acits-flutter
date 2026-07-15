import 'package:equatable/equatable.dart';

import 'package:acits_flutter/gen/l10n/locale_keys.g.dart';

/// Пресет сортировки для ленты чипсов.
///
/// Один чипс = целый готовый режим сортировки: подпись ([labelKey]) + значение
/// серверного параметра `ordering` ([ordering]). Пресеты взаимоисключающие —
/// активен ровно один. [id] — стабильный ключ для сравнения активного пресета
/// (не завязан на локализованную подпись).
class SortPreset extends Equatable {
  const SortPreset({required this.id, required this.labelKey, required this.ordering});

  /// Стабильный идентификатор пресета (для `selected`/сравнения).
  final String id;

  /// Ключ локализации подписи чипса ([LocaleKeys]).
  final String labelKey;

  /// Значение query-параметра `ordering` для API. Префикс `-` — убывание.
  /// Вложенные поля — через `__` (DRF): напр. `prescription__animal__name`.
  final String ordering;

  @override
  List<Object?> get props => [id, labelKey, ordering];
}

/// Пресеты сортировки списка животных (модель `AnimalRead`).
///
/// Первый элемент — дефолт (активен при открытии экрана): «Сначала новые».
const List<SortPreset> kAnimalSortPresets = <SortPreset>[
  SortPreset(id: 'newest', labelKey: LocaleKeys.sortNewest, ordering: '-date_joined'),
  SortPreset(id: 'oldest', labelKey: LocaleKeys.sortOldest, ordering: 'date_joined'),
  SortPreset(id: 'name_asc', labelKey: LocaleKeys.sortNameAsc, ordering: 'name'),
  SortPreset(id: 'name_desc', labelKey: LocaleKeys.sortNameDesc, ordering: '-name'),
  SortPreset(id: 'spec', labelKey: LocaleKeys.sortSpec, ordering: 'spec'),
  SortPreset(id: 'status', labelKey: LocaleKeys.sortStatus, ordering: 'status'),
  SortPreset(id: 'young', labelKey: LocaleKeys.sortYoung, ordering: '-birth_date'),
  SortPreset(id: 'old', labelKey: LocaleKeys.sortOld, ordering: 'birth_date'),
];

/// Пресеты сортировки списка исполнений на сегодня
/// (модель `PrescriptionExecutionToday`).
///
/// Первый элемент — дефолт: «По времени».
const List<SortPreset> kTodaySortPresets = <SortPreset>[
  SortPreset(id: 'time', labelKey: LocaleKeys.sortTime, ordering: 'execute_at'),
  SortPreset(id: 'time_desc', labelKey: LocaleKeys.sortTimeDesc, ordering: '-execute_at'),
  SortPreset(id: 'animal_name_asc', labelKey: LocaleKeys.sortAnimalNameAsc, ordering: 'prescription__animal__name'),
  SortPreset(id: 'animal_name_desc', labelKey: LocaleKeys.sortAnimalNameDesc, ordering: '-prescription__animal__name'),
  SortPreset(id: 'animal_spec', labelKey: LocaleKeys.sortAnimalSpec, ordering: 'prescription__animal__spec_name'),
];
