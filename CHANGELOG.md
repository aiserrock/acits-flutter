# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog],
and this project adheres to [Semantic Versioning].

## [Unreleased]

### Changed

- Один фасад логирования `Log` в `util` вместо шести одинаковых копий в `personal`,
  `auth`, `applicants`, `prescriptions`, `media` и `app_services`; уровни и сообщения не
  менялись. Из этих пакетов убраны лишние зависимости `talker_flutter` и `get_it`.

- Ссылка сброса пароля из письма открывается в приложении: экран «Новый пароль» берёт
  `uidb64` и `token` из ссылки (только https на `acits.ru` и поддоменах), проверяет длину
  и совпадение паролей и вызывает `POST /api/v1/users/reset-password/complete/`; при
  успехе — переход ко входу. Путь `/api/v1/users/reset-password/confirm` добавлен в
  фильтр App Links Android и в шаблон `apple-app-site-association`.

- Клавиатурные сокращения на экранах «Сегодня» и «Животные» (планшет с клавиатурой,
  браузер): `/` или Ctrl/⌘+F — поиск, Esc — закрыть поиск, Ctrl/⌘+N — добавить,
  F5 или Ctrl/⌘+R — обновить. В поле ввода `/` и F5 остаются обычными клавишами.

- Адаптивные модальные окна: на планшете и в окне браузера нижние панели не шире 840 px,
  диалоги не шире 560 px (ограничение в теме `ui_kit`, действует на все
  `showModalBottomSheet` и `showDialog` приложения); на телефоне ширина прежняя.

- iOS без CocoaPods: удалены `Podfile`, `Podfile.lock`, включения `Pods-Runner.*.xcconfig`,
  фазы `[CP]`, фреймворки и группа Pods в `project.pbxproj`. Все плагины, включая Patrol,
  подключаются Swift-пакетом `FlutterGeneratedPluginSwiftPackage`; таргет `RunnerUITests`
  теперь тоже получает его как зависимость. Закоммичены `Package.resolved` — версии
  Swift-пакетов (Firebase, Sentry и др.) зафиксированы.

- Восстановление пароля: «Забыли пароль?» на экране входа (раньше кнопка ничего не
  делала) открывает окно с полем почты и отправляет запрос
  `POST /api/v1/users/reset-password/`. Ответ одинаковый для зарегистрированной и
  незарегистрированной почты, чтобы по нему нельзя было проверить, есть ли у адреса
  аккаунт; ошибки сети показываются. «Обратная связь» в меню больше не пустой пункт.

- Меню профиля: ссылки на политику конфиденциальности, условия использования и
  страницу лицензий открытого ПО; пункт «Обратная связь» открывает письмо в поддержку.
  Пункт «Удалить аккаунт» (требование Google Play и App Store) после подтверждения
  отправляет запрос в поддержку и выходит из аккаунта; без почтового приложения
  открывается публичная страница удаления. Адреса — в `LegalLinks`, порядок для
  владельца — в `doc/release.md`.

- Android: адаптивная иконка запуска (фон #6776E0, логотип в безопасной зоне) с
  монохромным слоем для тематических иконок Android 13+, и системный splash Android 12+
  на том же фоне с логотипом вместо растянутой картинки. Dev-сборка — на тёмном фоне
  #2E3A8C, чтобы на рабочем столе её было не спутать с prod. Старые PNG-иконки
  остаются для Android 7.

- Deep links: зафиксирован текущий контракт ссылок и чек-лист владельца перед первой
  публикацией (`doc/deeplink/README.md`: хосты, `assetlinks.json` с ключом Play App
  Signing, `apple-app-site-association`, associated domains). Веб-образ отдаёт
  `/.well-known/*` как JSON и 404 вместо подмены на `index.html`. Черновик
  `assetLinks.json` переименован в `assetlinks.json` — так его ищет Android.

- Принудительное и рекомендуемое обновление, kill-switch: splash до любой навигации
  спрашивает Firebase Remote Config (`min_supported_build`, `recommended_build`,
  `kill_switch`, `update_message`) и показывает экран «Нужно обновить приложение»,
  «Доступно обновление» (с кнопкой «Позже») или «Сервис временно недоступен» (с
  повтором). Значения по умолчанию, сбой сети, web и dev-сборка никого не блокируют.
  Параметры и порядок вывода сборки из оборота — в `doc/release.md`.

- Формат хранилищ на устройстве зафиксирован до первой публикации: все ключи secure
  storage и SharedPreferences собраны в `StorageKeys` (строки не менялись), тест
  закрепляет каждую строку, поэтому переименование ключа роняет CI. Добавлен
  версионируемый хук миграций (`storage_schema_version`, текущая схема 1): выполняется
  при первом открытии SharedPreferences, при сбое шага откатывает значения и не роняет
  запуск. Таблица ключей и порядок добавления миграции — в `doc/storage.md`.

- Вкладка «Календарь» открыта: месячная сетка исполнений назначений приюта (неделя с
  понедельника, на днях — число исполнений), список выбранного дня рядом с сеткой на
  широком окне и под ней на телефоне, переход по месяцам и к сегодняшнему дню, только
  для чтения. Исполнения за месяц грузятся всеми страницами одним запросом с
  диапазоном дат: сгенерированный клиент терял параметры `from`/`to`, запрос идёт
  напрямую через Dio. Заглушка календаря в модуле `personal` удалена.

- Голден-тесты `ui_kit` помечены тегом `golden`: `melos run test` и локальный запуск их
  исключают (на macOS сглаживание шрифтов расходится с эталонами, снятыми на Linux),
  CI по-прежнему сравнивает их в джобе `Test`. Новый workflow `Update goldens`
  перезаписывает эталоны на Linux-раннере и открывает PR с картинками.

- iOS: манифест приватности `PrivacyInfo.xcprivacy` (без трекинга; API с
  обязательной причиной — UserDefaults, метки времени файлов, время загрузки системы;
  собираемые данные — сбои, производительность, просмотры экранов, идентификатор,
  e-mail) и `ITSAppUsesNonExemptEncryption = false` в `Info.plist`. В
  `doc/release.md` — что ответить в анкете приватности App Store Connect.
- Отчёты об ошибках (Crashlytics, Sentry) и Analytics привязаны к сессии: при выборе
  приюта им передаётся его id, при выходе привязка снимается.

- Вкладки получили собственные адреса и стеки навигации (`StatefulShellRoute`):
  `/today`, `/animals`, `/animals/:id`, `/calendar`, `/drugs`. Состояние вкладки
  (прокрутка, поиск, открытая карточка) сохраняется при переключении; повторное
  нажатие на вкладку возвращает её к началу. Старые адреса `/root` и `/animal/:id`
  перенаправляются на новые.
- На широком окне (от 840 px) список животных и карточка стоят рядом
  (`ListDetailLayout` в `ui_kit`): выбор другого животного меняет карточку справа,
  список слева не перестраивается. На телефоне карточка открывается поверх списка.
- Вкладка «Медикаменты» открыта: каталог препаратов приюта с поиском, остатком на
  складе (нулевой остаток подсвечен) и догрузкой страниц, только для чтения.

- Доступность ввода: иконки «назад», «меню», «поиск» и «очистить» в шапках экранов
  стали кнопками (`IconButton`) с локализованными подсказками. Они получают фокус с
  клавиатуры, подсвечиваются при наведении мышью, озвучиваются экранным диктором и
  имеют область нажатия 48 px.

- Адаптивные экраны: списки «Сегодня» и «Животные» раскладывают карточки в две и три
  колонки по ширине области контента (`AdaptiveColumns` / `AdaptiveCardRow` в `ui_kit`,
  колонка от 360 px). Формы редактирования животного, заявителя, куратора, назначения,
  комментария и выбор вида держат колонку до 560 px; карточка животного, профиль и
  поиск — до 840 px. Свайп между вкладками в форме назначения считается от ширины
  формы, а не окна.

- Адаптивный каркас приложения: `RootScreen` построен на `AdaptiveScaffold` — нижняя
  панель на телефонах, навигационный рейл от 600 px и развёрнутый рейл с подписями от
  1200 px; боковое меню доступно на любой ширине. Web-рамка `PhoneFrame`, которая
  сжимала приложение до колонки 430 px, удалена: в браузере интерфейс занимает всё окно.
  Экраны входа, регистрации, подтверждения e-mail и выбора приюта держат колонку
  шириной до 560 px по центру (`ContentWidth` в `ui_kit`). Портретная ориентация
  закреплена только на телефонах (`OrientationPolicy`); планшеты, складные устройства
  и окна поворачиваются свободно.

- Android: из манифеста убраны разрешения, которые приложению не нужны —
  `READ_MEDIA_*` и `READ_EXTERNAL_STORAGE` (их объявляет `open_filex`, файлы и фото
  выбираются системными пикерами) и рекламные `AD_ID` / `ACCESS_ADSERVICES_*`
  (приходят с SDK аналитики). Снят флаг `requestLegacyExternalStorage`. Данные
  `flutter_secure_storage` исключены из облачного бэкапа и переноса между
  устройствами: ключ шифрования в бэкап не попадает, и восстановленные данные
  нельзя было бы расшифровать.

- Единая модель ошибок: сервисы сессии и конфигурации (`AuthService`,
  `ConfigService`, подтверждение e-mail) возвращают `Result<Failure, T>` вместо
  исключений, `DataState.error` принимает только `Failure`, а `DioException`
  больше не выходит за data-слой. Удалены `MessagedException`,
  `NotAuthorizedException`, `EmailConfirmException`; у `ui_kit` и `auth` убрана
  зависимость от `dio`.

- Разорван цикл пакетов `di ↔ app_services ↔ shell`: пакет `di` теперь владеет
  только экземпляром `getIt` и ни от чего внутреннего не зависит, а prod-композиция
  (`@InjectableInit`) переехала в приложение — `lib/di/`. Граф пакетов проверяется
  скриптом `tool/check_package_graph.dart` (`melos run graph:check`, шаг в CI).
  `ARCHITECTURE.md` описывает реальные слои.

- Тулчейн обновлён до Flutter 3.50.0 / Dart 3.14.0 (`.fvmrc`, `pubspec.yaml` корня
  и модулей, CI, Dockerfile, шаблон mason-кирпича, документация).
- Android: Gradle 9.5.0 / AGP 9.3.1 / Kotlin 2.4.20 — верхняя граница, которую
  принимает Flutter 3.50. В `app/build.gradle` включён `buildFeatures.resValues`
  (AGP 9 выключает его по умолчанию, флейворы используют `resValue`).
  Built-in Kotlin и новый DSL остаются включёнными.
- Обновлены плагины, без которых Android не собирается на AGP 9 со встроенным
  Kotlin: `file_picker` 13, `share_plus` 13, `package_info_plus` 10, `pdfx` 2.11,
  `patrol` 4.12. `file_picker` 13 убрал `withData` и `FilePickerResult` — файл
  комментария читается через `PlatformFile.readAsBytes()`.
- `melos` 8.10.1: версия 8.2.2 не запускалась на Dart 3.14.
- Зависимости подняты до текущих мажоров: Firebase (`firebase_core` 5,
  `firebase_crashlytics` 6, `firebase_analytics` 13 — Firebase iOS SDK 13, Android
  BoM 35), `flutter_secure_storage` 11, `go_router` 18, `equatable` 3,
  `flutter_slidable` 5, `shimmer` 4, `smooth_page_indicator` 3, `open_filex` 5,
  `flutter_keyboard_visibility` 7, `cupertino_icons` 2, `flutter_alice` 3.
- Android: `minSdkVersion 24` зафиксирован явно (раньше брался из Flutter).
- `flutter_secure_storage` 11 меняет шифр ключа на Android и переносит данные при
  первом обращении; перенос включён с резервной копией (`migrateWithBackup`).
- iOS: все плагины собираются через Swift Package Manager, в CocoaPods остался
  только сам Flutter.
- Переход на многопакетную структуру: код приложения разложен по `modules/` —
  базовый слой (`base/{util,network,core,di,navigation,localization}`),
  `ui_kit`, `app_services`, `shell` и шесть фича-модулей.
- Сетевой слой переведён на единственный dio-клиент за портами и адаптерами;
  chopper и его генерированный клиент удалены. Фичи возвращают
  `Result<Failure, T>` из репозиториев, DTO не выходят за data-слой.
- Гейт качества проверяет формат и тесты не только корня, но и всех модулей;
  ширина строки 120 закреплена в `analysis_options.yaml`.
- Заявители/кураторы, назначения и личный кабинет переведены с сервисов,
  бросающих исключения, на репозитории с `Result<Failure, T>` — как остальные
  фичи. Маппинг транспортных ошибок в типизированный `Failure` вынесен в общий
  `guard()` (`package:core/data.dart`).
- Анализатор исключает каталог `build/`: на macOS `flutter pub get` кладёт туда
  Swift-пакеты плагинов вместе с их Dart-тестами, и локальный строгий анализ
  падал на чужом коде.

### Added

- Каждый запрос мобильного приложения к API несёт заголовки клиента `x-app-version`, `x-app-build` и
  `x-app-platform` — в том числе гостевые (логин, регистрация). Без них бэкенд
  не сможет отличать устаревшие версии приложения после публикации в сторах.
  С web заголовки не отправляются, пока бэкенд не разрешит их в CORS.

- Наблюдаемость: новый пакет `base/observability` — единый `ErrorReporter` поверх
  Crashlytics и Sentry (каждая ошибка уходит в каждый бэкенд один раз), вычистка
  персональных данных и токенов, трекинг экранов по шаблону маршрута.
- Sentry: подключается при сборке с `--dart-define=SENTRY_DSN=...`; без DSN SDK
  не инициализируется и ничего не отправляет.
- Переключатель «Отправлять статистику и отчёты об ошибках» в профиле: управляет
  сбором в Analytics, Crashlytics и Sentry, выбор сохраняется.

- Релизный пайплайн на три стора (`.github/workflows/release.yml`): push ветки
  `release/*` собирает подписанные обфусцированные сборки и грузит их во внутренние
  каналы (Google Play internal, TestFlight, модерация RuStore, Firebase App
  Distribution), тег `v*` продвигает ту же сборку в production за окружением с
  ручным подтверждением. Единый номер сборки для трёх сторов, fastlane для Android и
  iOS, загрузка символов в Crashlytics. Процесс и секреты — в `doc/release.md`.

- Каталог дизайн-системы на widgetbook: общие экспонаты в `ui_kit/lib/gallery/`,
  standalone-приложение «ACITS UI Kit» и debug-экран `/debug/gallery` в
  dev-флейворе.
- Смоук-тесты Patrol по реальному dev-API (логин, авто-вход, вкладки «Сегодня»
  и «Животные») с обвязкой под Android и iOS.
- В `ui_kit` появились брейкпоинты (600/840/1200) и `AdaptiveScaffold` с
  golden-тестами; к навигации приложения он пока не подключён.
- Шаблоны mason `feature` и `screen` для нового модуля и нового экрана.
- Документация: `ARCHITECTURE.md`, `docs/GOTCHAS.md` и README в каждом пакете.
- CI: проверка заголовка PR по Conventional Commits (`semantic-pr.yml`) и
  конфигурация Dependabot.

### Fixed

- В release-сборках логи не доходили до Crashlytics: логгер создавался выключенным,
  и его наблюдатель не вызывался. Теперь логгер включён всегда, а в prod-release
  отключён только вывод в консоль устройства.
- Сбой инициализации Firebase больше не останавливает запуск приложения.

- Сбой сети, таймаут или 5xx при обновлении токена больше не разлогинивает
  пользователя: сессия сбрасывается, только когда сервер отверг refresh-токен
  (400/401/403). Запрос при этом завершается сетевой ошибкой, а не 401.

- Пустые экраны из-за `null` в полях, которые OpenAPI-спека объявляет
  обязательными: спека расслабляется при препроцессинге, ответные DTO стали
  nullable.
- Экран ошибки показывал общее «Что-то пошло не так» для любой причины. Теперь
  различает отсутствие сети, таймаут, недоступность сервера, истёкшую сессию и
  отказ в доступе (403, отдельный `ForbiddenFailure`); при отказе 4xx показывает
  пояснение сервера.
- Тема, выбранная до того, как приложение дочитало сохранённую, затиралась
  прочитанным значением.

## [0.10.0+24] - 2026-07-15

### Added

- Редактор фото животного (zoom, поворот, обрезка) на `pro_image_editor` — web и mobile.
- Рабочий поиск с чипсами сортировки («Сегодня», «Животные»).
- Splash-автовход: бесшовный splash (нативный/DOM), персист приюта и локали, случайная loading-анимация.
- Компактный переключатель языка под кнопкой регистрации.

### Fixed

- Web: PDF «поделиться»/«скачать» отдавал пустой файл (pdfx делал буфер detached через transferable) — теперь отдаётся полный файл.
- Web: фото в свёрнутом кружке шапки карточки грузится через CORS-прокси (была заглушка вместо фото).
- Тёмная тема: цвета сегмент-переключателя, drawer, шиммер загрузки картинок, логотип на регистрации.
- Auth: не терять refresh-токен при автовходе.

### Added

- Тёмная тема: переключаемая светлая/тёмная схема через `ColorScheme`; переключатель в настройках.
- Просмотрщик PDF: pinch-zoom и кнопки +/− (ограничение 100–200%), кнопка поворота страницы (0° ↔ 90°), кнопка скачивания (работает на всех платформах).

### Changed

- Цвета и стили переведены со статических `ColorRes`/`StyleRes` на семантические `Theme.of(context).colorScheme`.
- Web-шаринг PDF: при отправке файла в share-sheet передаётся только файл (без текста) — фикс «unsupported attachment» в мессенджерах; добавлены диагностические логи в Talker.

### Fixed

- Инкрементальная profile-сборка Android при флейворах (явные `debug`/`profile` buildType).

### Added

- PDF-карточка животного в web-PWA: просмотр и «поделиться»/скачивание работают на всех платформах (byte-пайплайн `PdfDocument.openData`, share через Web Share API с фолбэком на скачивание).
- Ограничение ширины интерфейса на web-десктопе рамкой смартфона с размытым матовым фоном по бокам (на мобильных без изменений).

### Changed

- Android-сборки только под ARM (`arm64-v8a`, `armeabi-v7a`), убран `x86_64`.
- Инициализация приложения распараллелена; списки комментариев и фото рендерятся лениво.

### Fixed

- Гонки запросов в списках животных, деталях и поиске; single-flight обновления токена авторизации.
- Утечки подписок и жестовых распознавателей (dispose в редактировании назначений и списке комментариев).
- Зеркалирование в GitLab больше не падает при push нового тега (`would clobber existing tag`).

## [0.8.0+21] - 2026-07-12

### Added

- PWA-сборка dev-флейвора на GitHub Pages с CORS-прокси для API.
- Отображение версии и режима сборки на экране входа и в profile-шторке.
- Технический roadmap проекта (`docs/tech-roadmap.md`) и design spec.

### Fixed

- Safe-area для нижней навигации в iOS PWA (home-indicator, standalone).

## [0.7.0+20] - 2026-07-11

### Added

- Backend environments switcher in the dev debug screen: prod / stage / dev-0..3 plus a custom URL field (Mockoon or any ad-hoc stand); the dev flavor now defaults to stage. Applying an environment shows an "Applying…" splash (Lottie paw) and rebuilds the whole widget tree, so all clients and blocs pick up the new base URL without a manual restart
- Charles/mitmproxy support in the dev flavor: a proxy toggle with host:port field in the debug screen, applied globally via `HttpOverrides` and per-client for chopper (requires a full manual app restart, the UI says so)
- In-app logging with Talker: a log screen in the dev debug menu showing HTTP traffic, BLoC transitions and manual log entries. Leveled logs (debug/info/warning/error) across all services, repositories and cubits; error/critical entries are forwarded to Crashlytics as non-fatals in prod
- Alice HTTP inspector in the dev debug menu: full request/response browsing (with cURL export) for both chopper and dio traffic via a custom chopper interceptor
- Mockoon mock server (`mockoon/`) with two organisations, per-route error variants (401/403/404/400/429/500) and response shapes captured from production

### Changed

- Android toolchain bumped to Gradle 8.14.3 / AGP 8.11.1 / Kotlin 2.2.20 and the app itself migrated to built-in Kotlin, clearing the Flutter 3.44 build warnings; deprecated `buildDir` usages replaced with `layout.buildDirectory`

## [0.6.1+19] - 2026-07-09

### Added

- Dev-only floating debug button (draggable-overlay pattern): a draggable bug-icon that opens the debug screen (tap) or hides itself (long-press), shown only in debug mode. The debug screen gains a Firebase test card — trigger a fatal crash, a non-fatal error (Android/iOS) or an analytics event (all platforms) to verify Crashlytics/Analytics against the `acits-dev` project.

### Fixed

- CI provisions Firebase configs for the new per-flavor layout (`ios/flavors/{dev,prod}/`) and installs the flutterfire CLI so the iOS `bundle-service-file` build phase can select the right plist; the stale `ios/Runner/GoogleService-Info.plist.example` copy no longer breaks the pipeline
- Removed the FlutterFire `upload-crashlytics-symbols` Xcode build phase (it looked for the Crashlytics run script in SPM's DerivedData and failed the unsigned CI build with `ProcessException: No such file or directory`); `uploadDebugSymbols` set to false in `firebase.json`
- Emptied `Runner.entitlements` (kept the original as `.example`) so a personal (free) Apple team can sign local device builds — the inherited Push Notifications / Associated Domains capabilities aren't supported without a paid Apple Developer Program
- Re-added a guarded Crashlytics dSYM upload build phase: uploads symbols on release/profile builds (readable iOS crash traces) and skips cleanly on debug/CI (`--no-codesign`) builds where no dSYM exists, instead of failing the build

## [0.6.0+18] - 2026-07-09

### Added

- Firebase for both flavors on Android, iOS and web, each flavor in its own project (`acits-prod` / `acits-dev`): Analytics on all three platforms, Crashlytics on Android/iOS (no web plugin exists; guarded off with `kIsWeb`). Configured via FlutterFire (`firebase_options.dart` per flavor) with native `google-services.json` per flavor and per-flavor iOS `GoogleService-Info.plist` selected by an Xcode `flutterfire bundle-service-file` build phase, plus the Android Crashlytics Gradle plugin (NDK symbol upload) — ready for push notifications.
- Web PWA now uses the path URL strategy (`/login` instead of `/#/login`), with a `404.html` SPA-fallback for GitHub Pages and `try_files` on nginx
- iOS now has `Profile-dev` / `Profile-prod` build configurations, so `flutter build ios --profile --flavor {dev,prod}` works (Android profile builds already worked)
- iOS builds via Swift Package Manager (hybrid): SPM-capable plugins use SPM, the rest stay on CocoaPods

### Changed

- CI no longer runs on a plain push to `main`/`develop`; it now runs only on pull requests and on a `v*` release tag
- CI now builds a signed release: the dev flavor on a PR, the prod flavor on a `v*` tag (both signed with the release keystore); artifacts are named `acits-dev-release` / `acits-prod-release`
- README now links directly to the deployed PWA
- Telegram build notification now fires on every CI run, including pull requests (previously tag-only)
- Telegram notification now includes the live PWA link when the web deploy succeeds
- Web PWA shows a loading spinner over the splash screen until the app's first frame renders
- Bundle identifier changed to `ru.acits` (prod) / `ru.acits.dev` (dev) across Android and iOS; iOS signing team set to `45G32KJDV7`
- `assetLinks.json` fingerprint updated to the release keystore's certificate

### Fixed

- Web PWA now boots ~4s faster: `main.dart.js` loads immediately instead of waiting on service-worker registration (which stalled and hit a 4s fallback timeout on GitHub Pages)
- iOS pod install no longer fails on a stale `Podfile.lock` that pinned Firebase 8.9.0 against `firebase_core 4.x` (which needs Firebase 12.x)
- Web PWA no longer crashes on the "terms" link (registration), comment links and comment attachments: `flutter_web_browser` (no web support) replaced with `url_launcher`, and the attachment download (`path_provider` / `open_filex`, mobile-only) now opens the file URL directly on web

## [0.5.1+17] - 2026-07-08

### Added

- GitHub Release is now published automatically when a `v*` tag is pushed: builds the dev APK, extracts that version's bullet points from `CHANGELOG.md` as release notes, attaches the APK, deploys web to GitHub Pages

### Changed

- Android/iOS builds now run only on pull requests and on a release tag, not on every push to `main`/`develop`
- Web favicon and PWA icons replaced with the app's actual logo (were the default Flutter icon)

### Fixed

- Two favicon `<link>` tags used a root-absolute path (`/favicon-32x32.png`), which 404'd once the site moved under a GitHub Pages subpath (`/acits-flutter/`); switched to relative paths

## [0.5.0+17] - 2026-07-08

### Added

- CI job that builds the `prod` web target and deploys it to [GitHub Pages](https://aiserrock.github.io/acits-flutter/) whenever a `v*` tag is pushed

### Changed

- Consolidated all generated code under `lib/gen/` (was scattered across `lib/api/`, `lib/generated/`)
- Retired the `lib/l10n/` folder name (the project uses `easy_localization`, not the `intl_utils`/`.arb` pattern that name implied); the hand-written `L10n` config class moved to `lib/res/`

### Fixed

- `Dockerfile` pinned an unmaintained base image (`cirrusci/flutter:3.3.1`) predating the project's SDK requirement and used a removed `--web-renderer` flag; replaced with `ghcr.io/cirruslabs/flutter:3.44.0`, dropped the obsolete flag, bumped `nginx` off its EOL 1.20.0
- Added a missing `.dockerignore` — `docker build .` was sending the whole repo (`build/`, `.dart_tool/`, `.git/`, ...) into the build context, multiple gigabytes for nothing the image needs

### Removed

- Dead code found in a project-wide audit: obsolete Charles debug-cert pinning (`test/dev/res/cert_res.dart`, `test/dev/ssl/http_overrides.dart`), unused `lib/domain/curator.dart`, `lib/api/client_index.dart`/`client_mapping.dart`, `script/version.sh`, `doc/tmp/*` scratch files

## [0.4.0+17] - 2026-07-08

### Added

- Dev APK attached directly to the GitHub release (CI-built from `main`, signed with the debug keystore)

### Fixed

- Corrected v0.3.0 release attribution

## [0.3.0+17] - 2022-11-16 (retagged 2026-07-08)

### Added

- Migrated navigation to `go_router`
- Migrated all screens from legacy state handling to `flutter_bloc` Cubit + `DataState` (forms, list/stream-leak screens, complex screens, registration/prescription-edit/drawer)
- Migrated localization from `intl_utils` to `easy_localization`
- Localized remaining hardcoded strings and sealed bloc events
- Real unit/bloc test suite (80 tests)
- Patrol E2E smoke test setup
- CI pipeline rebuilt: Android/iOS build jobs, Telegram build notifications, prepare → lint → analyse → test → build → notify stage split
- Bilingual README/CONTRIBUTING (English default + Russian), later extended with Chinese, Hindi, Spanish, French, and Arabic translations
- Project branding, badges, language switcher with flags, Builds section, Community section
- Project wiki: Architecture, Project Structure, Flavors and Environments, CI/CD Pipeline, Localization, Testing, FAQ
- Deep-linking for account registration confirmation
- Personal data screen and organisation/shelter renaming across the UI
- Animal card PDF download
- Autotest suite scaffolding

### Changed

- Upgraded dependencies to latest major versions
- Upgraded to Flutter 3.44.0 / Dart 3.12.0
- Rewrote English translations in British English

### Fixed

- Closed SSRF, token log leak, and auth-header issues
- Resolved re-audit findings: `safeEmit`, an off-by-one, resource leaks
- Fixed the "actual" execution filter in prescriptions to use the local date
- Suppressed the `REQUEST_INSTALL_PACKAGES` permission
- Fastlane iOS upload fix

### Removed

- Dropped dead agent files and Gherkin scaffolding from the repo

## [0.2.0+17] - 2022-10-08

### Added

- Account registration flow: email confirmation, deeplink handler, domain association files
- Registration screen localization

## [0.1.6+17] - 2022-10-08

### Added

- Debug menu stand switcher
- Animal field validation
- Prescription screen create/edit tab localization
- Session refresh persistence between app restarts
- Associated domain files for universal links
- Dev App Store app target

### Changed

- Migrated to Flutter 3

### Fixed

- Animal card single-slide layout order
- Login/auth screen bug fixes
- Shelter picker showing when only one shelter is available

## [0.1.4+13] - 2022-06-12

### Added

- Prescription create/edit screens
- Debug SSL certificate overrides for local backends

### Fixed

- Prescription card display bug

## [0.1.3+12] - 2022-06-05

### Added

- File actions (open/share/download) for animal attachments

### Fixed

- Hotfix for a production regression

## [0.1.2+11] - 2022-05-17

### Fixed

- Hotfix for a production regression

## [0.1.1+10] - 2022-05-16

### Added

- File actions groundwork
- Release process patch

## [0.1.0+9] - 2022-05-16

### Added

- Animal comments
- Android/iOS launcher assets per flavor
- Personal drawer (side menu)
- Role-based actions for animals
- "Today's executions" screen fixes

## [0.0.8+8] - 2022-05-11

### Added

- CI/CD for iOS
- Photo gallery for animal cards
- APK build patch

### Fixed

- Analyze/lint pipeline fixes

## [0.0.7+7] - 2022-03-28

### Added

- Dev environment flavor
- CI/CD analyze fix

## [0.0.6+6] - 2022-03-20

### Added

- Curator add/edit screen
- Applicant search/add/edit screen
- Design system refactoring pass

## [0.0.5+5] - 2022-02-08

### Added

- Migrated to the `sc-api` network client

## [0.0.4+4] - 2022-02-07

### Added

- Add/edit animal screen (continued)

## [0.0.3+3] - 2022-02-06

### Added

- Add/edit animal screen

## [0.0.2+2] - 2022-02-06

### Added

- Onboarding flow with native splash screens
- App localization
- Auth screens (login)
- Shelter picker
- Main screen frame and content
- Firebase project initialization
- Animals list screen
- Animal card screen
- Login form autofill support
- GitLab CI scaffolding

## [0.0.1+1] - 2021-12-19

### Added

- Initial project scaffold

<!-- Links -->
[keep a changelog]: https://keepachangelog.com/en/1.0.0/
[semantic versioning]: https://semver.org/spec/v2.0.0.html

<!-- Versions -->
[unreleased]: https://github.com/aiserrock/acits-flutter/compare/v0.4.0...HEAD
[0.4.0+17]: https://github.com/aiserrock/acits-flutter/releases/tag/v0.4.0
[0.3.0+17]: https://github.com/aiserrock/acits-flutter/releases/tag/v0.3.0
