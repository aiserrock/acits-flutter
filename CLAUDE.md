# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Toolchain

Project is pinned via FVM to **Flutter 3.44.0 / Dart 3.12.0 (SDK >=3.9.0 <4.0.0)**. Always prefix commands with `fvm` so the pinned SDK is used:

```bash
fvm flutter <cmd>
fvm dart <cmd>
```

## Common commands

**Code generation** (Injectable DI, JsonSerializable, Chopper, flutter_gen, Swagger OpenAPI):
```bash
fvm flutter pub run build_runner build --delete-conflicting-outputs
```
Run after changing any `@injectable`, `@JsonSerializable`, or Chopper-annotated class, or after touching `doc/api/` (swagger).

**Formatting / analysis** — note line length is **100** (not the Dart default 80):
```bash
fvm flutter format -l 100 .
fvm flutter analyze .
```

**Localization** — after editing `lib/l10n/intl_*.arb`:
```bash
fvm flutter pub run intl_utils:generate
fvm flutter format -l 100 .
```
The generated class is `StringRes` (see `pubspec.yaml` → `flutter_intl.class_name`), exposed via `S.of(context)` / `StringRes.of(context)` and wired through `StringRes.delegate` in `main.dart`.

**Native splash**:
```bash
fvm flutter pub run flutter_native_splash:create
```

**Tests**:
```bash
fvm flutter test                                        # all unit/widget tests
fvm flutter test test/path/to/foo_test.dart             # single file
fvm flutter test --name "description substring"         # single test by name
```

**Integration (Gherkin) tests**:
```bash
fvm flutter drive \
  --driver=test//integration_test/entry/integration_test_driver.dart \
  --target=test/integration_test/gherkin_suite_test.dart \
  --flavor dev
```

**Build** — two flavors exist, `dev` and `prod`, with distinct entry points:
- Dev entry: `test/dev/main.dart`
- Prod entry: `lib/main.dart`

```bash
# dev
fvm flutter build appbundle -t test/dev/main.dart --flavor dev --release \
  --obfuscate --split-debug-info=./build/app/outputs/symbols/dev
fvm flutter build apk       -t test/dev/main.dart --flavor dev --release

# prod
fvm flutter build appbundle -t lib/main.dart --flavor prod --release \
  --obfuscate --split-debug-info=./build/app/outputs/symbols/prod
fvm flutter build ios       -t lib/main.dart --flavor prod --release \
  --obfuscate --split-debug-info=./build/app/outputs/symbols/prod
```

iOS TestFlight (dev) uses Fastlane:
```bash
export LANG=en_US.UTF-8
(fvm flutter clean && fvm flutter pub get && cd ios && pod repo update && pod install)
fvm flutter build ios --flavor dev -t test/dev/main.dart --no-codesign \
  --obfuscate --split-debug-info=./build/app/outputs/symbols/dev
(cd ios && fastlane releaseDev)
```

## Architecture

Single-package Flutter app (no melos/monorepo). Top-level layout under `lib/`:

- **`api/`** — Swagger/OpenAPI-generated HTTP layer (`openapi.swagger.dart`, `openapi.swagger.chopper.dart`, enums). Generated — do not hand-edit. The analyzer excludes `*.g.dart`, `*.chopper.dart`, `*.swagger.dart`, and `lib/di/*.config.dart` (see `analysis_options.yaml`).
- **`di/`** — GetIt + Injectable container. `initDi()` is called from `main()` before `runApp`; it also registers the app-wide `GlobalKey<NavigatorState>` and `GlobalKey<ScaffoldMessengerState>` that screens grab via `getIt<...>()` to navigate/show snackbars without a `BuildContext`.
- **`domain/`** — plain Dart domain models (`Animal`, `Prescription`, `Applicant`, enums, exceptions).
- **`service/`** — injectable services grouped by concern (`auth/`, `animal/`, `client/`, `config/`, `debug/`, `document/`, `file/`, `link_handler/`, `personal/`, `prescription/`, `secure_storage/`, `shared_pref/`, `staff/`). Repositories live next to the service that owns them (e.g. `service/auth/auth_repository.dart`).
- **`ui/screen/<feature>/`** — one folder per screen. Convention inside each feature:
  - `bloc/<name>_bloc.dart` with `part '<name>_event.dart';` / `part '<name>_state.dart';`
  - `view/` — screen widgets (often with a `view.dart` barrel)
  - `model/` — screen-local models (often with `model.dart` barrel)
  - `<feature>.dart` — barrel re-exporting `bloc`, `view`, `model`
- **`ui/widget/`** — app-wide shared widgets (buttons, cards, loaders, drawers, etc.).
- **`res/`** — design tokens: `color.dart`, `style.dart`, `icon.dart`, `lottie.dart`, `strings.dart`.
- **`gen/`** — `flutter_gen` output (assets, fonts). Generated; do not edit.
- **`generated/`** — intl output (`l10n.dart` exposing `StringRes`). Generated; do not edit.
- **`l10n/`** — source `.arb` files (`intl_ru.arb` is the template per `l10n.yaml`).
- **`util/`** — generic helpers.
- **`export.dart`** — project-wide barrel re-exporting `util`, common domain, swagger API, assets, res, and l10n. Prefer importing from here for shared pieces.
- **`main.dart`** (prod) / **`test/dev/main.dart`** (dev) — flavor entry points. `MyApp` wires theme, localizations, DI-provided navigator/scaffold keys, and routes the first frame to either `OnboardingScreen` or `LoginScreen` based on `ConfigService.isFirstLaunch`.

### State management

**flutter_bloc + formz + equatable**. Conventions (enforced across the codebase, see `.claude/skills/`):
- Events and States are **sealed** classes attached via `part`/`part of` to the bloc file. Never use `freezed` for them.
- BLoCs live in `ui/screen/<feature>/bloc/` and pull their dependencies from `getIt` in the constructor body (see `login_bloc.dart`). **Do not register Blocs in DI** — they are provided via `BlocProvider` at the screen widget.
- Form state uses `Formz` inputs (`Name.dirty(...)`, `Password.dirty(...)`) and `FormzStatus` for submission lifecycle.

### Networking / DTOs

- HTTP via **Chopper + Dio**, generated from `doc/api/` OpenAPI spec into `lib/api/`.
- For any hand-written request/response/object DTO use `@JsonSerializable` (with `part '<name>.g.dart';`). **Never use `freezed` for DTOs.**

### Storage

- `flutter_secure_storage` wrapped by `service/secure_storage/`.
- `shared_preferences` wrapped by `service/shared_pref/` — go through that wrapper, don't call `SharedPreferences.getInstance()` directly from features.

### Flavors / environments

DI is initialized with `NoEnvOrContains(Environment.prod)`, and `DebugService` is in `ignoreUnregisteredTypes` so it can be absent in prod builds. `test/dev/main.dart` is the dev entry point with dev-only wiring.

## Conventions

- **Line length is 100.** `fvm flutter format -l 100 .` before committing. `flutter_gen` and `flutter_intl` are also configured to 100 in `pubspec.yaml`.
- **No hardcoded user-facing strings in UI** — add to `lib/l10n/intl_ru.arb`, regenerate, access via `StringRes.of(context).<key>`.
- **Barrel files** — each screen folder ships a `<feature>.dart` that re-exports `bloc` / `view` / `model`. Prefer `package:acits_flutter/...` absolute imports over relative ones.
- **Doc-comments in Russian** (matches existing codebase and project skills).
- After changing Injectable / JsonSerializable / Chopper annotations, rerun `build_runner build --delete-conflicting-outputs`. The generated files committed to the repo are the source of truth for the analyzer.

## Project-specific skills & agents

`.claude/skills/` and `.claude/agents/` contain detailed internal playbooks (`architecture`, `code-style`, `code-review`, `testing`, plus `plan` / `implement` / `test-write` / `document` / `review` / `orchestrator` agents). Consult them before large changes — note that the `architecture` skill currently describes a melos/multi-package setup (`packages/base/...`, `sharable_domain`, `feature_<name>`) that does **not** match this repo's single-package layout; treat its package-structure sections as aspirational and prefer the actual `lib/` layout documented above. Its BLoC/DTO/storage rules still apply.
