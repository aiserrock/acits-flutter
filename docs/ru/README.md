[English](../../README.md) · **Русский**

# acits_flutter

[![Flutter](https://img.shields.io/badge/Flutter-3.44-02569B?logo=flutter&logoColor=white)](https://flutter.dev)
[![Dart](https://img.shields.io/badge/Dart-3.12-0175C2?logo=dart&logoColor=white)](https://dart.dev)
[![License: MIT](https://img.shields.io/badge/License-MIT-green.svg)](../../LICENSE)

Мобильный Flutter-клиент для [acits.ru](https://acits.ru/) — бесплатное ПО с открытым исходным кодом для учёта животных внутри приюта.

Сотрудники приюта и кураторы ведут актуальный реестр животных: медицинские назначения, расписание, заявители на усыновление, документы и фотографии. Приложение поставляется в флейворах `dev` и `prod` и работает с бэкендом ACITS через сгенерированный OpenAPI-клиент.

## Стек

`flutter_bloc` (Cubit) · `go_router` · `easy_localization` · `get_it` + `injectable` · Chopper/Dio (OpenAPI) · Firebase · Patrol для e2e. Зафиксирован на Flutter 3.44 / Dart 3.12 через [FVM](https://fvm.app).

## Быстрый старт

```bash
git clone https://github.com/aiserrock/acits-flutter.git
cd acits-flutter
fvm install && fvm flutter pub get
fvm dart run build_runner build --delete-conflicting-outputs
fvm flutter run -t test/dev/main.dart --flavor dev
```

Файлы конфигурации Firebase не хранятся в репозитории — сначала скопируйте шаблоны `*.example` (см. [CONTRIBUTING.md](CONTRIBUTING.md#project-setup)).

## Документация

- [Руководство контрибьютора](CONTRIBUTING.md) — установка, структура проекта, локализация, тесты, сборка и процесс PR.
- [English documentation](../../README.md)

## Лицензия

Распространяется под лицензией [MIT](../../LICENSE).
