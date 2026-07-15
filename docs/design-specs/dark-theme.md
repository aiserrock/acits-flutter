# Design Spec: Тёмная тема (Material 3)

## Problem

Приложение `acits_flutter` поддерживает только светлую тему. `MaterialApp.router`
задаёт единственную `ThemeData(useMaterial3: false, ColorScheme.light(...))`, а
все цвета и стили читаются из статических `ColorRes.const` (204 обращения в 50
файлах) и `StyleRes.const` (114 обращений). `Theme.of(context)` не используется
нигде (0 вызовов). Из-за компайл-тайм констант цвета физически не могут
реагировать на смену темы.

Нужна полноценная тёмная тема на современном стеке: **Material 3**, честные
`theme` + `darkTheme` + `themeMode`, палитра через `ColorScheme.fromSeed` от
акцентного цвета, кастомные семантические токены через `ThemeExtension`,
переключение System/Light/Dark с персистом. Акцентный бренд-цвет `#6776E0`
должен сохраниться в обеих темах.

Успех: пользователь выбирает System/Light/Dark, выбор запоминается между
запусками; в тёмной теме все 50 экранов читаемы и консистентны; палитра
генерируется от акцента и соответствует гайдлайнам Flutter-команды;
`flutter analyze` чистый.

## Solution Overview

- Включить **Material 3** (`useMaterial3: true`) с двумя `ThemeData` (light/dark),
  каждая на базе `ColorScheme.fromSeed(seedColor: accent, brightness: ...)` с
  явными override критичных слотов (точный accent, background, surface).
- Ввести **`AppColors extends ThemeExtension<AppColors>`** для семантических
  токенов, которых нет в M3 `ColorScheme` (indicatorActive/inactive,
  inactiveIcon, textSecondary-градации и т.п.). Реализовать `copyWith` +
  **настоящий `lerp`** (интерполяция `Color.lerp` по каждому токену) — чтобы
  переход между темами был плавным. Это отличается от ke-business-app, где `lerp`
  = no-op `return this` (у них тем две нет, интерполировать нечего).
- **Эргономичный доступ** через extension на `BuildContext` (паттерн взят из
  ke-business-app `context.themeStyle`): `context.appColors.indicatorActive`
  вместо длинного `Theme.of(context).extension<AppColors>()!.indicatorActive` в
  254 местах.
- **Полностью мигрировать** статические `ColorRes.X` / `StyleRes.X` (254
  обращения, 50 файлов) на `Theme.of(context).colorScheme.X` /
  `context.appColors.X`; типографику — на `Theme.of(context).textTheme.X`.
  `StyleRes` теряет жёстко зашитые цвета.
- **`ThemeCubit`** (bloc — как весь проект) держит `ThemeMode`, персистит в
  существующем `flutter_secure_storage`. `MaterialApp` оборачивается в
  `BlocBuilder<ThemeCubit, ThemeMode>`.
- **UI-переключатель** (System/Light/Dark) в `personal_drawer` — единственный
  очевидный контейнер настроек в текущем дереве.
- Тёмная палитра выведена «по смыслу», не тупой инверсией: accent осветляется по
  M3-тону (тот же hue), фон берёт тёмное семейство `#101432`, surface получает
  M3 elevation-градацию.

Домен реализации: **Flutter** (весь код в `.dart` под `lib/`). Планирование
пойдёт по Flutter stack-профилю.

## Scope

- **In scope:**
  - `lib/res/theme.dart` (новый): `AppTheme.light` / `AppTheme.dark` + `AppColors`
    ThemeExtension + M3 `TextTheme`.
  - Рефакторинг `lib/res/color.dart` и `lib/res/style.dart`: сырые палитры
    light/dark, удаление/переосмысление `@singleton class ColorRes` в DI.
  - `lib/ui/.../theme_cubit.dart` (новый) + персист в secure_storage.
  - Правка `lib/main.dart`: M3, `theme`/`darkTheme`/`themeMode`, `BlocBuilder`.
  - Миграция всех 50 файлов с `ColorRes.`/`StyleRes.` на `Theme.of(context)`.
  - UI-переключатель темы в `personal_drawer`.
  - `SystemChrome`/status-bar иконки и `PhoneFrame` (web) реагируют на тему.
  - `flutter analyze` = 0 ошибок; ручная визуальная проверка обеих тем.

- **Out of scope:**
  - Golden-тесты (выбран ручной путь верификации).
  - Custom-lint запрет на сырой `ColorRes` (выбрана мягкая верификация).
  - Отдельный полноценный экран «Настройки» (переключатель кладём в drawer).
  - Смена шрифтов/бренд-редизайн — только цвета и тема.
  - Анимация перехода между темами сверх дефолтной.

## Architecture Sketch

```
                        flutter_secure_storage  (уже в проекте)
                                   ▲  persist ThemeMode.index
                                   │
   runApp                    ┌─────┴───────┐
     │                       │ ThemeCubit  │  Cubit<ThemeMode>
     ▼                       │  (bloc)     │  system|light|dark
 ┌────────────────────┐      └─────┬───────┘
 │ BlocProvider        │           │ emits ThemeMode
 │  <ThemeCubit>       │           ▼
 │  ┌───────────────────────────────────────────────┐
 │  │ BlocBuilder<ThemeCubit, ThemeMode>            │
 │  │   MaterialApp.router(                          │
 │  │     theme:     AppTheme.light,   ◄─┐           │
 │  │     darkTheme: AppTheme.dark,    ◄─┤ M3        │
 │  │     themeMode: mode,               │           │
 │  │   )                                │           │
 │  └────────────────────────────────────┼──────────┘
 └───────────────────────────────────────┼───────────┘
                                          │
             ┌────────────────────────────┴───────────────┐
             │           AppTheme.light / .dark            │
             │  ThemeData(                                 │
             │    useMaterial3: true,                      │
             │    colorScheme: ColorScheme.fromSeed(       │
             │        seedColor: accent, brightness:X)     │
             │        .copyWith(primary:accent, ...),      │
             │    textTheme: <M3 TextTheme>,               │
             │    extensions: [ AppColors.light/.dark ],   │
             │  )                                          │
             └─────────────────────┬───────────────────────┘
                                   │ read at build time
        ┌──────────────────────────┼───────────────────────────┐
        ▼                          ▼                           ▼
 Theme.of(ctx)           Theme.of(ctx)                Theme.of(ctx)
   .colorScheme.primary    .textTheme.titleMedium       .extension<AppColors>()!
   .colorScheme.surface                                   .indicatorActive
   .colorScheme.error                                     .inactiveIcon
        │                          │                           │
        └───────────── 50 widget files (254 sites) ────────────┘
```

**Токен-раскладка (куда что уходит):**

| Текущий `ColorRes` | Назначение | Куда мигрирует |
|---|---|---|
| `accent` / `primaryButton` | акцент | `colorScheme.primary` |
| `indicatorActive` | активный индикатор | `AppColors.indicatorActive` |
| `indicatorInactive` | неактивный индикатор | `AppColors.indicatorInactive` |
| `inactiveIcon` | неактивные иконки | `AppColors.inactiveIcon` |
| `textPrimary` | заголовки | `colorScheme.onSurface` / `textTheme` |
| `textSecondary` | body/подписи | `AppColors.textSecondary` (или `onSurfaceVariant`) |
| `error` | ошибки | `colorScheme.error` |
| `foreground` (white) | текст на цветном | `colorScheme.onPrimary` |
| `background` | фон | `colorScheme.surface` |

## Data Model

- **`AppColors extends ThemeExtension<AppColors>`** — семантические токены вне
  ColorScheme: `indicatorActive`, `indicatorInactive`, `inactiveIcon`,
  `textSecondary` (+ при необходимости `caption`). Методы: `copyWith`, реальный
  `lerp` (по-токенно через `Color.lerp(a, b, t)`). Две инстанции:
  `const AppColors.light(...)`, `const AppColors.dark(...)` — как два именованных
  конструктора одного контракта (паттерн abstract-контракт + инстансы из
  ke-business-app `BaseColors`/`KeColors`, но здесь ось light/dark вместо бренда).
- **`extension AppColorsX on BuildContext`** — `AppColors get appColors =>
  Theme.of(this).extension<AppColors>()!;`. Единая точка доступа для виджетов.
- **`ThemeMode`** — стандартный enum Flutter (`system`/`light`/`dark`). Состояние
  `ThemeCubit`. Персист: `ThemeMode.index` (int) под ключом `theme_mode` в
  secure_storage.
- Сырые палитры: приватные `const Color` для light и dark семейств (свои `_dark*`
  оттенки фона/surface для тёмной темы).

**Целевая тёмная палитра (по смыслу, не инверсия):**

| Слот | Light | Dark (предложение) | Обоснование |
|---|---|---|---|
| primary (accent) | `#6776E0` | `#9DA7F1`-тон | M3: primary в dark светлее; hue сохранён = бренд жив |
| surface/background | `#F3F4F9` | `#101432`-семейство | тёмный фон из вашего же textPrimary «по смыслу» |
| onSurface (text) | `#101432` | near-white | инверсия текст↔фон по смыслу |
| textSecondary | `#9395A7` | чуть светлее серый | серый работает в обеих, поднять контраст |
| error | red | M3 dark-red (светлее) | контраст на тёмном |

Точные dark-hex подбираются на этапе реализации от `fromSeed` + override и
проверяются глазами.

## Screens / Flows (UI tasks)

- **Theme switcher (в `personal_drawer`)** — назначение: дать выбор
  System/Light/Dark. Состояния: текущий выбранный режим отмечен. Вход: открытие
  бокового меню. Выход: тап по варианту → `ThemeCubit.setMode()` → мгновенная
  перерисовка всего дерева + персист. UI-паттерн: список из 3 радио-опций
  (аналог `RadioSheet` из smp_bank, но нативно M3).
- **Все существующие экраны (50 файлов)** — визуально не меняют структуру;
  меняется только источник цвета (context вместо статики). Каждый должен
  корректно выглядеть в обеих темах после миграции.

## Reference Projects (что разобрано и что взято)

Разобраны 4 Flutter-проекта. **Ни один не реализует тёмную тему по-современному** —
это подтверждает, что копировать целиком нельзя ни один, но паттерны организации
взять стоит.

| Проект | M3 | dark | ColorScheme | ThemeExt | Доступ | Что берём / чему не следуем |
|---|---|---|---|---|---|---|
| smp_bank_copy | ❌ M2 | через синглтон | ручной `fromSwatch` | ❌ | `ColorRes.X` от синглтона | ❌ анти-паттерн, обходит `Theme.of` |
| ke-business-app | ❌ M2 | нет (TODO) | нет вообще | ✅ 1 (`ThemeStyle`) | `context.themeStyle.colors.X` | ✅ эргономика доступа + слои палитры; ❌ `lerp`=no-op |
| tms-driver-app | ❌ | нет | ручной `.light`, 2 слота | ❌ | `KEColors.X` статик | ❌ статик-глобал |
| acits_flutter (наш) | ❌ M2 | нет | `.light` | ❌ | `ColorRes.X` статик | базовая точка миграции |

**Взято в этот дизайн:**
- Из **ke-business-app** — эргономичный `context.appColors` (их `context.themeStyle`)
  и слоистость палитры (сырой swatch → семантические токены → инстанс).
- **Исправлено относительно них:** настоящий `lerp` (у ke-business no-op),
  реальные две инстанции light/dark (у всех тема одна), M3 + `fromSeed` +
  `themeMode` (ни у кого нет).

## Alternatives Considered

1. **smp_bank-подход (ColorRes-геттеры от синглтона ThemeMode)** — отклонён:
   Material 2, без `fromSeed`, без `ThemeExtension`; обходит Theme-наследование
   Flutter, требует полного ребилда дерева и глобального service-locator вместо
   `BuildContext`. Это ровно тот анти-паттерн, от которого предостерегает
   Flutter-команда; теряется весь смысл «M3 и современных вещей».
2. **ke-business-app / tms-driver-app подход (статик-токены, тема одна)** —
   отклонён как целевой: у ke-business хорошая слоистость палитры и эргономика
   `context.themeStyle`, но `useMaterial3: false`, нет `ColorScheme`, `lerp`
   = no-op и **тёмной темы просто нет**. tms — плоский `KEColors.X` статик без
   `ThemeExtension`. Берём у них только паттерны организации, не архитектуру темы.
2. **Гибрид: M3 ColorScheme + ColorRes как фасад-геттер над context** —
   отклонён: меньше правок сейчас, но консервирует статический доступ к цвету,
   резолв через глобальный `navigatorKey.context` хрупкий, и оставляет
   технический долг вместо чистой миграции.
3. **Инкрементальная миграция (мост + экраны потом)** — отклонён в пользу полной:
   выбран разовый чистый заход по всем 50 файлам (хорошо параллелится).
4. **Полностью ручная `ColorScheme.dark/light` без seed** — отклонён: ~20 слотов
   × 2 темы вручную, выше риск неконсистентности и провалов контраста; `fromSeed`
   даёт гармоничную базу автоматически, override — только критичные слоты.
5. **`ValueNotifier<ThemeMode>` (как smp_bank)** — отклонён: проект целиком на
   `flutter_bloc`, Cubit консистентнее с остальным кодом.

## Open Questions

- **Точные dark-hex для surface-градаций и textSecondary** — подбираются на
  реализации от `fromSeed`+override и проверяются глазами; в спеке зафиксировано
  только «по смыслу». Нужна ли будет ваша прогонка палитры перед миграцией всех
  экранов, или доверяете подбор на этапе реализации?
- **`@singleton class ColorRes` в DI** (`di_container.config.dart:77`) — удаляем
  из графа injectable полностью или оставляем как пустой legacy-holder на время
  миграции? Рекомендация: удалить, раз мигрируем всё сразу.
- **Дефолт при первом запуске** — `ThemeMode.system` (рекомендация). Подтвердить.

## Next Step

Hand this spec to `writing-plans` skill to produce a task-level plan.
Owning stack profile: **Flutter**.
