# Design Spec: Поиск + чипсы сортировки (вкладки «Сегодня» и «Животные»)

## Problem

Поиск на вкладках «Сегодня» (`MainScreen`) и «Животные» (`AnimalsScreen`) не
работает вообще. Причина одна на обеих вкладках — `TextField` в шапке не связан
с бизнес-логикой:

- **«Животные»** (`animals_screen.dart` → `_buildTitle`): `TextField` без
  `controller`, без `onChanged`/listener. Ввод уходит в никуда. `AnimalsCubit`
  не имеет метода поиска, `loadAnimalList` дёргает `fetchAnimalList` без
  `searchRequest`.
- **«Сегодня»** (`main_screen.dart` → `_buildTitle`): `controller` есть, но нет
  `addListener`/`onChanged`. `MainCubit` не умеет искать; `fetchTodayPrescriptionList`
  не пробрасывает `search`.

При этом бэкенд-контракт **уже готов**: `apiV1AnimalsGet` и
`apiV1PrescriptionsExecutionsGet` принимают `search` и `ordering`;
`AnimalService.fetchAnimalList(searchRequest:)` уже прокидывает поиск. Чинить
надо только проводку UI → cubit → service, бэкенд не трогаем.

Вторая часть — чипсы над списком (со скрина Figma): это **сортировка**
(серверный `ordering`), а не фильтры-подмножества. Пользователи путают их с
фильтрами — надо визуально обозначить как сортировку.

Успех: набрал текст → список фильтруется; тапнул чипс → список пересортировался;
поиск и сортировка комбинируются в одном запросе; выравнивание поля ввода
аккуратное.

## Solution Overview

- Починить поиск на обеих вкладках: подключить `TextEditingController` +
  listener → cubit-метод → service с `searchRequest`, с debounce и защитой от
  устаревших ответов (generation counter, как уже сделано в `AnimalsCubit`).
- Выровнять поле поиска в шапке (вертикальное центрирование текста, паддинги,
  префикс-иконка/крестик) — единообразно на обеих вкладках.
- Добавить горизонтальную ленту чипсов сортировки под шапкой. Пресеты
  взаимоисключающие (radio, один активный). Каждый чипс = готовая фраза + один
  серверный `ordering`.
- Явно обозначить, что это сортировка: перед лентой лейбл `⇅ Сортировка:`
  (`Icons.sort` + подпись), чтобы не путали с фильтрами.
- Дефолтный активный пресет — «Сначала новые» (`-date_joined`) для «Животных»,
  «По времени» (`execute_at`) для «Сегодня». Активный чипс автоскроллится в
  видимую зону.
- Поиск и сортировка **независимы и комбинируются**: оба уходят в один запрос
  (`search=… & ordering=…`). Смена одного сохраняет второе.
- Пресеты вынесены в конфиг-список — легко править, безопасный дефолт при
  игнорировании `ordering` бэкендом.

## Scope

- In scope:
  - Починка поиска на `MainScreen` и `AnimalsScreen`.
  - Выравнивание/вёрстка поля ввода поиска.
  - Лента чипсов сортировки + лейбл «Сортировка» на обеих вкладках.
  - Проброс `search` в `fetchTodayPrescriptionList` (сейчас его нет).
  - Проброс `ordering` в `AnimalService.fetchAnimalList` и в today-запрос.
  - Комбинирование search + ordering в одном запросе.

- Out of scope:
  - Модальный `Search<T>` picker (`search_screen/`), `SearchScreen` (выбор вида)
    — это отдельные экраны выбора, у них поиск уже работает.
  - Реальные фильтры-подмножества (по статусу как отбор, а не сортировка) —
    другой API-контракт, отдельная задача.
  - Изменение бэкенда / OpenAPI-схемы.
  - Пагинация — остаётся как есть, но должна переиспользовать текущие
    search + ordering при догрузке страниц.

## Architecture Sketch

```
AnimalsScreen / MainScreen (StatefulWidget)
  ├─ AppBar.title: TextField ──(listener, debounce 300ms)──► Cubit.onSearchChanged(q)
  ├─ под AppBar: SortChipsBar
  │     ├─ лейбл  ⇅ Сортировка:
  │     └─ ListView.horizontal[ ChoiceChip(preset) ] ──► Cubit.onSortChanged(preset)
  └─ body: список (существующий)

Cubit (AnimalsCubit / MainCubit)
  ├─ state: + searchRequest:String, + activeSort:SortPreset
  ├─ onSearchChanged(q)  → сохранить q, reload(offset=0)
  ├─ onSortChanged(p)    → сохранить p, reload(offset=0)
  └─ load*(...)          → service.fetch(search: searchRequest, ordering: activeSort.value, ...)

Service
  ├─ AnimalService.fetchAnimalList(searchRequest, ordering, limit, offset)   // + ordering
  └─ PrescriptionService.fetchTodayPrescriptionList(search, ordering)         // + оба параметра
```

Общий виджет `SortChipsBar` (переиспользуемый обеими вкладками) принимает
`List<SortPreset>`, `activeId`, `onSelected`. Debounce/generation-guard —
на уровне cubit (в `AnimalsCubit` generation counter уже есть, для `MainCubit`
добавить аналогичный).

## Data Model

- `SortPreset` — value object: `id` (стабильный ключ), `labelKey` (l10n),
  `ordering` (строка для API, напр. `-date_joined`).
- `AnimalSortPresets` — список из 8 пресетов (см. таблицу ниже).
- `TodaySortPresets` — список из 5 пресетов.
- `AnimalsState` — добавить `searchRequest:String`, `activeSort:SortPreset`.
- `MainCubit` state — сейчас голый `DataState<...>`; расширить до объекта
  состояния с полями `data`, `searchRequest`, `activeSort` (либо ввести
  `MainState`, аналогично `AnimalsState`).

### Пресеты — «Животные» (модель `AnimalRead`)

| id | label | ordering |
|----|-------|----------|
| newest *(default)* | Сначала новые | `-date_joined` |
| oldest | Сначала старые | `date_joined` |
| name_asc | По имени А–Я | `name` |
| name_desc | По имени Я–А | `-name` |
| spec | По породе | `spec` |
| status | По статусу | `status` |
| young | Моложе → старше | `-birth_date` |
| old | Старше → моложе | `birth_date` |

### Пресеты — «Сегодня» (модель `PrescriptionExecutionToday`)

| id | label | ordering |
|----|-------|----------|
| time *(default)* | По времени | `execute_at` |
| time_desc | Сначала поздние | `-execute_at` |
| animal_name_asc | По кличке А–Я | `prescription__animal__name` |
| animal_name_desc | По кличке Я–А | `-prescription__animal__name` |
| animal_spec | По виду | `prescription__animal__spec_name` |

> **Риск:** OpenAPI-схема (`doc/api/openapi.json`) объявляет `ordering` как голый
> `string` и не перечисляет разрешённые поля; mockoon игнорирует `ordering`
> вовсе. Вложенные (`prescription__animal__*`), а также `spec`/`status` могут
> быть не внесены в `ordering_fields` бэкенда. Стратегия: дефолт всегда
> безопасный; если бэкенд игнорирует `ordering` — вернётся дефолтный порядок,
> приложение не падает. Финальный список пресетов проверить прогоном по **живому**
> API и выкинуть неработающие.

## Screens / Flows (UI tasks)

- **AnimalsScreen (вкладка «Животные»)**
  - Purpose: список животных с поиском и сортировкой.
  - Key states: loading / content / empty («ничего не найдено» при активном
    поиске) / error; пагинация внизу.
  - Поле поиска: выровнено (текст по центру по вертикали, префикс-иконка поиска,
    суффикс-крестик очистки), очистка не выходит из режима поиска, а очищает
    строку.
  - Лента сортировки: видима всегда (и в обычном режиме, и при поиске), под
    шапкой, лейбл «Сортировка».
- **MainScreen (вкладка «Сегодня»)**
  - Purpose: исполнения назначений на сегодня с поиском и сортировкой.
  - Идентичная механика (лента + поиск), но пресеты `TodaySortPresets`.
  - Key states: те же.

Entry/exit: тап на иконку поиска в `actions` → режим поиска (поле в шапке).
Крестик очищает строку; выход из режима поиска — существующей кнопкой.

## Alternatives Considered

1. **B — две группы чипсов (поле × направление)** — отвергнут: две группы хуже
   считываются как «сортировка», «направление» для даты неоднозначно
   («А–Я» для даты непонятно), не отвечает требованию «людям должно быть
   понятно».
2. **C — реальные фильтры-подмножества (по статусу как отбор)** — отвергнут:
   другой API-параметр, которого нет в клиенте; требует доработки контракта.
   Вынесен из scope.
3. **Wrap-лента в 2 строки** — отвергнута: съедает вертикаль над списком; на
   скрине Figma лента горизонтальная (чипсы обрезаны справа).
4. **Клиентская сортировка/фильтрация** — отвергнута: список пагинируется,
   сортировать/искать надо на сервере, иначе результат неполный.

## Open Questions

- Ни одного блокирующего. На этапе имплементации: проверить на живом бэкенде,
  какие `ordering` реально поддерживаются (особенно `prescription__animal__*`,
  `spec`, `status`), и подрезать список пресетов по факту.

## Next Step

Hand this spec to `writing-plans` skill to produce a task-level plan.
Стек — Flutter (`.dart`, `lib/ui/screen/...`), имплементацию будет вести
Flutter-профиль планировщика.
