import 'package:acits_ui_kit/acits_ui_kit.dart';

import 'animals_l10n_keys.dart';

/// Пресеты сортировки списка животных. Первый — дефолт: «Сначала новые».
/// `ordering` — значение DRF-параметра сортировки для API.
const List<SortPreset> kAnimalSortPresets = <SortPreset>[
  SortPreset(id: 'newest', labelKey: AnimalsL10nKeys.sortNewest, ordering: '-date_joined'),
  SortPreset(id: 'oldest', labelKey: AnimalsL10nKeys.sortOldest, ordering: 'date_joined'),
  SortPreset(id: 'name_asc', labelKey: AnimalsL10nKeys.sortNameAsc, ordering: 'name'),
  SortPreset(id: 'name_desc', labelKey: AnimalsL10nKeys.sortNameDesc, ordering: '-name'),
  SortPreset(id: 'spec', labelKey: AnimalsL10nKeys.sortSpec, ordering: 'spec'),
  SortPreset(id: 'status', labelKey: AnimalsL10nKeys.sortStatus, ordering: 'status'),
  SortPreset(id: 'young', labelKey: AnimalsL10nKeys.sortYoung, ordering: '-birth_date'),
  SortPreset(id: 'old', labelKey: AnimalsL10nKeys.sortOld, ordering: 'birth_date'),
];
