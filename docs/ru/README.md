<div align="center">
  <a href="https://acits.ru/">
    <img src="../../assets/image/logo_native.png" alt="ACITS" width="360">
  </a>

  <p><strong>Читать на других языках</strong></p>
  <p>
    <a href="../zh/README.md">🇨🇳 中文</a> ·
    <a href="../hi/README.md">🇮🇳 हिन्दी</a> ·
    <a href="../es/README.md">🇪🇸 Español</a> ·
    <a href="../fr/README.md">🇫🇷 Français</a> ·
    <a href="../ar/README.md">🇸🇦 العربية</a> ·
    <a href="../../README.md">🇬🇧 English</a>
  </p>

  [![CI](https://github.com/aiserrock/acits-flutter/actions/workflows/ci.yml/badge.svg?event=pull_request)](https://github.com/aiserrock/acits-flutter/actions/workflows/ci.yml)
  [![Flutter](https://img.shields.io/badge/Flutter-3.44-02569B?logo=flutter&logoColor=white)](https://flutter.dev)
  [![Dart](https://img.shields.io/badge/Dart-3.12-0175C2?logo=dart&logoColor=white)](https://dart.dev)
  [![License: MIT](https://img.shields.io/badge/License-MIT-green.svg)](../../LICENSE)
  [![Telegram](https://img.shields.io/badge/Telegram-build_notifications-26A5E4?logo=telegram&logoColor=white)](https://t.me/acitsFlutterBuildNotifications)
</div>

# acits_flutter

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

## Сборки

CI запускается на пул-реквестах (lint, analyse, test, build) — обычный мёрдж в `main`/`develop` ничего не запускает, потому что PR, из которого он пришёл, уже прошёл весь пайплайн.

Push тега `v*` (например, `v0.5.1`) собирает Android/iOS/web, публикует [GitHub Release](https://github.com/aiserrock/acits-flutter/releases) с прикреплённым dev APK, деплоит `prod` веб-сборку на **[GitHub Pages](https://aiserrock.github.io/acits-flutter/)** и публикует уведомление о сборке в **[канал уведомлений о сборках](https://t.me/acitsFlutterBuildNotifications)** в Telegram.

**[Живой PWA](https://aiserrock.github.io/acits-flutter/)** — `prod`-сборка веб-версии, устанавливается как Progressive Web App.

## Документация

- [Руководство контрибьютора](CONTRIBUTING.md) — установка, структура проекта, локализация, тесты, сборка и процесс PR.
- [Wiki](https://github.com/aiserrock/acits-flutter/wiki) — заметки об архитектуре, флейворах и деталях CI-пайплайна.
- [Политика безопасности](../../SECURITY.md) — поддерживаемые версии и как сообщить об уязвимости.
- [Кодекс поведения](../../CODE_OF_CONDUCT.md)
- [English documentation](../../README.md)

## Сообщество

- [Discussions](https://github.com/aiserrock/acits-flutter/discussions) — вопросы, идеи и обсуждения.
- [Issues](https://github.com/aiserrock/acits-flutter/issues) — баг-репорты и предложения фич.
- [Уведомления о сборках](https://t.me/acitsFlutterBuildNotifications) в Telegram.

Контрибьюции приветствуются — ознакомьтесь с [CONTRIBUTING.md](CONTRIBUTING.md) перед открытием pull request.

## Лицензия

Распространяется под лицензией [MIT](../../LICENSE).
