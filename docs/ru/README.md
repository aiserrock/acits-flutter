[English](../../README.md) · **Русский**

# acits_flutter

[![Flutter](https://img.shields.io/badge/Flutter-3.44-02569B?logo=flutter&logoColor=white)](https://flutter.dev)
[![Dart](https://img.shields.io/badge/Dart-3.12-0175C2?logo=dart&logoColor=white)](https://dart.dev)
[![License: MIT](https://img.shields.io/badge/License-MIT-green.svg)](../../LICENSE)

Мобильный Flutter-клиент для [acits.ru](https://acits.ru/) — свободного ПО с открытым исходным кодом для учёта животных в приюте.

## О проекте

`acits_flutter` — мобильная часть платформы ACITS. Приложение помогает сотрудникам приюта и кураторам вести актуальный реестр подопечных животных: медицинские назначения, расписания, заявки на пристройство, сопроводительные документы и фотографии. Приложение собирается для окружений `dev` и `prod` и общается с бэкендом ACITS через сгенерированный OpenAPI-клиент.

## Возможности

- **Реестр животных** — просмотр, поиск, создание и редактирование карточек животных.
- **Назначения** — учёт медицинских назначений и препаратов по каждому животному.
- **Календарь** — планирование и просмотр предстоящих событий ухода.
- **Заявители** — управление заявками на пристройство.
- **Кураторы** — назначение и управление ответственными за каждое животное.
- **Документы** — прикрепление и просмотр сопроводительных документов.
- **Фотогалерея** — галерея фотографий по каждому животному.
- **Онбординг** — вводный экран при первом запуске.
- **Авторизация** — безопасный вход с хранением токена.

## Технологический стек

| Область | Решение |
| --- | --- |
| Тулчейн | Flutter 3.44.0 / Dart 3.12.0, зафиксированы через [FVM](https://fvm.app) (`.fvmrc`) |
| Управление состоянием | `flutter_bloc` **Cubit** с sealed-типом `DataState<T>` + `DataStateBuilder`, `safeEmit`, `formz`, `equatable` |
| Навигация | [`go_router`](https://pub.dev/packages/go_router) — константы `AppRoutes`, объекты передаются через `extra` + `AppExtraCodec` |
| Локализация | [`easy_localization`](https://pub.dev/packages/easy_localization) — JSON-переводы, сгенерированные `LocaleKeys` |
| Внедрение зависимостей | `get_it` + `injectable` 3 |
| Сеть | Chopper + Dio, сгенерированы из OpenAPI (`doc/api/`) в `lib/api/` |
| Хранилище | `flutter_secure_storage` + `shared_preferences` (обёрнуты в `lib/service/`) |
| Firebase | `firebase_core` (конфиги в gitignore — скопируйте шаблоны `*.example`) |
| Тестирование | Юнит/bloc: `mocktail` + `bloc_test`; e2e: [Patrol](https://patrol.leancode.co) |
| CI | GitHub Actions (`.github/workflows/ci.yml`) — анализ + тесты, сборка Android (dev APK), сборка iOS (без подписи) |

## Начало работы

### Требования

- [FVM](https://fvm.app) (Flutter Version Management)

Установите зафиксированную версию Flutter и зависимости:

```bash
fvm install
fvm flutter pub get
```

### Настройка Firebase

Конфигурационные файлы Firebase находятся в gitignore. Скопируйте предоставленные шаблоны и подставьте свои значения:

```bash
cp android/app/src/dev/google-services.json.example  android/app/src/dev/google-services.json
cp android/app/src/prod/google-services.json.example android/app/src/prod/google-services.json
cp ios/Runner/GoogleService-Info.plist.example       ios/Runner/GoogleService-Info.plist
cp android/keystore/key.properties.example           android/keystore/key.properties
```

### Кодогенерация

Сгенерируйте DI, JSON-сериализацию, OpenAPI-клиент и прочие выходные файлы:

```bash
fvm dart run build_runner build --delete-conflicting-outputs
```

Перезапускайте после изменения любого класса с `@injectable`, JSON-сериализацией или аннотациями Chopper, а также после правок OpenAPI-спецификации в `doc/api/`.

## Запуск

Существуют два флейвора, у каждого своя точка входа.

```bash
# dev
fvm flutter run -t test/dev/main.dart --flavor dev

# prod
fvm flutter run -t lib/main.dart --flavor prod
```

## Структура проекта

```text
lib/
├── api/           # HTTP-слой на Chopper/Dio, сгенерирован из OpenAPI (не редактировать вручную)
├── di/            # контейнер get_it + injectable (initDi())
├── domain/        # доменные модели и енамы на чистом Dart
├── generated/     # LocaleKeys от easy_localization (генерируется)
├── l10n/          # хелперы локализации
├── navigation/    # go_router: app_router.dart (AppRoutes), extra_codec.dart
├── res/           # дизайн-токены: color, style, icon, lottie, strings
├── service/       # injectable-сервисы (auth, animal, document, storage, …)
├── ui/
│   ├── screen/    # по папке на фичу (cubit/bloc · view · model)
│   └── widget/    # общие виджеты приложения
├── util/          # data_state.dart, bloc_ext.dart, валидаторы, хелперы
├── export.dart    # общий barrel-файл проекта
└── main.dart      # точка входа prod (dev-точка входа: test/dev/main.dart)
```

## Локализация

Приложение использует `easy_localization`. Переводы лежат в `assets/translations/en.json` и `assets/translations/ru.json` (оба полные); ключи генерируются как `LocaleKeys`. Захардкоженных строк в UI нет — каждая строка проходит через ключ.

Чтобы добавить строку:

1. Добавьте ключ в **оба** файла `assets/translations/en.json` и `assets/translations/ru.json`.
2. Перегенерируйте ключи:

   ```bash
   fvm dart run easy_localization:generate \
     -S assets/translations -O lib/generated -o locale_keys.g.dart -f keys
   ```

3. Используйте в UI:

   ```dart
   Text(LocaleKeys.someKey.tr())
   ```

## Тестирование

Юнит- и bloc-тесты (`mocktail` + `bloc_test`) находятся в `test/unit/`:

```bash
fvm flutter test
```

End-to-end тесты используют [Patrol](https://patrol.leancode.co) и лежат в `integration_test/` (настройка в блоке `patrol:` в `pubspec.yaml`):

```bash
patrol test --flavor dev
```

## Сборка

```bash
# dev — Android APK
fvm flutter build apk -t test/dev/main.dart --flavor dev --release

# prod — Android App Bundle
fvm flutter build appbundle -t lib/main.dart --flavor prod --release

# prod — iOS
fvm flutter build ios -t lib/main.dart --flavor prod --release
```

### Форматирование и анализ

Длина строки — **100** (не дефолтные для Dart 80):

```bash
fvm dart format -l 100 lib test
fvm flutter analyze
```

## Участие в разработке

Мы рады вкладу. Пожалуйста, прочитайте [CONTRIBUTING.md](../../CONTRIBUTING.md) перед созданием pull request.

## Лицензия

Распространяется под [лицензией MIT](../../LICENSE).
