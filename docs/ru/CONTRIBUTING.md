[English](../../CONTRIBUTING.md) · **Русский**

# Участие в разработке acits_flutter

Спасибо за интерес к проекту **acits_flutter** — мобильному клиенту на Flutter для [acits.ru](https://acits.ru), свободному программному обеспечению с открытым исходным кодом для учёта животных в приюте.

Проект распространяется по лицензии **MIT**. Отправляя свой вклад, вы соглашаетесь с тем, что он будет лицензирован на тех же условиях.

Репозиторий: [github.com/aiserrock/acits-flutter](https://github.com/aiserrock/acits-flutter)

---

## Содержание

- [Требования](#требования)
- [Настройка проекта](#настройка-проекта)
- [Модель ветвления](#модель-ветвления)
- [Сообщения коммитов](#сообщения-коммитов)
- [Стандарты кода](#стандарты-кода)
- [Локализация](#локализация)
- [Тестирование](#тестирование)
- [Чек-лист перед PR](#чек-лист-перед-pr)
- [Создание pull request](#создание-pull-request)
- [Сообщения об ошибках](#сообщения-об-ошибках)

---

## Требования

Инструментарий зафиксирован через **FVM** (Flutter Version Management) в файле `.fvmrc` в корне репозитория.

| Инструмент | Версия |
| --- | --- |
| Flutter | 3.44.0 |
| Dart | 3.12.0 |
| FVM | актуальная стабильная |

Установите FVM и зафиксированный SDK:

```bash
dart pub global activate fvm
fvm install
```

Всегда добавляйте префикс `fvm` к командам Flutter и Dart, чтобы использовался зафиксированный SDK:

```bash
fvm flutter <команда>
fvm dart <команда>
```

---

## Настройка проекта

1. **Сделайте форк** репозитория на GitHub и **клонируйте** свой форк:

   ```bash
   git clone git@github.com:<ваш-логин>/acits-flutter.git
   cd acits-flutter
   ```

2. **Добавьте upstream-remote**, чтобы держать форк в актуальном состоянии:

   ```bash
   git remote add upstream git@github.com:aiserrock/acits-flutter.git
   ```

3. **Установите зависимости:**

   ```bash
   fvm flutter pub get
   ```

4. **Скопируйте шаблоны конфигурации.** Файлы конфигурации Firebase добавлены в gitignore; скопируйте шаблоны `*.example` и заполните их своими данными:

   ```bash
   # Android — по одному файлу на каждый флейвор:
   cp android/app/src/dev/google-services.json.example android/app/src/dev/google-services.json
   cp android/app/src/prod/google-services.json.example android/app/src/prod/google-services.json
   # iOS
   cp ios/Runner/GoogleService-Info.plist.example ios/Runner/GoogleService-Info.plist
   ```

   > Шаблон `key.properties.example` в `android/keystore/` работает так же, если нужно локально настроить подпись.

5. **Сгенерируйте код.** Проект использует кодогенерацию для DI (injectable), сериализации JSON, Chopper и локализации:

   ```bash
   fvm dart run build_runner build --delete-conflicting-outputs
   ```

6. **Запустите приложение.** Существуют два флейвора, каждый со своей точкой входа:

   ```bash
   # флейвор dev
   fvm flutter run -t test/dev/main.dart --flavor dev

   # флейвор prod
   fvm flutter run -t lib/main.dart --flavor prod
   ```

---

## Модель ветвления

Мы придерживаемся модели ветвления в стиле **git-flow**:

| Ветка | Назначение |
| --- | --- |
| `main` | Стабильный, готовый к релизу код. |
| `develop` | Интеграционная ветка, куда попадают фичи. |
| `feature/*` | Отдельные фичи и исправления, ответвлённые от `develop`. |

Создавайте ветку от `develop`:

```bash
git checkout develop
git pull upstream develop
git checkout -b feature/short-descriptive-name
```

Pull request всегда открывается **в ветку `develop`**, никогда в `main`.

---

## Сообщения коммитов

Мы используем [**Conventional Commits**](https://www.conventionalcommits.org/). Каждое сообщение коммита имеет вид:

```
<тип>(<необязательная область>): <описание>
```

Основные типы:

| Тип | Значение |
| --- | --- |
| `feat` | Новая функциональность. |
| `fix` | Исправление ошибки. |
| `refactor` | Изменение кода без исправления ошибки и без новой функциональности. |
| `docs` | Только документация. |
| `test` | Добавление или исправление тестов. |
| `chore` | Изменения сборки, инструментария или зависимостей. |
| `style` | Форматирование без влияния на код. |

Примеры:

```text
feat(animal-card): add vaccination history section
fix(login): handle expired refresh token
docs: update contributing guide for FVM 3.44
```

---

## Стандарты кода

- **Длина строки — 100** (не дефолтные 80 в Dart). Форматируйте каждое изменение:

  ```bash
  fvm dart format -l 100 lib test
  ```

- **Управление состоянием — `flutter_bloc` Cubit** вместе с sealed-типом `DataState<T>` (`lib/util/data_state.dart`), отображаемым через `DataStateBuilder`. Cubit'ы эмитят через `safeEmit` (`lib/util/bloc_ext.dart`), чтобы не эмитить после закрытия. Поля форм используют `formz`; модели — `equatable`.

- **События и состояния — sealed-классы.** Там, где используется полноценный BLoC, объявляйте его события и состояния как sealed-классы, прикреплённые к файлу блока. Для простых экранов «запрос/ответ» предпочтителен Cubit с `DataState<T>`.

- **Навигация — `go_router`** (`lib/navigation/app_router.dart`). Маршруты объявлены как константы в `AppRoutes`; сложные объекты передаются через `extra` и кодируются через `AppExtraCodec`. Не используйте императивные вызовы `Navigator` и именованные маршруты.

- **Внедрение зависимостей — `get_it` + `injectable` 3.** `initDi()` вызывается в `main` перед `runApp`. Перезапускайте `build_runner` после изменения любой аннотации `@injectable`. **Не регистрируйте Cubit/BLoC в DI** — предоставляйте их через `BlocProvider` на уровне виджета экрана, а зависимости берите из `getIt` в конструкторе.

- **Сеть — Chopper + Dio,** сгенерированные из OpenAPI-спецификации в `doc/api/` в каталог `lib/api/`. Никогда не редактируйте сгенерированные файлы вручную (`*.g.dart`, `*.chopper.dart`, `*.swagger.dart`). Для рукописных DTO используйте `@JsonSerializable` с `part '<name>.g.dart';`.

- **Хранилище** используется через обёртки в `lib/service/` вокруг `flutter_secure_storage` и `shared_preferences`. Не вызывайте `SharedPreferences.getInstance()` напрямую из фич.

- **Предпочитайте импорты `package:`** (`package:acits_flutter/...`) относительным импортам. В каждой папке экрана есть barrel-файл `<feature>.dart`; общий barrel `export.dart` реэкспортирует общие части.

- **Doc-комментарии пишутся на русском**, чтобы соответствовать существующей кодовой базе.

### Структура проекта

```text
lib/
├── api/           # сгенерированный HTTP-слой Chopper/OpenAPI (не редактировать)
├── di/            # контейнер get_it + injectable
├── domain/        # доменные модели на чистом Dart
├── generated/     # сгенерированные LocaleKeys (не редактировать)
├── navigation/    # конфигурация go_router (app_router.dart, AppRoutes)
├── res/           # дизайн-токены (цвета, стили, иконки)
├── service/       # injectable-сервисы, сгруппированные по назначению
├── ui/
│   ├── screen/<feature>/   # bloc-или-cubit / view / model для каждого экрана
│   └── widget/             # общие виджеты приложения
├── util/          # хелперы, DataState, bloc_ext
└── export.dart    # общий barrel проекта
```

---

## Локализация

Локализация использует **easy_localization**. Переводы находятся в `assets/translations/en.json` и `assets/translations/ru.json`, а ключи генерируются в `LocaleKeys` (`lib/generated/locale_keys.g.dart`). Английский и русский заполнены полностью; локаль по умолчанию (fallback) — `ru`.

**Хардкод пользовательских строк** в UI недопустим.

Чтобы добавить строку:

1. Добавьте **одинаковый ключ** в **оба** файла: `assets/translations/en.json` **и** `assets/translations/ru.json`.
2. Перегенерируйте ключи:

   ```bash
   fvm dart run easy_localization:generate \
     -S assets/translations -O lib/generated -o locale_keys.g.dart -f keys
   ```

3. Используйте в коде:

   ```dart
   Text(LocaleKeys.someKey.tr())
   ```

---

## Тестирование

- **Юнит- и BLoC/Cubit-тесты** лежат в `test/unit/` и используют `mocktail` + `bloc_test`:

  ```bash
  fvm flutter test
  ```

  Запуск одного файла или по имени:

  ```bash
  fvm flutter test test/unit/path/to/foo_test.dart
  fvm flutter test --name "description substring"
  ```

- **End-to-end тесты** используют **Patrol** (`integration_test/`, настройки в блоке `patrol:` файла `pubspec.yaml`):

  ```bash
  patrol test --flavor dev
  ```

Новые фичи следует сопровождать тестами. Исправления ошибок по возможности должны включать регрессионный тест.

---

## Чек-лист перед PR

Перед открытием pull request убедитесь, что выполнен каждый пункт:

- [ ] Код отформатирован: `fvm dart format -l 100 lib test`.
- [ ] Статический анализ чист: `fvm flutter analyze`.
- [ ] Все тесты проходят: `fvm flutter test`.
- [ ] Сгенерированный код перегенерирован, если менялись аннотации `@injectable` / `@JsonSerializable` / Chopper: `fvm dart run build_runner build --delete-conflicting-outputs`.
- [ ] Новые ключи локализации добавлены в **оба** файла `en.json` и `ru.json`, а `LocaleKeys` перегенерирован.
- [ ] В UI не осталось хардкода пользовательских строк.
- [ ] Коммиты соответствуют Conventional Commits.
- [ ] Ветка основана на `develop`.

---

## Создание pull request

1. Отправьте свою feature-ветку в форк:

   ```bash
   git push -u origin feature/short-descriptive-name
   ```

2. Откройте pull request **в ветку `develop`** upstream-репозитория.

3. Заполните описание PR: что изменилось, зачем и как это тестировалось. Свяжите связанные issue.

4. Убедитесь, что **CI зелёный.** Workflow в `.github/workflows/ci.yml` запускает анализ + тесты, сборку Android dev APK и сборку iOS без подписи.

5. Отвечайте на замечания ревью, добавляя новые коммиты в ту же ветку.

---

## Сообщения об ошибках

Пожалуйста, создавайте issue на GitHub, используя предоставленные **шаблоны issue**. Хороший отчёт об ошибке содержит:

- Понятный, описательный заголовок.
- Шаги для воспроизведения.
- Ожидаемое и фактическое поведение.
- Флейвор (`dev` / `prod`), устройство и версию ОС.
- Логи, скриншоты или запись экрана, если уместно.

Сначала поищите среди существующих issue, чтобы избежать дублей.

---

Спасибо, что помогаете улучшать acits_flutter и поддерживаете приюты для животных.
