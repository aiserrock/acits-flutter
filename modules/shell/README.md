# shell

**Что это.** `shell` — «внешний каркас» приложения (app shell): место, где все
фича-модули **собираются вместе**. Фичи (`animals`/`auth`/`prescriptions`/
`personal`/`media`/`applicants`) изолированы и не знают друг о друге — иначе
циклы. Shell зависит от **всех** фич (строго вниз, без цикла: сами фичи shell не
импортируют) и связывает их в единое приложение.

## Что внутри

- **`app_scaffold.dart`** — composition root: `EasyLocalization → RestartWidget →
  ThemeCubit → MaterialApp.router` с роутером из DI + `PhoneFrame`. Это корневой
  виджет, который `runApp` рендерит (см. корневой `lib/run_app.dart`).
- **`navigation/`** — `app_router.dart` (сборка GoRouter-дерева из роутов всех
  фич), `auth_screen_bindings.dart`, `extra_codec.dart`, и 6 `*_router_service.dart`
  (реализации навигационных контрактов фич — единственное место, знающее go_router-пути).
- **`presentation/`** — **композиционные экраны**, которые собирают несколько фич:
  - `animal_detail` — карточка животного с табами из РАЗНЫХ фич: назначения
    (`prescriptions`), комментарии (`personal`), фото/PDF (`media`). Поэтому она
    НЕ в `modules/animals`: иначе `animals → media/personal/prescriptions`, а
    `media` уже зависит от `animals` → цикл `animals → media → animals`.
  - `animal_edit` — многошаговая форма (composition аналогично).
  - `main`/`root_screen` — навигационный хост (bottom-nav / drawer), переключает фичи.
  - `common/` — общий sort-бар и пр.
- **`widget/`** — виджеты уровня оболочки: `personal_drawer`,
  `theme_switcher_tile`, `phone_frame`, `restart_widget`, `ThemeCubit` и т.п.
- **`src/shell_di.dart`** — injectable micro-package (`ShellPackageModule`),
  через который DI приложения (`modules/base/di`) регистрирует router-service impls
  (consumer'ский `@InjectableInit` не сканит injectable'ы зависимости напрямую).

## Сравнение с hamkormobile

У hamkorа этот же слой размазан на несколько модулей:

| acits `shell` | hamkormobile |
|---|---|
| `navigation/app_router` (сборка роутов) | `modules/base/navigation` + per-feature route-модули + auto_route `*.gr.dart` |
| `main`/`root_screen` (bottom-nav) | `modules/bottom_navigation` |
| router-service impls | `*_route_module.dart` в каждой фиче |
| композиционные экраны (`animal_detail`/`edit`) | у hamkorа их меньше — фичи слабее переплетены |

Мы держим всё в одном `shell`, потому что приложение меньше и композиционных
экранов немного. При росте `shell` можно разбить по образцу hamkorа
(`navigation` + `bottom_navigation` + per-feature route-модули).

## Правило зависимостей

`shell` импортирует: 6 фич + `app_services` + `core` + `ui_kit` + `navigation`
(примитивы) + `localization` + `util` + `network` + `di` + go_router/flutter_bloc.
**Не** импортирует `package:acits_flutter/...` (это зависимость app, не наоборот).
Ничто не импортирует `shell`, кроме корневого app (`lib/`).
