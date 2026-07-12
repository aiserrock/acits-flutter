# Design Spec: Технический roadmap acits_flutter

> Дата: 2026-07-12. Метод: параллельное исследование 5 продакшн-кодовых баз
> (hamkormobile, tms-driver-app + tms-libs, экосистема kazan_express, smp_bank_copy)
> + аудит acits_flutter; каждый пункт адверсариально верифицирован против реального кода репозитория.

## Problem

acits_flutter — OSS-проект с одним мейнтейнером. Архитектурное ядро здоровое
(Cubit+DataState, injectable-окружения, dev-флейвор вне `lib/`, зрелый CI,
CONTRIBUTING на 6 языках), но вокруг него нет страховочной сетки: UI (~11k строк,
экраны до 744 строк) не покрыт ни widget-, ни golden-тестами; линтер базовый и
пропускает implicit dynamic; команды разработки живут текстом в CONTRIBUTING и уже
разъехались с CI; прод-наблюдаемость мертва (Talker в release выключен → Crashlytics
без breadcrumbs); ошибки сети неразличимы для UI (всё показывается как «нет
интернета»); зависимости устаревают молча. Успех — проект, где рефакторинг безопасен,
онбординг контрибьютора занимает минуты, а инцидент в проде диагностируется по данным.

## Solution Overview

- **Страховочная сетка**: строгий анализатор (strict-modes, без very_good_analysis — замер показал 85% шума), coverage в CI, widget-тесты с test keys, golden через alchemist (CI-эталоны платформонезависимы).
- **Единая точка входа**: Makefile с параметризацией `FLUTTER ?= fvm flutter`, чтобы CI и локаль звали одни и те же таргеты; format-check с исключениями генерённых файлов — один источник истины.
- **Типизированные ошибки**: sealed `AppException` + `unwrap()`-хелпер над Chopper Response (этап 1), типизация `DataState.error` — этап 2; параллельно унификация HTTP-стека (dio-остатки → общий контур auth/логирования).
- **Наблюдаемость**: включить Talker в prod release с no-op консольным выводом — существующий `CrashlyticsTalkerObserver` начнёт слать breadcrumbs; `FirebaseAnalyticsObserver` в GoRouter.
- **Гигиена**: dependabot (с Dependabot secrets), supply-chain hardening CI (SHA-pin, least-privilege permissions, osv-scanner), git-хуки в `.githooks/`, CI-проверка паритета ключей en/ru.
- **Знание в репо**: AGENTS.md для AI-ассистентов, doc/release.md с проверенным релизным флоу.

## Scope

- In scope: тулинг, качество кода, тестовая инфраструктура, CI/CD, наблюдаемость, DX, документация процессов.
- Out of scope: продуктовые фичи, редизайн, смена стека (bloc/injectable/Chopper/go_router остаются), melos/монорепо (оверкилл для одного пакета), mason bricks (отложено — нет паттернов, которые brick мог бы тиражировать), вынос `lib/gen` в path-пакет (analysis exclude уже решает проблему).

## Architecture Sketch

Roadmap делится на три волны по зависимостям:

```
Волна 1 «Фундамент» (всё S, независимо):
  Makefile ──┬─→ git-хуки (используют таргеты)
             └─→ CI зовёт make format-check
  strict analyzer • coverage • dependabot • supply-chain • l10n-parity • AGENTS.md

Волна 2 «Сетка и ошибки»:
  test_keys + widget-тесты (2-3 экрана)
  sealed AppException + unwrap (этап 1) ──→ типизация DataState (этап 2)
  унификация dio→общий контур • Talker в prod • golden (alchemist)

Волна 3 «Хвосты» (по мере касания):
  Material 3 + ThemeExtension • Patrol+Mockoon на эмуляторе (нужны предпосылки)
  fastlane → tag-пайплайн • bootstrap() • gen_api.sh • analytics observer
```

## Data Model

- `AppException` — sealed: `NetworkException`, `TimeoutException`, `ServerException(statusCode)`, `ValidationException`, `UnauthorizedException`; существующие `NotAuthorizedException`/`EmailConfirmException` вливаются как подтипы.
- `TestKeys` — abstract-классы Key-констант по экранам в `lib/res/test_keys.dart` (общие для widget-тестов и Patrol).
- ThemeExtension-токены (colors + typography из существующих `ColorRes`/`StyleRes`) в `lib/res/theme.dart`.

## Alternatives Considered

1. **very_good_analysis** — отклонено замером: 2328 issues, ~85% стилистический шум (public_member_api_docs, 80-chars); strict-modes поверх flutter_lints дают 31 содержательный issue.
2. **Вынос lib/gen в path-пакет** — отклонено: `analysis_options.yaml` уже исключает `lib/gen/**`, а цена — правка импортов в ~19 файлах.
3. **golden_toolkit + tolerance-компаратор** — отклонено: пакет заархивирован; alchemist со сплитом Platform/CI-goldens решает проблему Mac/Linux без хаков.
4. **Mason brick для скаффолдинга** — отложено: brick генерировал бы заготовки под ещё не существующие паттерны (test keys, widget-тесты).
5. **runZonedGuarded** — отклонено: `PlatformDispatcher.onError` уже покрывает async-ошибки (Flutter 3.3+).
6. **doc/wiki с нумерованными файлами** — отклонено: дублирует CONTRIBUTING.md (6 языков — каждый дубль умножает поверхность протухания).

## Open Questions

- Codecov-бейдж или достаточно lcov-артефакта в CI? (roadmap исходит из артефакта)
- Firebase Analytics: оставить с observer'ом или выпилить целиком? (roadmap рекомендует observer — Firebase уже поднят, цена пары строк)
- Dependabot secrets vs `if: github.actor != 'dependabot[bot]'` в build-джобах — потребует выбора при внедрении.

## Next Step

Roadmap с полной детализацией пунктов: `docs/tech-roadmap.md`.
Внедрение волнами — каждый пункт волны 1 умещается в один PR.
