<div align="center">
  <a href="https://acits.ru/">
    <img src="../../assets/image/logo_native.png" alt="ACITS" width="360">
  </a>

  <p><strong>Lee esto en otros idiomas</strong></p>
  <p>
    <a href="../zh/README.md">🇨🇳 中文</a> ·
    <a href="../hi/README.md">🇮🇳 हिन्दी</a> ·
    <a href="../../README.md">🇬🇧 English</a> ·
    <a href="../fr/README.md">🇫🇷 Français</a> ·
    <a href="../ar/README.md">🇸🇦 العربية</a> ·
    <a href="../ru/README.md">🇷🇺 Русский</a>
  </p>

  [![CI](https://github.com/aiserrock/acits-flutter/actions/workflows/ci.yml/badge.svg?event=pull_request)](https://github.com/aiserrock/acits-flutter/actions/workflows/ci.yml)
  [![Flutter](https://img.shields.io/badge/Flutter-3.44-02569B?logo=flutter&logoColor=white)](https://flutter.dev)
  [![Dart](https://img.shields.io/badge/Dart-3.12-0175C2?logo=dart&logoColor=white)](https://dart.dev)
  [![License: MIT](https://img.shields.io/badge/License-MIT-green.svg)](../../LICENSE)
  [![Telegram](https://img.shields.io/badge/Telegram-build_notifications-26A5E4?logo=telegram&logoColor=white)](https://t.me/acitsFlutterBuildNotifications)
</div>

# acits_flutter

Cliente móvil Flutter para [acits.ru](https://acits.ru/) — software libre y de código abierto para el registro de animales dentro de un refugio.

El personal del refugio y los curadores mantienen un registro en vivo de los animales a su cuidado: prescripciones médicas, horarios, solicitantes de adopción, documentos y fotos. La app se distribuye en los sabores (`flavors`) `dev` y `prod` y se comunica con el backend de ACITS a través de un cliente OpenAPI generado.

## Stack tecnológico

`flutter_bloc` (Cubit) · `go_router` · `easy_localization` · `get_it` + `injectable` · Chopper/Dio (OpenAPI) · Firebase · Patrol para e2e. Fijado a Flutter 3.44 / Dart 3.12 mediante [FVM](https://fvm.app).

## Inicio rápido

```bash
git clone https://github.com/aiserrock/acits-flutter.git
cd acits-flutter
fvm install && fvm flutter pub get
fvm dart run build_runner build --delete-conflicting-outputs
fvm flutter run -t test/dev/main.dart --flavor dev
```

Los archivos de configuración de Firebase están excluidos del repositorio (gitignored) — copia primero las plantillas `*.example` (ver [CONTRIBUTING.md](../../CONTRIBUTING.md#project-setup)).

## Compilaciones

El CI se ejecuta en los pull requests (lint, análisis, tests, build) — un simple merge a `main`/`develop` no dispara nada, porque el PR que lo trajo ya pasó por el pipeline completo.

Al hacer push de una etiqueta `v*` (por ejemplo `v0.5.1`) se compilan Android/iOS/web, se publica una [GitHub Release](https://github.com/aiserrock/acits-flutter/releases) con el APK de dev adjunto, se despliega la compilación web `prod` a **[GitHub Pages](https://aiserrock.github.io/acits-flutter/)** y se publica una notificación de compilación en el **[canal de notificaciones de compilación](https://t.me/acitsFlutterBuildNotifications)** de Telegram.

**[PWA en vivo](https://aiserrock.github.io/acits-flutter/)** — la compilación web `prod`, instalable como Progressive Web App.

## Documentación

- [Guía de contribución](../../CONTRIBUTING.md) — instalación, estructura del proyecto, localización, tests, compilación y flujo de trabajo de PR.
- [Wiki](https://github.com/aiserrock/acits-flutter/wiki) — notas de arquitectura, sabores (flavors) y detalles del pipeline de CI.
- [Política de seguridad](../../SECURITY.md) — versiones soportadas y cómo reportar una vulnerabilidad.
- [Código de conducta](../../CODE_OF_CONDUCT.md)

## Comunidad

- [Discussions](https://github.com/aiserrock/acits-flutter/discussions) — preguntas, ideas y charla general.
- [Issues](https://github.com/aiserrock/acits-flutter/issues) — reportes de errores y solicitudes de funcionalidades.
- [Notificaciones de compilación](https://t.me/acitsFlutterBuildNotifications) en Telegram.

Las contribuciones son bienvenidas — consulta [CONTRIBUTING.md](../../CONTRIBUTING.md) antes de abrir un pull request.

## Licencia

Publicado bajo la [Licencia MIT](../../LICENSE).