<div align="center">
  <a href="https://acits.ru/">
    <img src="../../assets/image/logo_native.png" alt="ACITS" width="360">
  </a>

  <p><strong>Lire ceci dans d'autres langues</strong></p>
  <p>
    <a href="../zh/README.md">🇨🇳 中文</a> ·
    <a href="../hi/README.md">🇮🇳 हिन्दी</a> ·
    <a href="../es/README.md">🇪🇸 Español</a> ·
    <a href="../../README.md">🇬🇧 English</a> ·
    <a href="../ar/README.md">🇸🇦 العربية</a> ·
    <a href="../ru/README.md">🇷🇺 Русский</a>
  </p>

  [![CI](https://github.com/aiserrock/acits-flutter/actions/workflows/ci.yml/badge.svg?branch=develop)](https://github.com/aiserrock/acits-flutter/actions/workflows/ci.yml)
  [![Flutter](https://img.shields.io/badge/Flutter-3.44-02569B?logo=flutter&logoColor=white)](https://flutter.dev)
  [![Dart](https://img.shields.io/badge/Dart-3.12-0175C2?logo=dart&logoColor=white)](https://dart.dev)
  [![License: MIT](https://img.shields.io/badge/License-MIT-green.svg)](../../LICENSE)
  [![Telegram](https://img.shields.io/badge/Telegram-build_notifications-26A5E4?logo=telegram&logoColor=white)](https://t.me/acitsFlutterBuildNotifications)
</div>

# acits_flutter

Client mobile Flutter pour [acits.ru](https://acits.ru/) — logiciel libre et open-source pour le suivi des animaux dans un refuge.

Le personnel du refuge et les curateurs tiennent un registre en temps réel des animaux dont ils ont la charge : prescriptions médicales, plannings, candidats à l'adoption, documents et photos. L'application est livrée en variantes `dev` et `prod` et communique avec le backend ACITS via un client OpenAPI généré.

## Stack technique

`flutter_bloc` (Cubit) · `go_router` · `easy_localization` · `get_it` + `injectable` · Chopper/Dio (OpenAPI) · Firebase · Patrol pour les tests e2e. Épinglé sur Flutter 3.44 / Dart 3.12 via [FVM](https://fvm.app).

## Démarrage rapide

```bash
git clone https://github.com/aiserrock/acits-flutter.git
cd acits-flutter
fvm install && fvm flutter pub get
fvm dart run build_runner build --delete-conflicting-outputs
fvm flutter run -t test/dev/main.dart --flavor dev
```

Les fichiers de configuration Firebase sont exclus de git — copiez d'abord les modèles `*.example` (voir [CONTRIBUTING.md](../../CONTRIBUTING.md#project-setup)).

## Builds

Chaque push sur `main`/`develop` déclenche le pipeline complet (lint, analyse, test, build) et publie une notification de build — statut, version, changelog et un lien vers l'exécution — sur le **[canal de notifications de build](https://t.me/acitsFlutterBuildNotifications)** sur Telegram. Les artefacts APK/IPA signés d'une exécution donnée sont joints à la page [GitHub Actions](https://github.com/aiserrock/acits-flutter/actions) de cette exécution (lien fourni dans chaque notification).

## Documentation

- [Guide de contribution](../../CONTRIBUTING.md) — configuration, structure du projet, localisation, tests, workflow de build et de PR.
- [Wiki](https://github.com/aiserrock/acits-flutter/wiki) — notes d'architecture, variantes et détails du pipeline CI.
- [Politique de sécurité](../../SECURITY.md) — versions prises en charge et comment signaler une vulnérabilité.
- [Code de conduite](../../CODE_OF_CONDUCT.md)

## Communauté

- [Discussions](https://github.com/aiserrock/acits-flutter/discussions) — questions, idées et discussions générales.
- [Issues](https://github.com/aiserrock/acits-flutter/issues) — rapports de bugs et demandes de fonctionnalités.
- [Notifications de build](https://t.me/acitsFlutterBuildNotifications) sur Telegram.

Les contributions sont les bienvenues — consultez [CONTRIBUTING.md](../../CONTRIBUTING.md) avant d'ouvrir une pull request.

## Licence

Publié sous [licence MIT](../../LICENSE).