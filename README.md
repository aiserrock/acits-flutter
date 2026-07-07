# acits_flutter

> Мобильный клиент Flutter для [Acits](https://acits.ru/) — бесплатного ПО для контроля за животными внутри приюта.

Flutter mobile client for [acits.ru](https://acits.ru/) — free software for tracking and managing animals inside an animal shelter.

![Flutter](https://img.shields.io/badge/Flutter-3.44-02569B?logo=flutter&logoColor=white)
![Dart](https://img.shields.io/badge/Dart-3.12-0175C2?logo=dart&logoColor=white)
![License: MIT](https://img.shields.io/badge/License-MIT-green.svg)
![Style: flutter_lints](https://img.shields.io/badge/style-flutter__lints-40c4ff.svg)

## About

**acits_flutter** is the mobile client for the Acits platform — free, open-source software that helps animal shelters keep track of the animals in their care. The app lets shelter staff and curators manage an animal registry, record prescriptions and drug executions, coordinate applicants and adoptions, browse documents and photos, and stay on top of scheduled tasks through a built-in calendar.

The project is a single-package Flutter application built with **flutter_bloc** for state management, a **Chopper + Dio** networking layer generated from an OpenAPI specification, and **get_it + injectable** for dependency injection. The toolchain is pinned via **FVM** to Flutter 3.44.0 / Dart 3.12.0.

## Features

- **Animals registry** — browse, search, view, create, and edit animal records.
- **Prescriptions** — manage medical prescriptions per animal.
- **Calendar & executions** — track scheduled drug executions and tasks over time.
- **Drugs catalog** — reference and assign medications.
- **Applicants** — handle adoption applicants and their requests.
- **Curators** — manage curator profiles tied to animals.
- **Document viewer** — open and read attached documents in-app.
- **Photo gallery** — view animal photos in a dedicated gallery.
- **Comments** — collaborate through per-record comments.
- **Onboarding** — first-launch introduction flow.
- **Authentication** — login and registration with secure token storage.
- **Personal screen** — manage the current user's account and settings.

## Tech Stack

| Concern | Choice |
| --- | --- |
| Framework | Flutter 3.44.0 |
| Language | Dart 3.12.0 |
| SDK manager | FVM (pinned toolchain) |
| State management | `flutter_bloc` + `formz` + `equatable` |
| Networking | `chopper` + `dio` (generated from OpenAPI) |
| Serialization | `json_serializable` (`@JsonSerializable` DTOs) |
| Dependency injection | `get_it` + `injectable` |
| Secure storage | `flutter_secure_storage` |
| Key-value storage | `shared_preferences` (wrapped) |
| Backend services | Firebase Core |
| Localization | `intl` / `intl_utils` (ARB source) |
| Assets codegen | `flutter_gen` |
| Linting | `flutter_lints` |

## Getting Started

### Prerequisites

- [FVM](https://fvm.app/) (Flutter Version Management)
- Flutter **3.44.0** / Dart **3.12.0** (installed and used through FVM)

> All Flutter and Dart commands **must** be prefixed with `fvm` so the pinned SDK is used.

### Install

```bash
# Clone the repository
git clone https://github.com/aiserrock/acits-flutter.git
cd acits-flutter

# Install the pinned Flutter SDK
fvm install

# Fetch dependencies
fvm flutter pub get

# Run code generation (DI, JSON, Chopper, assets, OpenAPI)
fvm flutter pub run build_runner build --delete-conflicting-outputs
```

### Secrets setup

Sensitive files are **gitignored** and are not part of the repository. Before building, copy the provided `*.example` templates and supply your own values:

- **Firebase** — provide your own `google-services.json` (Android) and `GoogleService-Info.plist` (iOS).
- **Release signing** — provide your own release keystore and `key.properties`.
- **Debug keystore** — `android/keystore/test.keystore` is gitignored; supply your own debug keystore.
- **Charles debug certificates** — provide your own `.pem` certificates if you need proxy debugging.

Copy each `*.example` file to its real name and fill in the required values, then adjust the paths to match the templates present in your checkout:

```bash
cp android/app/google-services.json.example android/app/google-services.json
cp android/key.properties.example android/key.properties
```

## Running

The project defines two flavors, each with its own entry point:

- **dev** — entry `test/dev/main.dart`
- **prod** — entry `lib/main.dart`

```bash
# Run the dev flavor
fvm flutter run -t test/dev/main.dart --flavor dev

# Run the prod flavor
fvm flutter run -t lib/main.dart --flavor prod
```

## Project Structure

```text
lib/
├── api/          # Swagger/OpenAPI-generated HTTP layer (Chopper) — generated, do not edit
├── di/           # get_it + injectable container (initDi())
├── domain/       # Plain Dart domain models & enums
├── service/      # Injectable services (auth, animal, client, config, ...)
├── ui/
│   ├── screen/   # One folder per feature: bloc/ + view/ + model/ + barrel
│   └── widget/   # App-wide shared widgets
├── res/          # Design tokens (color, style, icon, lottie, strings)
├── gen/          # flutter_gen output (assets, fonts) — generated
├── generated/    # intl output (StringRes) — generated
├── l10n/         # Source .arb files (intl_ru.arb is the template)
├── util/         # Generic helpers
├── export.dart   # Project-wide barrel
└── main.dart     # Prod entry point (dev entry: test/dev/main.dart)
```

Each screen under `ui/screen/<feature>/` follows the same convention:

```text
ui/screen/<feature>/
├── bloc/         # <name>_bloc.dart with part '<name>_event.dart' / '<name>_state.dart'
├── view/         # Screen widgets (often with a view.dart barrel)
├── model/        # Screen-local models (often with a model.dart barrel)
└── <feature>.dart  # Barrel re-exporting bloc / view / model
```

## Code Generation

Run the build runner after changing any `@injectable`, `@JsonSerializable`, or Chopper-annotated class, or after editing the OpenAPI spec in `doc/api/`:

```bash
fvm flutter pub run build_runner build --delete-conflicting-outputs
```

The generated files committed to the repo are the source of truth for the analyzer.

## Localization

Source strings live in `lib/l10n/intl_*.arb` (with `intl_ru.arb` as the template). After editing them, regenerate the `StringRes` class:

```bash
fvm flutter pub run intl_utils:generate
fvm flutter format -l 100 .
```

Access translations via `StringRes.of(context)` / `S.of(context)`.

> **No hardcoded user-facing strings** — add them to `lib/l10n/intl_ru.arb`, regenerate, and read them through `StringRes`.

## Testing

```bash
# Run all unit / widget tests
fvm flutter test

# Run a single test file
fvm flutter test test/path/to/foo_test.dart

# Run tests matching a description
fvm flutter test --name "description substring"
```

### Formatting & analysis

The project uses a **100-character** line length (not the Dart default 80):

```bash
fvm flutter format -l 100 .
fvm flutter analyze .
```

## Building

Two flavors exist, `dev` and `prod`, with distinct entry points.

```bash
# Dev — APK
fvm flutter build apk -t test/dev/main.dart --flavor dev --release

# Prod — App Bundle (obfuscated, with split debug info)
fvm flutter build appbundle -t lib/main.dart --flavor prod --release \
  --obfuscate --split-debug-info=./build/app/outputs/symbols/prod
```

## Contributing

Contributions are welcome. This repository follows a git-flow branching model: `develop` is the integration branch and `main` holds released code. Branch off `develop`, and open your pull request against `develop`.

## License

This project is licensed under the [MIT License](LICENSE) — © 2026 aiserrock.
