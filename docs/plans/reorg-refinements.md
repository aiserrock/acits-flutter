# План: доработка структуры по замечаниям (hamkormobile + smp_bank alignment)

Ветка `refactor/foundation`. 6 замечаний владельца после реорга packages→modules.
Каждый пункт = отдельный коммит, каждый проверяется: `analyze --fatal-infos --fatal-warnings`,
все тесты, prod+dev `build web`.

**ОБНОВЛЕНО:** assets переезжают в ui_kit (не остаются в корне) — владелец хочет собирать ui_kit
как отдельное приложение (полигон дизайн-системы), как в `smp_bank_copy/packages/ui_kit`.

**ПРАВКИ ВЛАДЕЛЬЦА (2-й раунд):** base НЕ вкладывать как base/base — инфру разложить модулями
прямо в `base/`; `lib/di` вынести в `modules/base/di` (как hamkor). Детали в Пункте 3.

## ✅ Решения владельца (зафиксировано)
1. **Вариант B** — мелко по hamkor: `base/{di, network, util, core, navigation, localization}`.
2. **Никаких `kit`** — `base/` это просто папка-контейнер, внутри модули с обычными именами.
   Пакет `base` (бывший acits_core) РАЗДЕЛЯЕТСЯ на `network` + `util` (пакета с именем `base` не будет).
3. **Деление acits_core:** `network` = Dio-транспорт (factory/interceptors/ports/seams);
   `util` = result+failure (пара Result<Failure,T>) + task + state + platform + util-хелперы.
   `network` зависит от `util` (для Failure в error-mapping).

---

## Пункт 1 — melos: отдельного файла НЕ будет

**Факт:** melos 8.x (наш) читает скрипты только из `melos:` блока в `pubspec.yaml`. Отдельный
`melos.yaml` со скриптами работает лишь на melos ^6 (как hamkor). Владелец выбрал НЕ даунгрейдить.

**Действие:** ничего не меняем в механике. Уже сделано в прошлой сессии (workspace-aware блок в pubspec).
Добавлю только поясняющий комментарий в pubspec, что отдельный melos.yaml требует melos 6.
**Коммит:** нет (или тривиальный doc-комментарий). По сути пункт закрыт как "невозможно без даунгрейда".

---

## Пункт 3 (+правки владельца) — базовые модули под `modules/base/`, БЕЗ вложенного base/base, di в base

**Эталон hamkor:** `modules/base/` — папка-контейнер с под-пакетами (`di`, `network`, `navigation`,
`core_services`, `tokens`, ...). `ui_kit` лежит ОТДЕЛЬНО в `modules/ui_kit`. melos подхватывает
`modules/base/*`. **`di` — отдельный модуль внутри base** (get_it + init-инфра).

**Правки владельца к первоначальному плану:**
1. **base/base НЕ создаём** — инфру бывшего `acits_core` раскладываем слоями прямо в `base/`
   (не прячем в под-папку `base/base`).
2. **`lib/di` → `modules/base/di`** (как у hamkorа).

### DI без цикла (проверено фактически)
Наш `di_container.config.dart` (генерится injectable) импортит 6 фича-модулей. У hamkorа `base/di`
ТОЖЕ импортит все фичи — **это не цикл**, потому что **фичи НЕ импортят `base/di`** (они используют
`GetIt.instance` из пакета `get_it` напрямую + зависят от `base/network`, но не от `base/di`).
Проверено: наши фичи используют только `GetIt.instance` (Talker-логгер), `base/di` не импортят.
→ DAG: `app → base/di → фичи → base/{network,util,core} + get_it(pub)`. Цикла нет.
Перенос: `@InjectableInit` + `initDi` + сгенерированный `di_container.config.dart` едут в `base/di`;
`melos genone base/di` (build_runner) регенерит config там. App вызывает `initDi()` из `package:di`.

### Целевое дерево (Вариант B, финал)

```
acits_flutter/
├── lib/                         # app shell (не пустой): main.dart(prod)/bootstrap.dart/firebase/
│                                #   navigation-tree/AuthService+ConfigService/res/gen/ui-shell
├── packages/                    # пусто (форки/generic-либы; README)
└── modules/
    ├── base/                            # ← папка-контейнер (melos: modules/base/*)
    │   ├── util/                        #   package:util — result+failure (Result<Failure,T>) +
    │   │                                #     task(AppTask) + state(DataState) + platform ports +
    │   │                                #     util(datetime_format/validator/bloc_ext/
    │   │                                #     url_cors_proxy/app_version). Зависит: ничего внутр.
    │   ├── network/                     #   package:network — Dio factory + auth/header interceptors
    │   │                                #     + network ports + seams. Зависит: util (Failure).
    │   ├── di/                          #   package:di — GetIt + @InjectableInit + config
    │   │                                #     (был lib/di). Зависит: все фичи (их DI-регистрация).
    │   ├── core/                        #   package:core — domain/ (сущности/mapper/repo-iface) +
    │   │                                #     api/ (порты/DTO/swagger_parser-адаптеры/generated).
    │   │                                #     Зависит: util+network.
    │   ├── navigation/                  #   package:navigation — route-примитивы. Зависит: util.
    │   └── localization/                #   package:localization — LocaleKeys (был l10n).
    ├── ui_kit/                          # ← ОТДЕЛЬНО (дизайн-система + assets + example, п.7)
    ├── animals/  auth/  applicants/     # фичи плоско в modules/
    ├── prescriptions/  personal/  media/
```

**Граф (DAG, без циклов):**
```
app → di → {6 фич} → {util, network, core, navigation, localization, ui_kit}
core → network → util ;  navigation → util ;  ui_kit → util
фичи используют GetIt.instance (пакет get_it), но НЕ package:di → цикла нет.
```

**Что меняется в импортах (высокий churn):** сейчас всё под `package:base/base.dart`. После деления:
- `package:base/base.dart` → `package:util/util.dart` И/ИЛИ `package:network/network.dart` (по символам:
  Result/Failure/DataState/AppTask/util → util; Dio/interceptors/ports → network). Каждый импортёр
  base пересматривается: что именно берёт → правильный из двух пакетов (или оба).
- Пакета/барреля `base` больше НЕТ.

### Действия
1. Создать `modules/base/util` + `modules/base/network`, разложить содержимое бывшего `modules/base/lib/src/*`
   по ним (util: result/failure/task/state/platform/util; network: network/*). Barrel `util.dart`/`network.dart`.
2. `git mv modules/core modules/base/core`, `modules/navigation → modules/base/navigation`,
   `modules/l10n → modules/base/localization` (localization из п.5).
3. `lib/di/*` (di_container.dart + config) → `modules/base/di/lib/`; `@InjectableInit` там;
   `initDi`/`getIt` экспортит `package:di`. App вызывает `package:di` вместо `lib/di`.
4. Переписать ВСЕ `package:base/base.dart` → `package:util/util.dart`/`package:network/network.dart`
   по фактически используемым символам (пройтись по каждому импортёру).
5. Обновить `path:`/`workspace:`/melos (`genapi` cd → `modules/base/core`; `l10n`-gen →
   `modules/base/localization`; `genone` примеры). Добавить `modules/base/*` в workspace, убрать плоские.
6. `fvm flutter pub get`; `melos genone` для base/di (регенерит DI config на новом месте) + base/core (swagger).

**Риск:** ВЫСОКИЙ — дробление `base` на util+network трогает все импорты base (десятки файлов) +
перенос DI (регенерация config, проверка цикла) + 4 git mv контейнера. Делать аккуратно, поэтапно
внутри фазы (сначала util+network split зелёный, потом контейнеризация путей, потом di).
**Коммит(ы):** `refactor(base): split base→util+network` + `refactor(base): container modules/base/* + move DI`

---

## Пункт 5 — l10n → localization (easy_localization-имена)

**Действия:**
1. `git mv modules/l10n modules/base/localization` (переезд + группировка из п.3 сразу).
2. Package name `l10n` → `localization`; barrel `l10n.dart` → `localization.dart`.
3. Файл `src/locale_keys.g.dart` — оставить стандартное easy_localization имя (`locale_keys.g.dart`
   — оно И ЕСТЬ стандартное для `-f keys`). `LocaleKeys` класс — оставить (стандарт).
4. Все импорты `package:l10n/l10n.dart` → `package:localization/localization.dart`.
5. melos `l10n`-скрипт: выход `modules/l10n/lib/src` → `modules/base/localization/lib/src`.
6. Обновить pubspec deps `l10n:` → `localization:` во всех модулях + root.

**Коммит:** `refactor(localization): rename l10n module → localization (easy_localization naming)`

---

## Пункт 4 — mason.yaml отдельным файлом

**Факт:** mason читает `mason.yaml` из корня независимо от melos (в отличие от melos-скриптов).
У нас `mason.yaml` УЖЕ отдельный файл в корне (создан в прошлой сессии). **Проверить**, что он
корректен и bricks резолвятся; если mason-конфиг где-то в pubspec — вынести.

**Действие:** верифицировать `mason.yaml` отдельный и рабочий (`mason get`/`mason make --help`).
Скорее всего уже сделано → коммита нет или тривиальная правка путей bricks под новую структуру.

---

## Пункт 2 + 6 — мёртвые/дублирующиеся файлы

**Найденные кандидаты (shims/дубли после переносов):**
| Файл | Статус | Импортеров | Действие |
|---|---|---|---|
| `lib/res/theme.dart` | shim → ui_kit | 5 | переключить импортеры на `package:ui_kit/ui_kit.dart`, удалить |
| `lib/domain/exception.dart` | shim → core | 3 | переключить на `package:core/domain.dart`, удалить |
| `lib/domain/registration_input.dart` | shim → auth | 1 | переключить на `package:auth/auth.dart`, удалить |
| `lib/res/icon.dart` (`IconRes`) | ДУБЛЬ ui_kit | 1 | переключить на `package:ui_kit/ui_kit.dart` (IconRes), удалить |
| `lib/res/l10n.dart` (`L10n`) | проверить | 1 | если дубль localization-конфига — удалить, иначе оставить |
| `lib/domain/animal_sex_enum.dart` | проверить дубль core.AnimalSex | 1 | сверить, при дубле — удалить |

**Действия:**
1. Для каждого shim: `grep` импортеров → переписать на реальный источник → удалить shim.
2. Полный проход по `lib/` + `modules/*/lib` на: (а) файлы 0 импортеров (мёртвые),
   (б) `export 'package:…'`-only shims, (в) дубли символов между lib и модулями.
   Инструмент: `dart_code_metrics`/ручной grep + `unused` от analyzer (после включения строгих правил).
3. Проверить дубли util: `lib/util/datetime.dart` vs `base` datetime_format; `lib/util/ui.dart`,
   `url_matcher.dart`, `validator`/`bloc_ext` (уже в base — остались ли local-копии в модулях?).
4. Удалить пустые директории после чистки.

**Коммит(ы):** `chore(cleanup): remove dead re-export shims + duplicate files (pt 2+6)`
(возможно 2 коммита: shims отдельно, дубли отдельно.)

---

## Пункт 7 (НОВЫЙ) — assets → ui_kit + ui_kit как standalone-приложение

**Эталон:** `smp_bank_copy/packages/ui_kit` — assets внутри пакета (`lib/src/res/{icons,font,...}`),
объявлены в `pubspec.yaml` `flutter:` пакета (резолв через `packages/ui_kit/`), flutter_gen с
`output: lib/src/res`. Рядом `example/` — отдельное Flutter-приложение на **`storybook_flutter`**
с `page/` на каждый компонент; `example/pubspec.yaml` → `ui_kit: path: ../`. Запуск:
`cd modules/ui_kit/example && flutter run`.

### 7a. Перенос assets в ui_kit
1. Перенести ВСЕ дизайн-ресурсы из корневого `assets/` в `modules/ui_kit/assets/` (или
   `lib/src/res/` — выбрать по smp: они в `lib/src/res/`, но `assets/` в корне пакета тоже валидно;
   берём `modules/ui_kit/assets/` для чистоты): `font/(icomoon)`, `icon/`, `image/`, `common/`,
   `lottie/`, `onboarding/`. **`translations/` → в `modules/base/localization/assets/`** (это l10n,
   не дизайн). `cert/` и `gallery/` (демо-аватары приютов — app-контент): решить — cert остаётся в
   корне (app), gallery можно в ui_kit (демо) ИЛИ оставить в app. Предложение: cert→app, gallery→ui_kit
   (это картинки-заглушки дизайна). Уточнить при исполнении.
2. Объявить assets+fonts в `modules/ui_kit/pubspec.yaml` `flutter:` блоке.
3. flutter_gen: перенести конфиг в ui_kit pubspec (`output: lib/gen` внутри ui_kit),
   `melos genassets`-скрипт (как hamkor) генерит `Assets` в ui_kit с package-scope.
4. Переписать все 26 файлов-обращений: корневой `Assets.*` → `package:ui_kit` `Assets.*`
   (package-aware). Модульные `PersonalAssets`/`MediaAssets`/`personal_assets.dart` строковые пути
   → на ui_kit `Assets.*` (package-scoped, теперь резолвятся т.к. asset в ui_kit-пакете).
5. Убрать перенесённые assets из корневого `pubspec.yaml` + удалить корневой `lib/gen/assets.gen.dart`.
6. `IconRes` (icomoon) в ui_kit уже есть — fontPackage `ui_kit` (уже пофикшено).

### 7b. ui_kit/example — standalone storybook-приложение
1. `modules/ui_kit/example/` — новый Flutter-проект (`flutter create` каркас или ручной минимум:
   `lib/main.dart`, `pubspec.yaml`, `web/`, `analysis_options.yaml`).
2. `example/pubspec.yaml`: `ui_kit: path: ../`, `storybook_flutter: ^0.14`, flutter.
3. `example/lib/main.dart`: `Storybook` с `Story`-ами на каждый компонент ui_kit (button, colors,
   text_field, chip, app_bar, bottom_sheet, breakpoints/adaptive_scaffold, icons, theme light/dark
   toggle). Минимум — 1 story на каждый экспортируемый компонент.
4. Запуск-конфиг: `cd modules/ui_kit/example && fvm flutter run -d chrome`. Добавить в README ui_kit.
5. example — НЕ член основного workspace (свой pub-resolve), чтобы не тянуть в основную сборку.
   Проверить, что основной `fvm flutter build web` его не подхватывает (workspace `- modules/ui_kit`
   не включает `example/`; example резолвится отдельно).

**Риск:** высокий (asset-резолюшн package-scope — частый источник рантайм-багов «asset not found»,
не ловится analyze). Нужен ручной build web + визуальная проверка иконок/шрифтов после.
**Коммит(ы):** `feat(ui_kit): move assets into ui_kit (package-scoped)` +
`feat(ui_kit): standalone storybook example app`

---

## Порядок выполнения (фазами, каждая зелёная перед следующей)

1. **Пункт 5+3 вместе** (переезд l10n→localization + группировка base/) — один связный переезд путей,
   чтобы не гонять pub get дважды. Проверка → коммит(ы).
2. **Пункт 7 (assets→ui_kit + example)** — самый рискованный, отдельно. 7a перенос assets → проверка
   (build web + визуальная проверка иконок/шрифтов) → коммит. 7b storybook example → коммит.
3. **Пункт 2+6** (чистка мёртвых/дублей) — после переездов, чтобы shims уже указывали на финальные пути
   (в т.ч. `lib/res/icon.dart` дубль уйдёт вместе с asset-миграцией).
4. **Пункт 1+4** — верификация (melos-комментарий, mason.yaml) — тривиально, в конце.

## Гейты (каждая фаза)
- `fvm flutter analyze --fatal-infos --fatal-warnings` → 0.
- Все тесты (base/core/navigation/localization/ui_kit + 6 фич + root) зелёные.
- `fvm flutter build web` (prod) + `fvm flutter build web -t test/dev/main.dart` (dev) ✓.
- **После пункта 7: визуальная проверка** — иконки icomoon + svg + шрифты рендерятся (package-scope
  asset-резолюшн не ловится analyze/build, только рантайм).
- `cd modules/ui_kit/example && fvm flutter run -d chrome` — storybook запускается.
- `mason make feature` (smoke, bricks под новую структуру).
- Обновить ARCHITECTURE.md/README дерево под `modules/base/*` + ui_kit-standalone.

## Не делаем (по решению владельца)
- melos не даунгрейдим (скрипты в pubspec, отдельный файл невозможен на 8.x).
- ui_kit НЕ группируем в base/ (отдельно в modules/ui_kit, как hamkor+smp).

## Обновлено по замечанию владельца
- assets ПЕРЕНОСЯТСЯ в ui_kit (package-scoped) + ui_kit получает standalone `example/` storybook-app
  (как smp_bank) — чтобы работать над дизайн-системой изолированно.
