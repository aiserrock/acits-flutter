**English** · [Русский](docs/ru/CONTRIBUTING.md)

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

5. **Generate code.** The project uses code generation for DI (injectable), JSON serialisation, and Chopper:

   ```bash
   fvm dart run build_runner build --delete-conflicting-outputs
   ```

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

- **Line length is 100** (not the Dart default of 80). Format every change:

  ```bash
  fvm dart format -l 100 lib test
  ```

- **State management uses `flutter_bloc` Cubits** together with a sealed `DataState<T>` (`lib/util/data_state.dart`) rendered through `DataStateBuilder`. Cubits emit via `safeEmit` (`lib/util/bloc_ext.dart`) to avoid emitting after close. Form inputs use `formz`; models use `equatable`.

- **Events and states are sealed classes.** Where a full BLoC is used, define its events and states as sealed classes attached to the bloc file. Prefer a Cubit with `DataState<T>` for straightforward request/response screens.

- **Navigation uses `go_router`** (`lib/navigation/app_router.dart`). Routes are declared as constants in `AppRoutes`; complex objects are passed through `extra` and encoded via `AppExtraCodec`. Do not use imperative `Navigator` calls or named routes.

- **Dependency injection uses `get_it` + `injectable` 3.** `initDi()` is called in `main` before `runApp`. Re-run `build_runner` after touching any `@injectable` annotation. **Do not register Cubits/BLoCs in DI** — provide them via `BlocProvider` at the screen widget and pull their dependencies from `getIt` in the constructor.

- **Networking uses Chopper + Dio,** generated from the OpenAPI spec under `doc/api/` into `lib/api/`. Never hand-edit generated files (`*.g.dart`, `*.chopper.dart`, `*.swagger.dart`). For hand-written DTOs use `@JsonSerializable` with `part '<name>.g.dart';`.

- **Storage** goes through the wrappers in `lib/service/` around `flutter_secure_storage` and `shared_preferences`. Do not call `SharedPreferences.getInstance()` directly from features.

- **Prefer `package:` imports** (`package:acits_flutter/...`) over relative imports. Each screen folder ships a `<feature>.dart` barrel; the project-wide `export.dart` barrel re-exports shared pieces.

- **Doc-comments are written in Russian** to match the existing codebase.

### Project layout

```text
lib/
├── api/           # Chopper/OpenAPI generated HTTP layer (do not edit)
├── di/            # get_it + injectable container
├── domain/        # plain Dart domain models
├── generated/     # generated LocaleKeys (do not edit)
├── navigation/    # go_router configuration (app_router.dart, AppRoutes)
├── res/           # design tokens (colour, style, icons)
├── service/       # injectable services grouped by concern
├── ui/
│   ├── screen/<feature>/   # bloc-or-cubit / view / model per screen
│   └── widget/             # app-wide shared widgets
├── util/          # helpers, DataState, bloc_ext
└── export.dart    # project-wide barrel
```

---

## Localisation

Localisation uses **easy_localization**. Translations live in `assets/translations/en.json` and `assets/translations/ru.json`, and keys are generated into `LocaleKeys` (`lib/generated/locale_keys.g.dart`). Both English and Russian are complete; the fallback locale is `ru`.

**No hardcoded user-facing strings** are allowed in the UI.

To add a string:

1. Add the **same key** to **both** `assets/translations/en.json` **and** `assets/translations/ru.json`.
2. Regenerate the keys:

   ```bash
   fvm dart run easy_localization:generate \
     -S assets/translations -O lib/generated -o locale_keys.g.dart -f keys
   ```

3. Use it in code:

   ```dart
   Text(LocaleKeys.someKey.tr())
   ```

---

## Testing

- **Unit and BLoC/Cubit tests** live in `test/unit/` and use `mocktail` + `bloc_test`:

  ```bash
  fvm flutter test
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

- [ ] Code is formatted: `fvm dart format -l 100 lib test`.
- [ ] Static analysis is clean: `fvm flutter analyze`.
- [ ] All tests pass: `fvm flutter test`.
- [ ] Generated code is regenerated if any `@injectable` / `@JsonSerializable` / Chopper annotation changed: `fvm dart run build_runner build --delete-conflicting-outputs`.
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

2. Open a pull request **against `develop`** on the upstream repository.

3. Fill in the PR description: what changed, why, and how it was tested. **Link the related issue** (e.g. `Closes #123`) so it is tracked and auto-closed on merge.

4. Ensure **CI is green.** The workflow at `.github/workflows/ci.yml` runs analyse + test, an Android dev APK build, and an unsigned iOS build.

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
