**English** · [Русский](docs/ru/README.md)

# acits_flutter

[![Flutter](https://img.shields.io/badge/Flutter-3.44-02569B?logo=flutter&logoColor=white)](https://flutter.dev)
[![Dart](https://img.shields.io/badge/Dart-3.12-0175C2?logo=dart&logoColor=white)](https://dart.dev)
[![License: MIT](https://img.shields.io/badge/License-MIT-green.svg)](LICENSE)

Flutter mobile client for [acits.ru](https://acits.ru/) — free and open-source software for tracking animals inside an animal shelter.

## About

`acits_flutter` is the mobile front-end of the ACITS platform. It helps shelter staff and curators keep a live registry of the animals in their care: medical prescriptions, schedules, adoption applicants, supporting documents and photos. The app is built for both `dev` and `prod` environments and talks to the ACITS backend over a generated OpenAPI client.

## Features

- **Animals registry** — browse, search, create and edit animal records.
- **Prescriptions** — track medical prescriptions and drugs per animal.
- **Calendar** — schedule and view upcoming care events.
- **Applicants** — manage adoption applicants.
- **Curators** — assign and manage the people responsible for each animal.
- **Documents** — attach and view supporting documents.
- **Photo gallery** — per-animal photo galleries.
- **Onboarding** — first-launch introduction flow.
- **Authentication** — secure sign-in with token storage.

## Tech Stack

| Concern | Choice |
| --- | --- |
| Toolchain | Flutter 3.44.0 / Dart 3.12.0, pinned via [FVM](https://fvm.app) (`.fvmrc`) |
| State management | `flutter_bloc` **Cubit** with a sealed `DataState<T>` + `DataStateBuilder`, `safeEmit`, `formz`, `equatable` |
| Navigation | [`go_router`](https://pub.dev/packages/go_router) — `AppRoutes` constants, objects passed via `extra` + `AppExtraCodec` |
| Localization | [`easy_localization`](https://pub.dev/packages/easy_localization) — JSON translations, generated `LocaleKeys` |
| Dependency injection | `get_it` + `injectable` 3 |
| Networking | Chopper + Dio, generated from OpenAPI (`doc/api/`) into `lib/api/` |
| Storage | `flutter_secure_storage` + `shared_preferences` (wrapped in `lib/service/`) |
| Firebase | `firebase_core` (config files are gitignored — copy the `*.example` templates) |
| Testing | Unit/bloc: `mocktail` + `bloc_test`; e2e: [Patrol](https://patrol.leancode.co) |
| CI | GitHub Actions (`.github/workflows/ci.yml`) — analyse + test, build Android (dev APK), build iOS (unsigned) |

## Getting Started

### Prerequisites

- [FVM](https://fvm.app) (Flutter Version Management)

Clone the repository, install the pinned Flutter version and fetch dependencies:

```bash
git clone https://github.com/aiserrock/acits-flutter.git
cd acits-flutter

fvm install
fvm flutter pub get
```

### Firebase configuration

Firebase config files are gitignored. Copy the provided templates and fill in your own values:

```bash
cp android/app/src/dev/google-services.json.example  android/app/src/dev/google-services.json
cp android/app/src/prod/google-services.json.example android/app/src/prod/google-services.json
cp ios/Runner/GoogleService-Info.plist.example       ios/Runner/GoogleService-Info.plist
cp android/keystore/key.properties.example           android/keystore/key.properties
```

### Code generation

Generate DI, JSON serialisation, the OpenAPI client and other build outputs:

```bash
fvm dart run build_runner build --delete-conflicting-outputs
```

Rerun this after changing any `@injectable`, JSON-serialisable or Chopper-annotated class, or after touching the OpenAPI spec in `doc/api/`.

## Running

Two flavors exist, each with its own entry point.

```bash
# dev
fvm flutter run -t test/dev/main.dart --flavor dev

# prod
fvm flutter run -t lib/main.dart --flavor prod
```

## Project Structure

```text
lib/
├── api/           # Chopper/Dio OpenAPI-generated HTTP layer (generated — do not edit)
├── di/            # get_it + injectable container (initDi())
├── domain/        # plain Dart domain models & enums
├── generated/     # easy_localization LocaleKeys (generated)
├── l10n/          # localization helpers
├── navigation/    # go_router: app_router.dart (AppRoutes), extra_codec.dart
├── res/           # design tokens: color, style, icon, lottie, strings
├── service/       # injectable services (auth, animal, document, storage, …)
├── ui/
│   ├── screen/    # one folder per feature (cubit/bloc · view · model)
│   └── widget/    # app-wide shared widgets
├── util/          # data_state.dart, bloc_ext.dart, validators, helpers
├── export.dart    # project-wide barrel
└── main.dart      # prod entry point (dev entry: test/dev/main.dart)
```

## Localization

The app uses `easy_localization`. Translations live in `assets/translations/en.json` and `assets/translations/ru.json` (both are full); keys are generated as `LocaleKeys`. There are **no hardcoded UI strings** — every user-facing string goes through a key.

To add a string:

1. Add the key to **both** `assets/translations/en.json` and `assets/translations/ru.json`.
2. Regenerate the keys:

   ```bash
   fvm dart run easy_localization:generate \
     -S assets/translations -O lib/generated -o locale_keys.g.dart -f keys
   ```

3. Use it in the UI:

   ```dart
   Text(LocaleKeys.someKey.tr())
   ```

## Testing

Unit and bloc tests (`mocktail` + `bloc_test`) live in `test/unit/`:

```bash
fvm flutter test
```

End-to-end tests use [Patrol](https://patrol.leancode.co) and live in `integration_test/` (configured in the `patrol:` block of `pubspec.yaml`):

```bash
patrol test --flavor dev
```

## Building

```bash
# dev — Android APK
fvm flutter build apk -t test/dev/main.dart --flavor dev --release

# prod — Android App Bundle
fvm flutter build appbundle -t lib/main.dart --flavor prod --release

# prod — iOS
fvm flutter build ios -t lib/main.dart --flavor prod --release
```

### Formatting & analysis

Line length is **100** (not the Dart default of 80):

```bash
fvm dart format -l 100 lib test
fvm flutter analyze
```

## Contributing

Contributions are welcome. Please read [CONTRIBUTING.md](CONTRIBUTING.md) before opening a pull request.

## License

Released under the [MIT License](LICENSE).
