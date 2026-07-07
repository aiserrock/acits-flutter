# Contributing to acits_flutter

Thank you for your interest in contributing to **acits_flutter** — the Flutter mobile client for [acits.ru](https://acits.ru/), free software for tracking animals inside an animal shelter (*бесплатное ПО для контроля за животными внутри приюта*).

This document describes how to set up your environment, the conventions we follow, and the process for submitting changes. Contributions of all kinds are welcome: bug reports, feature requests, documentation, and code.

## Code of Conduct

This project and everyone participating in it is governed by our [Code of Conduct](./CODE_OF_CONDUCT.md). By participating, you are expected to uphold it. Please report unacceptable behavior to the maintainers.

## Prerequisites

- **[FVM](https://fvm.app/)** (Flutter Version Management) — the project pins its toolchain via FVM.
- **Flutter 3.44.0 / Dart 3.12.0** — install through FVM so the pinned SDK is used:
  ```bash
  fvm install
  fvm use
  ```
- A working Android and/or iOS toolchain (Android Studio / Xcode) for building and running the app.

> **Always prefix Flutter/Dart commands with `fvm`** so the pinned SDK is used, e.g. `fvm flutter <cmd>` / `fvm dart <cmd>`.

## Local setup

1. **Fork** the repository on GitHub: [github.com/aiserrock/acits-flutter](https://github.com/aiserrock/acits-flutter).

2. **Clone** your fork and add the upstream remote:
   ```bash
   git clone git@github.com:<your-username>/acits-flutter.git
   cd acits-flutter
   git remote add upstream git@github.com:aiserrock/acits-flutter.git
   ```

3. **Install dependencies:**
   ```bash
   fvm flutter pub get
   ```

4. **Copy the secret / config templates.** Firebase configs, the release keystore, `key.properties`, and Charles debug `.pem` certificates are gitignored and **not** in the repo. Copy the provided `*.example` templates and supply your own values:
   ```bash
   # copy every provided template next to its real filename, then fill it in
   find . -name '*.example' -exec sh -c 'cp "$1" "${1%.example}"' _ {} \;
   ```
   You are responsible for supplying your own:
   - Firebase configs — `android/app/google-services.json`, `ios/Runner/GoogleService-Info.plist`
   - Release signing — `android/key.properties` and the release keystore
   - Charles debug certificates — the `.pem` files (only needed for HTTPS debugging)

   The Android debug keystore (`android/keystore/test.keystore`) is also gitignored — generate your own if needed for local debug builds.

5. **Generate code** (Injectable DI, JsonSerializable, Chopper, flutter_gen, Swagger OpenAPI):
   ```bash
   fvm flutter pub run build_runner build --delete-conflicting-outputs
   ```

6. **Generate localizations** (source: `lib/l10n/intl_ru.arb`, generated class `StringRes`):
   ```bash
   fvm flutter pub run intl_utils:generate
   ```

7. **Run the app.** The project ships two flavors with distinct entry points:
   ```bash
   # dev flavor
   fvm flutter run -t test/dev/main.dart --flavor dev

   # prod flavor
   fvm flutter run -t lib/main.dart --flavor prod
   ```

## Branching model

We follow **git-flow**:

- **`main`** — stable / release branch. Always deployable. Do not target this branch directly with PRs.
- **`develop`** — the integration branch. **All contributions target `develop`.**
- **Feature branches** — branch off `develop`, named one of:
  - `feature/<short-desc>` — e.g. `feature/animal-photo-gallery`
  - `<ticket>-<desc>` — e.g. `ACITS-123-fix-login-crash`

Keep your branch up to date with upstream:
```bash
git fetch upstream
git checkout develop
git merge upstream/develop
git checkout -b feature/<short-desc>
```

## Commit message convention

We use **[Conventional Commits](https://www.conventionalcommits.org/)**. Prefix each commit with a type:

| Type | Use for |
| --- | --- |
| `feat` | A new feature |
| `fix` | A bug fix |
| `chore` | Build process, tooling, dependency, or maintenance changes |
| `docs` | Documentation only |
| `refactor` | Code change that neither fixes a bug nor adds a feature |
| `test` | Adding or correcting tests |

Format:
```
<type>(<optional scope>): <short summary>

<optional body>

<optional footer, e.g. "Closes #123">
```

Examples:
```
feat(animals): add photo gallery to animal detail screen
fix(auth): handle expired token on cold start
docs: document FVM setup in CONTRIBUTING
```

## Pre-PR checklist (mandatory)

Before opening a pull request, **all** of the following must pass locally:

1. **Regenerate code if annotations changed** (any `@injectable`, `@JsonSerializable`, Chopper-annotated class, or `doc/api/` swagger change):
   ```bash
   fvm flutter pub run build_runner build --delete-conflicting-outputs
   ```
   If you edited `lib/l10n/intl_*.arb`, also run:
   ```bash
   fvm flutter pub run intl_utils:generate
   ```

2. **Format** (line length is **100**, not the Dart default 80):
   ```bash
   fvm flutter format -l 100 .
   ```

3. **Analyze** — must be **clean** (no warnings or errors):
   ```bash
   fvm flutter analyze .
   ```

4. **Test** — must be **green**:
   ```bash
   fvm flutter test
   ```

Commit any regenerated files — the generated files committed to the repo are the source of truth for the analyzer.

## Coding standards

- **Line length is 100.** Run `fvm flutter format -l 100 .` before committing. `flutter_gen` and `flutter_intl` are also configured to 100.
- **No hardcoded user-facing strings in UI.** Add the string to `lib/l10n/intl_ru.arb`, regenerate with `intl_utils:generate`, and access it via `StringRes.of(context).<key>`.
- **Sealed BLoC events and states** are attached to the bloc file via `part` / `part of`. Use `flutter_bloc + formz + equatable`. **Never use `freezed`** for BLoC events/states.
- **DTOs use `@JsonSerializable`** (with `part '<name>.g.dart';`). **Never use `freezed`** for DTOs. Generated networking (Chopper + Dio from OpenAPI in `doc/api/` → `lib/api/`) is not hand-edited.
- **BLoCs pull dependencies from `getIt`** in the constructor body and are provided via `BlocProvider` at the screen widget. Do not register BLoCs in DI.
- **Storage goes through the wrappers** in `service/secure_storage/` and `service/shared_pref/` — don't call `SharedPreferences.getInstance()` or `flutter_secure_storage` directly from features.
- **Prefer `package:acits_flutter/...` absolute imports** over relative ones, and use the per-feature **barrel files** (`<feature>.dart` re-exporting `bloc` / `view` / `model`) and the project-wide `export.dart` barrel.
- **Doc-comments in Russian**, to match the existing codebase.
- Follow the existing `lib/` layout: `api/` (generated), `di/`, `domain/` (plain Dart models), `service/`, `ui/screen/<feature>/` (`bloc/` + `view/` + `model/` + barrel), `ui/widget/`, `res/` (design tokens), `util/`.

## Pull request process

1. Push your feature branch to your fork.
2. Open a pull request **against `develop`** (never against `main`).
3. Fill out the **PR template** completely.
4. **Link the related issue** (e.g. `Closes #123`) so it is tracked and auto-closed on merge.
5. Ensure the entire [pre-PR checklist](#pre-pr-checklist-mandatory) passes and CI is green.
6. Address review feedback by pushing additional commits to the same branch.

A maintainer will review your PR. Keep PRs focused and reasonably small — smaller PRs are reviewed and merged faster.

## Reporting bugs and requesting features

Please use our [issue templates](https://github.com/aiserrock/acits-flutter/issues/new/choose):

- **Bug report** — include steps to reproduce, expected vs. actual behavior, device/OS, flavor (dev/prod), and logs or screenshots where relevant.
- **Feature request** — describe the problem you're trying to solve and the proposed solution.

Before opening a new issue, please search [existing issues](https://github.com/aiserrock/acits-flutter/issues) to avoid duplicates. For security-sensitive reports, contact the maintainers privately rather than filing a public issue.

## License

By contributing, you agree that your contributions will be licensed under the project's [MIT License](./LICENSE) (© 2026 aiserrock).
