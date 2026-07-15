# Implementation Plan: Поиск + чипсы сортировки

Спека: `docs/design-specs/search-and-sort-chips.md`
Стек: Flutter 3.44.0 (fvm). Кодоген: `fvm dart run build_runner build --delete-conflicting-outputs`.
Формат: `fvm dart format -l 120 .`. Анализ: `fvm dart analyze .`.

## Соглашения проекта (обнаружено)
- State-management: `bloc`/`cubit` + `flutter_bloc`, `Equatable`, `safeEmit` (`util/bloc_ext.dart`).
- Загрузка: `DataState<T>` (`util/data_state.dart`) + `DataStateBuilder`.
- l10n: easy_localization, ключи в `assets/translations/{ru,en}.json`, кодоген в
  `lib/gen/l10n/locale_keys.g.dart` (класс `LocaleKeys`). Уже есть `commonSort`,
  `commonSearch`.
- API: `apiV1AnimalsGet(search:, ordering:)`, `apiV1PrescriptionsExecutionsGet(search:, ordering:)`.
- Guard от устаревших ответов: generation counter (образец — `AnimalsCubit._requestGen`).

---

## Task 1 — Модель пресетов сортировки
**Файл (new):** `lib/ui/screen/common/sort/sort_preset.dart`
- `class SortPreset extends Equatable { final String id, labelKey, ordering; }`
- `const AnimalSortPresets` — список из 8 (newest дефолт … birth_date). Значения
  `ordering` строго из спеки.
- `const TodaySortPresets` — список из 5 (time дефолт … animal_spec).
- Экспорт дефолта-геттера у каждого списка (`first` как дефолт — newest / time).

**Проверка:** компилируется, `AnimalSortPresets.first.id == 'newest'`.

## Task 2 — l10n ключи чипсов
**Файлы:** `assets/translations/ru.json`, `assets/translations/en.json`
- Добавить ключи под каждый `labelKey`: `sortNewest, sortOldest, sortNameAsc,
  sortNameDesc, sortSpec, sortStatus, sortYoung, sortOld` (Животные) и
  `sortTime, sortTimeDesc, sortAnimalNameAsc, sortAnimalNameDesc, sortAnimalSpec`
  (Сегодня). Переиспользовать существующий `commonSort` как лейбл ленты.
- Прогнать кодоген l10n (build_runner) → обновится `LocaleKeys`.

**Проверка:** `LocaleKeys.sortNewest` существует после кодогена.

## Task 3 — Виджет ленты чипсов `SortChipsBar`
**Файл (new):** `lib/ui/screen/common/sort/sort_chips_bar.dart`
- `StatelessWidget`, параметры: `List<SortPreset> presets`, `String activeId`,
  `ValueChanged<SortPreset> onSelected`.
- Вёрстка: `Row[ Icon(Icons.sort) + Text(commonSort) : ]` слева, затем
  горизонтальный `ListView`/`SingleChildScrollView` из `ChoiceChip` (radio:
  `selected == p.id == activeId`, `onSelected` → колбэк). Один активный.
- Активный чипс автоскроллится в видимую зону при первом построении
  (`ScrollController` + `Scrollable.ensureVisible` через ключи, либо расчётный
  offset). Держать простым — при желании отложить автоскролл в отдельный подтаск.
- Тема: цвета из `Theme.of(context).colorScheme` (проект на ColorScheme, тёмная
  тема поддержана — не хардкодить цвета).

**Проверка:** виджет показывает N чипсов, тап меняет `activeId` через колбэк.

## Task 4 — Сервисы: проброс ordering
**Файл:** `lib/service/animal/animal_service.dart`
- `fetchAnimalList` уже есть `searchRequest`; **добавить `String? ordering`** и
  прокинуть в `apiV1AnimalsGet(ordering: ordering)`.

**Файл:** `lib/service/prescription/prescription_service.dart`
- `fetchTodayPrescriptionList` — **добавить `String? search, String? ordering`** и
  прокинуть в `apiV1PrescriptionsExecutionsGet(search:, ordering:)`.

**Проверка:** сигнатуры принимают параметры, existing-вызовы не сломаны
(параметры опциональные).

## Task 5 — AnimalsCubit: поиск + сортировка
**Файлы:** `lib/ui/screen/animals/cubit/animals_state.dart`, `animals_cubit.dart`
- State: добавить `String searchRequest` (default `''`), `SortPreset activeSort`
  (default `AnimalSortPresets.first`). Обновить `copyWith`/`props`.
- Cubit:
  - `onSearchChanged(String q)` — debounce 300ms (Timer в cubit или
    `stream_transform`; проще Timer-debounce), сохранить `q`, `loadAnimalList(reset)`.
  - `onSortChanged(SortPreset p)` — сохранить, `loadAnimalList(reset)`.
  - `loadAnimalList` — пробросить `searchRequest: state.searchRequest`,
    `ordering: state.activeSort.ordering` в `fetchAnimalList`. Сохранить существующий
    generation-guard.
  - Дефолт при старте — `activeSort = newest`, значит первый запрос уже с
    `ordering=-date_joined`.

**Проверка:** смена сортировки/поиска ре-грузит список offset=0 с обоими параметрами.

## Task 6 — AnimalsScreen: подключить UI
**Файл:** `lib/ui/screen/animals/animals_screen.dart`
- `TextField` в `_buildTitle`: добавить `controller` (новый
  `TextEditingController` в state) + listener → `cubit.onSearchChanged`.
  Выровнять: `textAlignVertical: center`, префикс-иконка поиска, суффикс-крестик
  (крестик очищает текст, не выходит из режима). Единообразно с `search_spec_screen`.
- Под `AppBar` (в body, над списком): вставить `SortChipsBar(presets:
  AnimalSortPresets, activeId: state.activeSort.id, onSelected: cubit.onSortChanged)`.
  Видима и в обычном режиме, и при поиске.
- Empty-state при активном поиске: текст «ничего не найдено» (существующий
  `_buildEmptyState`/`commonNotFound`).

**Проверка:** ввод текста фильтрует, тап чипса сортирует, крестик чистит.

## Task 7 — MainCubit + MainScreen (вкладка «Сегодня»)
**Файлы:** `lib/ui/screen/main/cubit/main_cubit.dart` (+ new `main_state.dart`),
`lib/ui/screen/main/main_screen.dart`
- Ввести `MainState` (Equatable): `DataState<...> data`, `String searchRequest`,
  `SortPreset activeSort` (default `TodaySortPresets.first`). Переключить
  `MainCubit extends Cubit<MainState>`.
- `onSearchChanged` (debounce 300ms) + `onSortChanged`, generation-guard
  (добавить, по образцу AnimalsCubit).
- `loadExecutions` — пробросить `search`, `ordering` в
  `fetchTodayPrescriptionList`.
- MainScreen: убрать локальный `_isSearchActive`/`_searchController`-без-listener
  → поиск через cubit (listener на controller). Вставить `SortChipsBar(presets:
  TodaySortPresets, ...)` под шапкой. Empty-state при поиске.
- Обновить `_buildBody`/`BlocBuilder` тип на `MainState`.

**Проверка:** «Сегодня» ищет и сортирует так же, как «Животные».

## Task 8 — Прогон и правки
- `fvm dart run build_runner build --delete-conflicting-outputs` (l10n + любые
  генераторы).
- `fvm dart format -l 120 .`
- `fvm dart analyze .` — 0 ошибок.
- Ручная проверка: обе вкладки, светлая/тёмная тема, пустой поиск, длинная лента
  чипсов (горизонтальный скролл + автоскролл к активному).

---

## Порядок исполнения
1 → 2 → 4 (независимы, можно параллельно) → 3 → 5 → 6 (Животные, вертикальный
срез готов, проверяемо) → 7 (Сегодня) → 8.

## Риски / примечания
- Вложенные `ordering` (`prescription__animal__*`), `spec`, `status` могут быть не
  в `ordering_fields` бэкенда → проверить на живом API, лишние пресеты выкинуть из
  Task 1 списков. mockoon это не покажет.
- Debounce лучше держать в cubit, чтобы UI оставался тонким и тестируемым.
- Не хардкодить цвета — проект перешёл на ColorScheme (тёмная тема, коммит 20af93d1).
