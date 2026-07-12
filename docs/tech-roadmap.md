# Технический roadmap acits_flutter

> Дата: 2026-07-12. Источники паттернов: hamkormobile (банк-монорепо), tms-driver-app + tms-libs,
> экосистема kazan_express (ke-business-app, app_sortman, mobile-ci-template, fastlane-market),
> smp_bank_copy. Каждый пункт верифицирован против реального кода этого репозитория —
> формулировки ниже уже учитывают, что в проекте есть, а чего нет.
> Design spec: [docs/design-specs/tech-roadmap.md](design-specs/tech-roadmap.md).

Цель — поддерживаемый, современный, удобный в разработке проект: страховочная сетка тестов
и анализатора, единые команды локально и в CI, типизированные ошибки, живая прод-наблюдаемость,
автоматическая гигиена зависимостей.

**Легенда**: приоритет P0 (фундамент/боль сейчас) → P2 (приятно иметь); effort S (< полдня),
M (1–3 дня), L (неделя+, размазывается «по мере касания»).

## Что уже хорошо (не трогаем)

- Cubit + `DataState` + `safeEmit` — единый state-паттерн на всех 18 кубитах.
- Dev-флейвор физически вне `lib/` (`test/dev/`): Alice, debug-экран, dev-DI (`$initDevGetIt`, injectable-окружения) — прод-сборка этого не видит.
- Зрелый CI (lint/analyse/test/build Android/iOS/web + деплой на Pages по тегу), CONTRIBUTING на 6 языках, Mockoon с генератором.
- `analysis_options.yaml` уже исключает `lib/gen/**`; `FlutterError.onError`/`PlatformDispatcher.onError` → Crashlytics уже стоят.

---

## Волна 1 — Фундамент (все пункты S, независимы друг от друга)

### 1.1 Makefile как единая точка входа — P0/S `tooling`

Источники: все 4 донора.

**Проблема (подтверждена)**: task runner'а нет, команды живут текстом в CONTRIBUTING.md и уже
дрейфуют с CI: `CONTRIBUTING.md:260` велит `fvm dart format -l 100 lib test`, а CI
(`ci.yml:95-105`) проверяет формат через `find` с исключением 7 масок генерённых файлов —
локальная команда из доки переформатирует генерат и разойдётся с CI.

**Что делать**:
- Makefile с параметризацией `FLUTTER ?= fvm flutter`, `DART ?= fvm dart` — CI зовёт те же таргеты с `FLUTTER=flutter` (CI намеренно без fvm: fvm ломает кэш `subosito/flutter-action`).
- Таргеты: `bootstrap` (fvm install + pub get + `cp` всех `*.example`-конфигов), `gen` (build_runner), `gen-l10n` (easy_localization:generate с 4 флагами), `format`, `format-check`, `lint`, `test`, `mockoon`.
- Ключевое: `format-check` переносит find-исключения из `ci.yml:95-105` в один источник истины, CI вызывает таргет.
- Отдельный `gen-api` не нужен — swagger-генерация идёт через build_runner (`build.yaml`), `gen` покрывает всё. `setup.sh` не нужен — его роль выполняет `make bootstrap`.

### 1.2 Строгий анализатор: strict-modes поверх flutter_lints — P0/S `code-quality`

Источники: hamkormobile, smp_bank_copy. **Замерено на живом коде.**

- **Не** менять flutter_lints на very_good_analysis: замер дал 2328 issues, из них ~85% — стилистический шум (public_member_api_docs, 80-chars, prefer_int_literals), бесполезный для приложения.
- Добавить `analyzer.language: strict-casts / strict-inference / strict-raw-types` — замер: всего 31 issue, все содержательные. Среди них реальные утечки dynamic: `invalid_assignment` в `lib/service/config/config_service.dart:45,98,113`, `dynamic` вместо `StackTrace` в `lib/ui/screen/auth/bloc/login_bloc.dart:119`, пять `return dynamic` из `FutureOr<List<T>>` в `paging_fetch_adapter.dart`.
- Точечно включить `unawaited_futures` и `discarded_futures`, эскалировать `unawaited_futures` до error через `analyzer.errors`.
- Один PR, ~15 файлов правок.

### 1.3 Coverage в test-джобе CI — P0/S `ci`

`flutter test --coverage` + upload lcov как artifact (test-джоба `ci.yml:158-159` сейчас гоняет
голый `flutter test`). Codecov/бейдж — опционально; для соло-проекта достаточно артефакта
и порога. Отделено от Patrol-на-эмуляторе (см. 3.2) — тот требует предпосылок.

### 1.4 Dependabot для pub и github-actions — P1/S `ci`

**Проблема**: ~69 строк прямых зависимостей устаревают молча; actions уже разъехались по версиям
(`actions/checkout@v4` и `@v7` в одном репо).

- `.github/dependabot.yml`: pub weekly с двумя группами (firebase-*; отдельная группа minor+patch для всего остального — 1-2 PR в неделю вместо 10) + github-actions monthly.
- **Обязательный шаг 2**: dependabot-PR не видят repo secrets → либо продублировать `GOOGLE_SERVICES_JSON_*` / `ANDROID_KEYSTORE_*` в Dependabot secrets, либо `if: github.actor != 'dependabot[bot]'` в build-джобах (dependabot-PR гоняют только lint/analyse/test). Без этого каждый dependabot-PR красный.

### 1.5 Supply-chain hardening CI — P1/S `security`

Категория сейчас не закрыта совсем:
- Pin всех actions по SHA (сейчас только мажорные теги `@v7`, `@v2`) — dependabot после 1.4 умеет обновлять SHA-пины.
- Top-level `permissions: contents: read` в ci.yml и mirror-to-gitlab.yml (заданы лишь в 2 из 8 джоб), точечно расширять в джобах.
- `timeout-minutes` на все джобы (сейчас ни одного).
- osv-scanner по `pubspec.lock` + gitleaks — отдельной scheduled-джобой.

### 1.6 Версионируемые git-хуки: `.githooks/` + `core.hooksPath` — P1/S `dx`

Источник: tms-driver-app, **с коррекцией — 1:1 копировать нельзя**:
- Формат в хуке обязан повторять CI-команду (те же find-исключения) — после 1.1 хук просто зовёт `make format-check`. Иначе хук и CI будут спорить.
- Без `--fatal-infos` (CI использует обычный `flutter analyze`; хук строже CI бессмысленен).
- `flutter analyze` в pre-commit медленный → пропускаемый через env-флаг `SKIP_ANALYZE=1`, либо хук ограничивается форматом.
- Активация: `git config core.hooksPath .githooks` — документировать в CONTRIBUTING, добавить в `make bootstrap`.

### 1.7 CI-проверка паритета ключей локализаций en/ru — P1/S `ci`

**Дрейф уже есть**: 6 ключей (`commonNDays.few/many`, `commonNMonth.*`, `commonNYears.few`)
существуют только в ru.json — на en эти plural-формы молча ломаются. Скрипт ~20 строк
в существующей lint-джобе: сравнение множеств ключей `assets/translations/{en,ru}.json`
+ опционально grep мёртвых ключей.

### 1.8 AGENTS.md + doc/release.md — P1/S `dx`

**Не** заводить параллельную doc/wiki — CONTRIBUTING.md уже покрывает setup/flavors/codegen/l10n
и переведён на 6 языков (каждый дубль умножает поверхность протухания). Реальных пробела два:
- `AGENTS.md` в корне (CLAUDE.md — symlink): тонкий указатель на CONTRIBUTING.md и mockoon/README.md + то, чего там нет — реальные команды валидации (после 1.1 — make-таргеты), правила «не редактировать `lib/gen/**`», «Cubit+DataState, кубиты не регистрировать в DI», «develop защищён — только PR», sources of truth (`.fvmrc`, `analysis_options.yaml`, `build.yaml`, patrol-блок pubspec).
- `doc/release.md`: перенести в репо проверенный релизный флоу (bump версии через PR в develop → ff-only merge в main → тег `v*` → ручной `gh release create` с APK из CI-артефакта), который сейчас живёт только во внешних заметках мейнтейнера.

---

## Волна 2 — Страховочная сетка и ошибки

### 2.1 Widget-тесты: test keys + 2-3 критичных экрана — P0→P1/M `testing`

Источники: smp_bank_copy, tms-driver-app, hamkormobile.

**Подтверждено**: 116 dart-файлов в `lib/ui` (~11k строк), ни одного `testWidgets`;
Key-константы отсутствуют (единственный ValueKey — по runtimeType).

- `lib/res/test_keys.dart` (каталог `lib/ui/res` не существует — ресурсы в `lib/res/`): abstract-классы Key-констант по экранам, **общие для widget-тестов и Patrol-сценариев**.
- Widget-тесты 2-3 критичных экранов: login_form, animal_card/список, animal_detail. Моки — принятый в test/unit паттерн `mocktail + getIt.registerFactory + getIt.reset` в setUp; рефакторинг DI не требуется.
- Page Object (классы-экраны с Finder-ами) вводить лениво — когда на экран появляется второй тест. `pumpUntilSettled` не писать — у Patrol уже есть `$.pumpWidgetAndSettle`.
- Конвенция (P0-часть): новые экраны рождаются сразу с ключами и тестом — зафиксировать в CONTRIBUTING.

### 2.2 getIt из field-инициализаторов виджетов — P1/S `architecture`

Сужено после верификации: injectable-env и второй `@InjectableInit`-конфиг **уже существуют**
(`test/dev/di/di_container.dart`), unit-тесты уже поднимают кубиты с моками — getIt тестовый трек
не блокирует. Остаток работы:
- Приоритетно поправить только getIt в field-инициализаторах State/виджетов (~8 файлов: animal_card, personal_drawer, comment_list, animal_detail_screen, main_screen, animal_edit_add_info_page, paging_fetch_adapter) — именно они мешают widget-тестам.
- Конвенция для нового кода: «зависимости — опциональные параметры конструктора с default = `getIt<T>()`»; миграция остальных 42 вхождений — по мере касания.
- Обновить CONTRIBUTING.md:174 (сейчас предписывает антипаттерн «pull their dependencies from getIt»).

### 2.3 Sealed-иерархия ошибок + unwrap() над Chopper Response — P1/M `architecture`

Источники: tms-driver-app, kazan-ecosystem.

**Подтверждено**: паттерн `if (result.body != null) ... else throw MessagedException(...)`
повторяется 17+ раз в `lib/service/*`; `_ErrorX` в `error_holder.dart` маппит ЛЮБОЙ DioException
в «нет интернета» — 404, 500 и таймаут неразличимы.

- **Этап 1** (основная ценность, малый риск): sealed `AppException` (`NetworkException`, `TimeoutException`, `ServerException(statusCode)`, `ValidationException`, `UnauthorizedException`) + extension `unwrap()` над Chopper Response с unit-тестами; прогон по сервисам. Существующие `NotAuthorizedException`/`EmailConfirmException` влить как подтипы. `unwrap` маппит и DioException (dio реально используется: `dio_register.dart`, `email_confirm_repository.dart`). Обновить `_ErrorX` на switch по AppException.
- **Этап 2** (отдельно, после того как все источники гарантированно кидают AppException): типизировать `DataState.error` и `errorBuilder` на AppException — трогает все экраны + спецкейс `email_confirmation_screen.dart:66`.

### 2.4 Унификация HTTP-стека: dio → общий контур — P1/M `architecture`

Из критика полноты: в `lib/` два независимых сетевых клиента — chopper (основной API) и dio
(загрузка файлов, email-confirm). Auth-токены, прокси, логирование и обработка ошибок
настраиваются дважды и уже расходятся (talker_dio_logger не подключён — комментарий в pubspec).
Свести dio-контур к общим интерцепторам (auth, логи) и к 2.3-`unwrap`, иначе dio-запросы
останутся мимо sealed-ошибок и breadcrumbs.

### 2.5 Talker в prod release → живые breadcrumbs Crashlytics — P1/S `observability`

**Верифицировано**: `CrashlyticsTalkerObserver` уже написан и подключён, но в
`app_logger.dart:25` прод-Talker создаётся с `enabled: kDebugMode`, а talker 5.x при
`enabled: false` вообще не вызывает observer — в release ни одна breadcrumb и ни один
non-fatal в Crashlytics не попадает.

- Включить Talker в release (`enabled: true`), но заглушить консольный вывод (no-op output) — сохраняется текущая гарантия «тела запросов не попадают в системный лог устройства», ради которой и стоял kDebugMode.
- Обернуть тело `CrashlyticsTalkerObserver.onLog` в try/catch (телеметрия не роняет приложение).
- `runZonedGuarded` **не** добавлять — `PlatformDispatcher.onError` уже покрывает async (Flutter 3.3+).
- Перед включением проверить, что `Log.info/warning` в сервисах не логируют тела/токены (auth_interceptor логирует только URL — ок), и оценить шум talker_bloc_logger в breadcrumbs.

### 2.6 Golden-тесты общих виджетов через alchemist — P1/M `testing`

Источник: kazan-ecosystem, **со сменой инструмента**:
- golden_toolkit заархивирован, кастомный tolerance-компаратор не нужен. Alchemist: `PlatformGoldensConfig` (локальные эталоны на macOS, вне git) + `CiGoldensConfig` (Ahem-шрифт, платформонезависимые эталоны в репо) — снимает проблему «Mac-эталоны падают на Linux-CI» штатно.
- `flutter_test_config.dart` — для AlchemistConfig + загрузки icomoon + обёртки easy_localization.
- Старт строго с `lib/ui/widget/`: animal_card, button, error_holder, skeleton — в ключевых состояниях. Экраны — потом.
- Команда обновления эталонов — make-таргет (`flutter test --update-goldens --tags golden`), задокументировать в CONTRIBUTING.

---

## Волна 3 — Хвосты и «по мере касания»

### 3.1 FirebaseAnalyticsObserver в GoRouter — P2/S `observability`

firebase_analytics подключён, но единственный `logEvent` — тестовая кнопка dev-флейвора:
платится цена зависимости без пользы. Минимум ценности за пару строк:
- `FirebaseAnalyticsObserver` в `GoRouter(observers: [...])` (`app_router.dart:77`) — screen_view появляются как breadcrumbs в Crashlytics-отчётах.
- Обязательно `nameProvider`: маршруты `/animal/:id` дадут высококардинальные имена — маппить на статические имена роутов. kIsWeb-guard по образцу существующего кода (Analytics на web есть, Crashlytics нет).
- Слой AnalyticsService и типизированные event-классы **не** заводить — до появления реального потребителя аналитики достаточно 2-3 сырых logEvent (submit заявки, создание животного).

### 3.2 Patrol/integration_test на эмуляторе против Mockoon — P2/L `ci` `testing`

Отложено осознанно: единственный e2e-тест (`app_smoke_test.dart`) не делает сетевых вызовов —
гонять его против Mockoon бессмысленно. Предпосылки, без которых джоба не имеет смысла:
1. dart-define `MOCK_API_URL` (или аналог) в `AcitsEnvUrls`, чтобы CI направил приложение на `10.0.2.2:3000` без правки кода;
2. нативная настройка Patrol для Android (testInstrumentationRunner + PatrolJUnitRunner);
3. хотя бы один сценарный тест с реальными HTTP-вызовами (логин, список животных).

Потом: джоба с `reactivecircus/android-emulator-runner` + `mockoon-cli` с существующим
`mockoon/mockoon.json`. До этого смоук-тест дёшево спасается от гниения переносом его сценария
в обычный widget-тест под уже работающий `flutter test`.

### 3.3 bootstrap() для переиспользования инициализации — P2/S `architecture`

Ядро пункта уже реализовано (prod/dev entry-points разделены, dev-обвязка вне `lib/`,
типизированный Env в getIt). Остаток: извлечь `Future<void> bootstrap({firebaseOptions, initDi, ...})`,
который зовут `lib/main.dart` и `test/dev/main.dart`, а integration-тесты вызывают с dev-DI
и Mockoon-URL. Делать вместе с первым сценарным тестом (3.2), который реально его потребует.
**Не** делать: переименование `main.dart → main_prod.dart` (ломает run-конфигурации ради косметики),
иерархию AppConfig-классов (Env + AcitsEnvUrls уже покрывают).

### 3.4 Material 3 + ThemeExtension-токены — P2/M→L `architecture`

**Подтверждено**: `useMaterial3: false` в `main.dart:88` — deprecated-путь; `Theme.of(context)`
не используется ни разу; ColorRes/StyleRes захардкожены в 58 файлах (~203 обращения).

- Шаг (а), риска нет: `lib/res/theme.dart` — AppTheme + один ThemeExtension с colors + typography из существующих ColorRes (6 цветов) / StyleRes (8 стилей); spacing/radius — когда появится второй потребитель. Новые виджеты — только `Theme.of(context)`; старые — по мере касания. Снять бессмысленный `@singleton` со static-класса ColorRes.
- Шаг (б), **только после golden-тестов ключевых экранов (2.6)**: флип `useMaterial3: true` — M3 меняет дефолтную верстку всех 58 файлов разом.

### 3.5 Конвенция Service vs Repository + структура экрана — P2/S `code-quality`

Сужено: mason brick выброшен (генерировал бы заготовки под несуществующие паттерны; роль
«исполняемой документации» выполняет свежий экран `animal_edit/` + CONTRIBUTING). Остаток —
5-10 строк в CONTRIBUTING: критерий Service vs Repository (Repository = обёртка над
API/хранилищем, Service = бизнес-логика поверх — либо честно слить в один слой) и каноничный
состав подпапок экрана (`cubit/` обязательно, `view/`/`widget/` по мере роста).
Распил registration_screen (744 строки) и animal_detail (490) — по мере касания.

### 3.6 gen_api.sh / make gen-api — P2/S `tooling`

Сокращено после верификации: вынос в path-пакет не нужен (analysis exclude уже работает),
архив спек не нужен (git-история `doc/api/openapi.json` покрывает). Остаток — идемпотентная
команда: копирование свежей спеки → `build_runner build -d` → `dart format lib/gen`.

### 3.7 Доставка в сторы из CI — P2/M `ci`

`ios/fastlane/Fastfile` существует, но из CI не вызывается; `android/fastlane` отсутствует.
Каждый релиз в сторы — ручная работа на машине мейнтейнера (единственная точка отказа).
Подключить fastlane к tag-пайплайну: lane для TestFlight (нужен macOS-раннер + подпись
через match/App Store Connect API key) и Play Internal track. Делать после стабилизации
релизного флоу в doc/release.md (1.8).

---

## Отклонено верификацией (уже сделано)

- **In-app debug-меню** (Talker-логи, HTTP-инспектор, переключение бэкендов) — целиком реализовано в `test/dev/` (TalkerScreen, Alice, customUrl в DebugPreferenceStorage).
- **safeEmit** — extension существует, все 18 кубитов используют, конвенция в CONTRIBUTING. Сырые emit остались только в `onboarding_bloc.dart` — это Bloc, там emit в `on<Event>` каноничен.

## Порядок внедрения

Волна 1 — восемь независимых PR (каждый < полдня), начать с 1.1 (Makefile), т.к. 1.6 (хуки)
и 1.8 (AGENTS.md) на него ссылаются. Волна 2 — с 2.2 (полдня, разблокирует 2.1) и 2.5
(наибольший эффект на прод за минимум работы). Волна 3 — по мере необходимости; 3.4(б) строго
после 2.6.
