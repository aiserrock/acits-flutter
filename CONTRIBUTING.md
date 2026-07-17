**English** · [中文](docs/zh/CONTRIBUTING.md) · [हिन्दी](docs/hi/CONTRIBUTING.md) · [Español](docs/es/CONTRIBUTING.md) · [Français](docs/fr/CONTRIBUTING.md) · [العربية](docs/ar/CONTRIBUTING.md) · [Русский](docs/ru/CONTRIBUTING.md)

# Contributing to acits_flutter

Thank you for your interest in contributing to **acits_flutter** — the Flutter mobile client for [acits.ru](https://acits.ru), free and open-source software for tracking animals inside an animal shelter.

This project is licensed under the **MIT License**. By contributing, you agree that your contributions will be licensed under the same terms.

Repository: [github.com/aiserrock/acits-flutter](https://github.com/aiserrock/acits-flutter)

---

## Table of contents

- [Prerequisites](#prerequisites)
- [Project setup](#project-setup)
- [Branching model](#branching-model)
- [Commit messages](#commit-messages)
- [Coding standards](#coding-standards)
- [Codegen rituals](#codegen-rituals)
- [Localisation](#localisation)
- [Testing](#testing)
- [Pre-PR checklist](#pre-pr-checklist)
- [Opening a pull request](#opening-a-pull-request)
- [Reporting bugs](#reporting-bugs)

---

## Prerequisites

The toolchain is pinned via **FVM** (Flutter Version Management) through the `.fvmrc` file at the repository root.

| Tool | Version |
| --- | --- |
| Flutter | 3.44.0 |
| Dart | 3.12.0 |
| FVM | latest stable |

Install FVM and the pinned SDK:

```bash
dart pub global activate fvm
fvm install
```

Always prefix Flutter and Dart commands with `fvm` so the pinned SDK is used:

```bash
fvm flutter <command>
fvm dart <command>
```

A working Android and/or iOS toolchain (Android Studio / Xcode) is also required to build and run the app.

---

## Project setup

1. **Fork** the repository on GitHub and **clone** your fork:

   ```bash
   git clone git@github.com:<your-username>/acits-flutter.git
   cd acits-flutter
   ```

2. **Add the upstream remote** so you can keep your fork in sync:

   ```bash
   git remote add upstream git@github.com:aiserrock/acits-flutter.git
   ```

3. **Fetch dependencies:**

   ```bash
   fvm flutter pub get
   ```

4. **Copy the example configuration templates.** Firebase configuration files are gitignored; copy the `*.example` templates and fill in your own credentials:

   ```bash
   # Android — per-flavour, one file per flavour:
   cp android/app/src/dev/google-services.json.example android/app/src/dev/google-services.json
   cp android/app/src/prod/google-services.json.example android/app/src/prod/google-services.json
   # iOS
   cp ios/Runner/GoogleService-Info.plist.example ios/Runner/GoogleService-Info.plist
   ```

   > The `key.properties.example` under `android/keystore/` follows the same pattern if you need signing configured locally.

5. **Generate code.** Two independent codegen passes, kept apart on purpose:

   ```bash
   # App-level: injectable DI, flutter_gen assets, json_serializable DTOs.
   fvm dart run build_runner build --delete-conflicting-outputs

   # API client: swagger_parser, isolated inside packages/acits_api — runs its
   # own preprocess + swagger_parser + build_runner. Only needed when the
   # OpenAPI spec (doc/api/openapi.json) changes; the generated client is committed.
   melos genapi
   ```

   The two are separate so the rarely-changing API client is **not** regenerated on every app `build_runner`. See the [codegen rituals](#codegen-rituals) below.

6. **Run the app.** Two flavours exist, each with its own entry point:

   ```bash
   # dev flavour
   fvm flutter run -t test/dev/main.dart --flavor dev

   # prod flavour
   fvm flutter run -t lib/main.dart --flavor prod
   ```

---

## Branching model

We follow a **git-flow** style branching model:

| Branch | Purpose |
| --- | --- |
| `main` | Stable, release-ready code. Always deployable. Never target it directly with PRs. |
| `develop` | Integration branch where feature work lands. All contributions target `develop`. |
| `feature/*` | Individual features and fixes, branched off `develop`. |

Create your branch off `develop`:

```bash
git fetch upstream
git checkout develop
git merge upstream/develop
git checkout -b feature/short-descriptive-name
```

Pull requests are always opened **against `develop`**, never against `main`.

---

## Commit messages

We use [**Conventional Commits**](https://www.conventionalcommits.org/). Each commit message has the form:

```
<type>(<optional scope>): <description>
```

Common types:

| Type | Meaning |
| --- | --- |
| `feat` | A new feature. |
| `fix` | A bug fix. |
| `refactor` | A code change that neither fixes a bug nor adds a feature. |
| `docs` | Documentation only. |
| `test` | Adding or correcting tests. |
| `chore` | Build process, tooling, or dependency changes. |
| `style` | Formatting changes with no code impact. |

Examples:

```text
feat(animals): add photo gallery to animal detail screen
fix(auth): handle expired token on cold start
docs: update contributing guide for FVM 3.44
```

---

## Coding standards

- **Line length is 120** (not the Dart default of 80). Format every change (`melos format` applies the same exclusions across the workspace):

  ```bash
  fvm dart format -l 120 lib test
  ```

- **State management uses `flutter_bloc`** with the shared `DataState<T>` from `acits_core`. Cubits guard against emit-after-close (`isClosed` / a `_safeEmit` helper). Form inputs use `formz`; models use `equatable`.

- **Events and states are sealed classes.** Where a full BLoC is used, define its events and states as sealed classes attached to the bloc file. Prefer a Cubit with `DataState<T>` for straightforward request/response screens.

- **Navigation uses `go_router`** with per-feature `RouterService` interfaces (a feature never imports go_router or app routes — the root implements its contract and injects it). Routes carry identity through **path/query params, not `extra`** (a browser reload / shared URL must reconstruct the screen). `extra` is allowed only as an optional in-memory cache hint with an `id`-based fallback load. Do not use imperative `Navigator` calls or named-route strings.

- **Dependency injection uses `get_it` + `injectable` 3.** `initDi()` runs inside the `AppTask` startup pipeline before `runApp`. Re-run `build_runner` after touching any `@injectable` annotation. **Do not register Cubits/BLoCs in DI** — provide them via `BlocProvider` at the screen widget and pull their dependencies from `getIt` in the constructor.

- **Networking uses a single dio client behind a ports-and-adapters API layer** in `packages/acits_api`. Features and repositories depend on stable `abstract <Feature>ApiPort` interfaces speaking OUR DTOs (`packages/acits_api/lib/ports/dto/`); the generated `swagger_parser` client lives only in `packages/acits_api/lib/adapters/` and never leaks upward. **DTO containment rule:** DTOs exist only inside `acits_api` and repository implementations — repositories map DTO → domain entity via a `Transformable<T>` mapper and return `Result<Failure, T>`. There is no chopper. Never hand-edit generated files. For hand-written DTOs use `@JsonSerializable` with `part '<name>.g.dart';`.

- **State returns `Result<Failure, T>`** (`acits_core`) from repositories. Use **Bloc + freezed state** when a screen has ≥2 event sources or a non-trivial flow; otherwise **Cubit + Equatable** (with the shared `DataState<T>` from `acits_core`). Prefer `copyWith` over hand-rolled sealed states when the state has many fields.

- **Storage** goes through the wrappers in `lib/service/` around `flutter_secure_storage` and `shared_preferences`. Do not call `SharedPreferences.getInstance()` directly from features.

- **Prefer `package:` imports** (`package:acits_flutter/...`) over relative imports. Each screen folder ships a `<feature>.dart` barrel; the project-wide `export.dart` barrel re-exports shared pieces.

- **Doc-comments are written in Russian** to match the existing codebase.

### Project layout

The repo is a melos **workspace** — a thin root app plus packages and feature modules. Each package ships its own `README.md` describing its purpose and dependency rule.

```text
acits_flutter/
├── lib/                  # root app shell: main/bootstrap, AppTask pipeline, DI composition, router tree
│   ├── di/               #   get_it + injectable container (config lives next to its @InjectableInit source)
│   └── gen/              #   app-owned generated code (LocaleKeys, flutter_gen assets) — do not edit
├── packages/
│   ├── acits_core/       # Result/Failure, dio client + interceptors, AppTask, platform ports
│   ├── acits_domain/     # shared entities, repository interfaces, Transformable<T> — DTO-free
│   ├── acits_api/        # <Feature>ApiPort + our DTOs (ports/); swagger_parser adapter (adapters/)
│   ├── acits_ui_kit/     # Material 3 tokens, breakpoints, AdaptiveScaffold, components
│   └── acits_navigation/ # route constants, param codecs, guards (no feature imports)
└── modules/
    └── animals/          # reference feature: data/ (data_source, mapper, repository_impl)
                          #                     domain/ (entities, repository iface, router contract)
                          #                     ui/<screen>/ (bloc|cubit / view / widgets)
```

A new feature module is scaffolded with `mason make feature --name <feature>`; a new screen inside an existing module with `mason make screen --name <screen>` (see [Scaffolding with mason](#scaffolding-with-mason)).

---

## Codegen rituals

Two generators, deliberately separated:

| Command | Generates | When to run |
| --- | --- | --- |
| `fvm dart run build_runner build --delete-conflicting-outputs` (or `melos gen`) | injectable DI, flutter_gen assets, json_serializable `*.g.dart` | after touching `@injectable`, `@JsonSerializable`, or adding assets |
| `melos genapi` | the `swagger_parser` API client + models inside `acits_api` | **only** when `doc/api/openapi.json` changes |
| `melos genone` (`MELOS_GENONE_PKG=packages/<pkg> melos run genone`) | build_runner for a single package | when regenerating one package in isolation |

Skipping `genapi` after a spec change leaves a stale client (missing DTO fields, `InvalidType` at build). See [docs/GOTCHAS.md](docs/GOTCHAS.md).

### Scaffolding with mason

Bricks live under `bricks/` and are registered in `mason.yaml`. Install once, then scaffold:

```bash
dart pub global activate mason_cli
mason get                                   # resolve bricks from mason.yaml
mason make feature --name prescriptions     # new modules/prescriptions/ skeleton
mason make screen  --name prescription_detail --module prescriptions   # new screen in a module
```

After scaffolding a feature/screen, run `build_runner` (DI/json) and wire the new port/adapter/router in the root DI composition.

### Adding a feature or endpoint

The endpoint ritual is mechanical (details in [CLAUDE.md](CLAUDE.md)):

1. Add the method to the feature's `abstract <Feature>ApiPort` (in terms of our DTOs).
2. Add/extend the DTO under `acits_api/lib/ports/dto/` (`@JsonSerializable`).
3. Implement it in the `swagger_parser` adapter (map generated model → our DTO). Run `melos genapi` if the spec changed.
4. Expose it on the feature repository interface (`domain/`) returning `Result<Failure, T>`; implement in `data/repository/` mapping DTO → entity.
5. Consume it from the cubit/bloc, then the screen. DTOs never leave the data layer.

---

## Localisation

Localisation uses **easy_localization**. Translations live in `assets/translations/en.json` and `assets/translations/ru.json`, and keys are generated into `LocaleKeys` (`lib/gen/l10n/locale_keys.g.dart`). Both English and Russian are complete; the fallback locale is `ru`.

**No hardcoded user-facing strings** are allowed in the UI.

To add a string:

1. Add the **same key** to **both** `assets/translations/en.json` **and** `assets/translations/ru.json`.
2. Regenerate the keys:

   ```bash
   fvm dart run easy_localization:generate \
     -S assets/translations -O lib/gen/l10n -o locale_keys.g.dart -f keys
   ```

3. Use it in code:

   ```dart
   Text(LocaleKeys.someKey.tr())
   ```

---

## Testing

- **Unit and BLoC/Cubit tests** use `mocktail` + `bloc_test`. The root app's tests live in `test/`; each package/module ships its own `test/` (e.g. `modules/animals/test/` has mapper, repository, and cubit tests). Run the root suite with:

  ```bash
  fvm flutter test
  ```

  Run the whole workspace (root + every package/module) with:

  ```bash
  for p in . packages/* modules/*; do [ -d "$p/test" ] && (cd "$p" && fvm flutter test); done
  ```

  Run a single file or match by name:

  ```bash
  fvm flutter test test/unit/path/to/foo_test.dart
  fvm flutter test --name "description substring"
  ```

- **End-to-end tests** use **Patrol** (`integration_test/`, configured in the `patrol:` block of `pubspec.yaml`):

  ```bash
  patrol test --flavor dev
  ```

New features should ship with tests. Bug fixes should include a regression test where practical.

---

## Pre-PR checklist

Before opening a pull request, confirm every item below:

- [ ] Code is formatted: `fvm dart format -l 120 lib test` (or `melos format`).
- [ ] Static analysis is clean under the strict gate: `melos analyze:strict` (`flutter analyze --fatal-infos --fatal-warnings`).
- [ ] All tests pass — root **and** touched packages/modules (`melos check-all` runs format → strict analyze → test).
- [ ] Generated code is regenerated if any `@injectable` / `@JsonSerializable` annotation changed: `fvm dart run build_runner build --delete-conflicting-outputs`; if the OpenAPI spec changed, `melos genapi` too.
- [ ] New localisation keys were added to **both** `en.json` and `ru.json`, and `LocaleKeys` was regenerated.
- [ ] No hardcoded user-facing strings remain in the UI.
- [ ] Commits follow Conventional Commits.
- [ ] The branch is based on `develop`.

Commit any regenerated files — the generated files committed to the repository are the source of truth for the analyser.

---

## Opening a pull request

1. Push your feature branch to your fork:

   ```bash
   git push -u origin feature/short-descriptive-name
   ```

2. Open a pull request **against `develop`** on the upstream repository. **The PR title must be a semantic-commit line** (`feat|fix|docs|ci|refactor|chore|test|build|perf|style|revert`, optional scope) — a `Semantic PR` check enforces it (`.github/workflows/semantic-pr.yml`), e.g. `feat(animals): add PDF export`.

3. Fill in the PR description: what changed, why, and how it was tested. **Link the related issue** (e.g. `Closes #123`) so it is tracked and auto-closed on merge.

4. Ensure **CI is green.** The workflow at `.github/workflows/ci.yml` runs the strict analyse (`--fatal-infos --fatal-warnings`) + tests (root and packages/modules), an Android dev APK build, and an unsigned iOS build.

5. Address review feedback by pushing additional commits to the same branch.

Keep PRs focused and reasonably small — smaller PRs are reviewed and merged faster.

---

## Reporting bugs

Please open an issue on GitHub using the provided **issue templates**. A good bug report includes:

- A clear, descriptive title.
- Steps to reproduce.
- Expected versus actual behaviour.
- The flavour (`dev` / `prod`), device, and OS version.
- Logs, screenshots, or a screen recording where relevant.

Search existing issues first to avoid duplicates. For security-sensitive reports, contact the maintainers privately rather than filing a public issue.

---

Thank you for helping improve acits_flutter and supporting animal shelters.
