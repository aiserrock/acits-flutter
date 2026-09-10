import 'package:localization/localization.dart';
import 'package:ui_kit/ui_kit.dart';

/// Пресеты сортировки списка животных. Первый — дефолт: «Сначала новые».
/// `ordering` — значение DRF-параметра сортировки для API.
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
