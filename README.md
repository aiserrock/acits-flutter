**English** · [Русский](docs/ru/README.md)

# acits_flutter

[![Flutter](https://img.shields.io/badge/Flutter-3.44-02569B?logo=flutter&logoColor=white)](https://flutter.dev)
[![Dart](https://img.shields.io/badge/Dart-3.12-0175C2?logo=dart&logoColor=white)](https://dart.dev)
[![License: MIT](https://img.shields.io/badge/License-MIT-green.svg)](LICENSE)

Flutter mobile client for [acits.ru](https://acits.ru/) — free and open-source software for tracking animals inside an animal shelter.

Shelter staff and curators keep a live registry of the animals in their care: medical prescriptions, schedules, adoption applicants, documents and photos. The app ships in `dev` and `prod` flavors and talks to the ACITS backend over a generated OpenAPI client.

## Tech stack

`flutter_bloc` (Cubit) · `go_router` · `easy_localization` · `get_it` + `injectable` · Chopper/Dio (OpenAPI) · Firebase · Patrol for e2e. Pinned to Flutter 3.44 / Dart 3.12 via [FVM](https://fvm.app).

## Quick start

```bash
git clone https://github.com/aiserrock/acits-flutter.git
cd acits-flutter
fvm install && fvm flutter pub get
fvm dart run build_runner build --delete-conflicting-outputs
fvm flutter run -t test/dev/main.dart --flavor dev
```

Firebase config files are gitignored — copy the `*.example` templates first (see [CONTRIBUTING.md](CONTRIBUTING.md#project-setup)).

## Documentation

- [Contributing guide](CONTRIBUTING.md) — setup, project structure, localization, testing, build and PR workflow.
- [Русская документация](docs/ru/README.md)

## License

Released under the [MIT License](LICENSE).
