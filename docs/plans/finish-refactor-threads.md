# План: доделать незавершённые нитки ветки `refactor/foundation`

Ветка `refactor/foundation`, последний коммит `0f866774` (2026-07-18). В рабочем
дереве 254 незакоммиченных файла — три смысловые нитки в разной степени
готовности. Цель: довести до зелёного гейта, починить найденные дефекты,
разложить по тематическим коммитам.

## Что уже проверено (факты, а не догадки)

| Проверка | Результат |
| --- | --- |
| `flutter analyze --fatal-infos --fatal-warnings` | ✅ No issues found |
| Root-тесты (`flutter test`) | ✅ 56 passed |
| Тесты 11 модулей | ✅ 295 passed суммарно |
| `flutter build web --release` (prod) | ✅ Built |
| `modules/ui_kit/example` build web | ✅ Built |
| widgetbook в prod-бандле | ✅ Отсутствует (tree-shaken, проверено grep по литералам) |
| `melos check-all` | ❌ **FAILED на format:check** |
| `preprocess_openapi.dart` | ✅ Воспроизводится: 96 dropped, 275 relaxed |

Три нитки в дереве:
1. **widgetbook-галерея** — `ui_kit/lib/gallery/` (17 страниц) + мост в
   example и в shell, роут `/debug/gallery`, вход через `_UIKitCard` в dev
   debug-экране. Брендинг example сделан.
2. **Patrol e2e** — 4 сценария + `support/`, android-обвязка, gitignore.
3. **Фикс nullability swagger_parser** — глобальный relax в
   `preprocess_openapi.dart` + nullable DTO + `?? ''` в адаптерах/мапперах.

## Найденные дефекты

### D1. Format-дрейф на 80 колонок (13 файлов)
`melos check-all` падает. 11 файлов в `modules/` + 2 в корне
(`lib/run_app.dart`, `test/dev/service/client/acits_api_register.dart`)
отформатированы на 80 колонок вместо проектных 120.

Корневая причина: **в `analysis_options.yaml` нет секции `formatter.page_width`**,
поэтому IDE (и `dart format` без флага) применяет дефолт 80. Правило «120» живёт
только в аргументе `-l 120` у melos/CI — редактор о нём не знает.

### D2. `format:check` не видит `modules/` (дыра в гейте)
Скрипты `format`/`format:check` в `pubspec.yaml` и шаг Verify formatting в
`.github/workflows/ci.yml` делают `find lib test` — только корень. Весь код
модулей вне проверки, поэтому D1 копился незаметно.

### D3. CI пропускает тесты `modules/base/*` (108 тестов)
Цикл в `ci.yml` — `for p in packages/* modules/*`. `modules/base/` — это
контейнер, тесты лежат на уровень глубже: `modules/base/{core,navigation,network,util}`.
Цикл видит `modules/base` (без `test/`) и пропускает. 108 тестов не гоняются в CI.

### D4. `melos test` гоняет только корень
`melos test` = `flutter test` (56 тестов). Модульных тестов (239) в нём нет,
хотя CI их (частично) гоняет. Локальный `check-all` слабее CI.

### D5. `modules/ui_kit/README.md` описывает удалённый storybook
Секция «Storybook example» рассказывает про `storybook_flutter`, которого больше
нет — заменён на widgetbook.

### D6. CHANGELOG не отражает ветку
`[Unreleased]` пуст при ~50 коммитах re-architecture в ветке.

### D7. iOS-обвязка Patrol отсутствует
`ios/` имеет только таргет `Runner`. Для `patrol test` на iOS нужен таргет
`RunnerUITests` + `RunnerUITests.m` + `inherit! :complete` в Podfile.
Конфигурации флейворов уже есть (Debug/Profile/Release × dev/prod),
`DEVELOPMENT_TEAM = 45G32KJDV7`, bundle id `ru.acits` + suffix.

## Шаги

### Шаг 1 — закрепить ширину строки в конфиге (D1 корень)
- В корневой `analysis_options.yaml` добавить:
  ```yaml
  formatter:
    page_width: 120
  ```
- То же в `analysis_options.yaml` каждого модуля — их 12 штук, они
  `include: package:flutter_lints/flutter.yaml` и **не** наследуют корневой
  конфиг (отдельные пакеты воркспейса).
- Прогнать `dart format -l 120` по 13 съехавшим файлам, вернув 120-колоночный вид.

Проверка: `dart format --output=none --set-exit-if-changed -l 120` по всему
hand-written коду проходит.

### Шаг 2 — закрыть дыры гейта (D2, D3, D4)
- `pubspec.yaml`, скрипты `format`/`format:check`: заменить `find lib test` на
  обход корня **и** всех модулей. Один общий список путей, чтобы скрипты не
  разъезжались.
- `pubspec.yaml`, скрипт `test`: гонять корень + каждый пакет с `test/`,
  включая вложенные `modules/base/*` (тот же цикл, что в CI).
- `.github/workflows/ci.yml`:
  - шаг Verify formatting — тот же расширенный список путей;
  - цикл тестов — `for p in packages/* modules/* modules/base/*`.

Проверка: `melos check-all` зелёный; цикл руками находит все 11 пакетов с тестами.

### Шаг 3 — iOS-обвязка Patrol (D7)
- `ios/RunnerUITests/RunnerUITests.m` — по шаблону patrol 4.6.1:
  ```objc
  @import XCTest;
  @import patrol;
  @import ObjectiveC.runtime;

  PATROL_INTEGRATION_TEST_IOS_RUNNER(RunnerUITests)
  ```
- `ios/Podfile`: вложенный `target 'RunnerUITests' do inherit! :complete end`
  внутри `target 'Runner'`.
- `ios/Runner.xcodeproj/project.pbxproj`: добавить UI-тест-таргет скриптом на
  `xcodeproj` gem (1.27.0 стоит) — ручная правка pbxproj хрупкая. Таргет:
  `com.apple.product-type.bundle.ui-testing`, `TEST_TARGET_NAME = Runner`,
  bundle id `ru.acits.dev.RunnerUITests`, `DEVELOPMENT_TEAM = 45G32KJDV7`,
  все 6 flavor-конфигураций (Debug/Profile/Release × dev/prod) — иначе
  `patrol test --flavor dev` не найдёт конфигурацию.

**Честная оговорка:** прогнать `patrol test` на iOS в этой среде не смогу
(нужен подключённый девайс/симулятор с подписью). Проверю, что
`xcodebuild -list` видит таргет и `pod install` проходит. Реальный прогон —
на машине с iOS-тулчейном. Если после генерации таргета `pod install` или
`xcodebuild -list` падают — откачу шаг и оставлю iOS как есть, а не буду
чинить вслепую.

### Шаг 4 — актуализировать доки (D5, D6)
- `modules/ui_kit/README.md`: секцию «Storybook example» переписать под
  widgetbook — что каталог живёт в `ui_kit/lib/gallery/` (нейтральные
  `GalleryEntry` без зависимости на widgetbook), хосты — standalone `example/`
  и debug-экран в shell.
- `CHANGELOG.md`, `[Unreleased]`: записать ветку — re-architecture (модули,
  dio/ports вместо chopper), widgetbook-галерея, Patrol e2e, фикс nullability.
- `docs/design-specs/patrol-smoke-e2e.md`: в Open Questions снять пункт про
  iOS, если Шаг 3 прошёл.

### Шаг 5 — разложить по коммитам
После зелёного `melos check-all`, тематически:
1. `fix(api): tolerate nulls in over-declared OpenAPI response fields` —
   preprocess relax + nullable DTO + `?? ''` в адаптерах/мапперах + regenerated.
2. `feat(ui_kit): widgetbook gallery shared by example app and debug screen` —
   `gallery/` + мосты + роут + `isDevFlavor` + удаление `debug_drawer`.
3. `test(e2e): patrol smoke suite over the real dev API` — `integration_test/` +
   android-обвязка + gitignore (+ iOS-обвязка, если Шаг 3 прошёл).
4. `build(quality): enforce 120-col format and run module tests in the gate` —
   `formatter.page_width`, скрипты melos, `ci.yml`.
5. `docs: refresh ui_kit README, changelog and specs` — доки + анонимизация
   `dark-theme.md`.

Пуш и PR **не делаю** — только коммиты локально.

## Порядок и риск

Шаги 1→2 сначала: они чинят гейт, которым проверяются остальные. Шаг 3 —
единственный с внешним риском (pbxproj), изолирован и откатывается отдельно.
Шаги 4–5 механические.

После каждого шага: `melos check-all` + модульные тесты. В конце — `build web`
прод-флейвора для контроля, что gallery/widgetbook не протекли.
