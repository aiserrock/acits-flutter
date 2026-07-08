<div align="center">
  <a href="https://acits.ru/">
    <img src="../../assets/image/logo_native.png" alt="ACITS" width="360">
  </a>

  <p><strong>阅读其他语言版本</strong></p>
  <p>
    <a href="../../README.md">English</a> ·
    <a href="../hi/README.md">हिन्दी</a> ·
    <a href="../es/README.md">Español</a> ·
    <a href="../fr/README.md">Français</a> ·
    <a href="../ar/README.md">العربية</a> ·
    <a href="../ru/README.md">Русский</a>
  </p>

  [![CI](https://github.com/aiserrock/acits-flutter/actions/workflows/ci.yml/badge.svg?branch=develop)](https://github.com/aiserrock/acits-flutter/actions/workflows/ci.yml)
  [![Flutter](https://img.shields.io/badge/Flutter-3.44-02569B?logo=flutter&logoColor=white)](https://flutter.dev)
  [![Dart](https://img.shields.io/badge/Dart-3.12-0175C2?logo=dart&logoColor=white)](https://dart.dev)
  [![License: MIT](https://img.shields.io/badge/License-MIT-green.svg)](../../LICENSE)
  [![Telegram](https://img.shields.io/badge/Telegram-build_notifications-26A5E4?logo=telegram&logoColor=white)](https://t.me/acitsFlutterBuildNotifications)
</div>

# acits_flutter

[acits.ru](https://acits.ru/) 的 Flutter 移动客户端——用于动物收容所内动物追踪的免费开源软件。

收容所工作人员和管理员可以实时维护他们所照顾动物的档案：医疗处方、日程安排、领养申请、文档和照片。该应用提供 `dev` 和 `prod` 两种构建风味，并通过自动生成的 OpenAPI 客户端与 ACITS 后端通信。

## 技术栈

`flutter_bloc`（Cubit）· `go_router` · `easy_localization` · `get_it` + `injectable` · Chopper/Dio（OpenAPI）· Firebase · Patrol 用于端到端测试。通过 [FVM](https://fvm.app) 固定使用 Flutter 3.44 / Dart 3.12。

## 快速开始

```bash
git clone https://github.com/aiserrock/acits-flutter.git
cd acits-flutter
fvm install && fvm flutter pub get
fvm dart run build_runner build --delete-conflicting-outputs
fvm flutter run -t test/dev/main.dart --flavor dev
```

Firebase 配置文件已被 gitignore——请先复制 `*.example` 模板（详见 [CONTRIBUTING.md](../../CONTRIBUTING.md#project-setup)）。

## 构建

每次向 `main`/`develop` 推送都会运行完整流水线（lint、静态分析、测试、构建），并将构建通知——状态、版本号、更新日志以及运行链接——发送到 Telegram 上的 **[构建通知频道](https://t.me/acitsFlutterBuildNotifications)**。每次运行对应的已签名 APK/IPA 构建产物会附加在该次运行的 [GitHub Actions](https://github.com/aiserrock/acits-flutter/actions) 页面上（可从每条通知链接进入）。

## 文档

- [贡献指南](../../CONTRIBUTING.md) —— 环境搭建、项目结构、本地化、测试、构建与 PR 工作流。
- [Wiki](https://github.com/aiserrock/acits-flutter/wiki) —— 架构说明、构建风味以及 CI 流水线细节。
- [安全策略](../../SECURITY.md) —— 支持的版本以及如何报告漏洞。
- [行为准则](../../CODE_OF_CONDUCT.md)

## 社区

- [Discussions](https://github.com/aiserrock/acits-flutter/discussions) —— 提问、想法交流与日常讨论。
- [Issues](https://github.com/aiserrock/acits-flutter/issues) —— 缺陷报告与功能请求。
- [构建通知](https://t.me/acitsFlutterBuildNotifications) Telegram 频道。

欢迎贡献代码——在提交 PR 之前请先阅读 [CONTRIBUTING.md](../../CONTRIBUTING.md)。

## 许可证

基于 [MIT 许可证](../../LICENSE) 发布。