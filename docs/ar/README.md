<div align="center">
  <a href="https://acits.ru/">
    <img src="../../assets/image/logo_native.png" alt="ACITS" width="360">
  </a>

  <p><strong>اقرأ هذا بلغات أخرى</strong></p>
  <p>
    <a href="../zh/README.md">中文</a> ·
    <a href="../hi/README.md">हिन्दी</a> ·
    <a href="../es/README.md">Español</a> ·
    <a href="../fr/README.md">Français</a> ·
    <a href="../../README.md">English</a> ·
    <a href="../ru/README.md">Русский</a>
  </p>

  [![CI](https://github.com/aiserrock/acits-flutter/actions/workflows/ci.yml/badge.svg?branch=develop)](https://github.com/aiserrock/acits-flutter/actions/workflows/ci.yml)
  [![Flutter](https://img.shields.io/badge/Flutter-3.44-02569B?logo=flutter&logoColor=white)](https://flutter.dev)
  [![Dart](https://img.shields.io/badge/Dart-3.12-0175C2?logo=dart&logoColor=white)](https://dart.dev)
  [![License: MIT](https://img.shields.io/badge/License-MIT-green.svg)](../../LICENSE)
  [![Telegram](https://img.shields.io/badge/Telegram-build_notifications-26A5E4?logo=telegram&logoColor=white)](https://t.me/acitsFlutterBuildNotifications)
</div>

# acits_flutter

عميل Flutter لتطبيق [acits.ru](https://acits.ru/) — برنامج مجاني ومفتوح المصدر لتتبع الحيوانات داخل ملجأ الحيوانات.

يحتفظ موظفو الملجأ والمشرفون بسجل حي للحيوانات الموجودة تحت رعايتهم: الوصفات الطبية، الجداول الزمنية، طلبات التبني، المستندات والصور. يأتي التطبيق بنسختين `dev` و`prod` ويتواصل مع خادم ACITS عبر عميل OpenAPI مُولَّد.

## حزمة التقنيات

`flutter_bloc` (Cubit) · `go_router` · `easy_localization` · `get_it` + `injectable` · Chopper/Dio (OpenAPI) · Firebase · Patrol للاختبارات الشاملة (e2e). مثبّت على إصدار Flutter 3.44 / Dart 3.12 عبر [FVM](https://fvm.app).

## البدء السريع

```bash
git clone https://github.com/aiserrock/acits-flutter.git
cd acits-flutter
fvm install && fvm flutter pub get
fvm dart run build_runner build --delete-conflicting-outputs
fvm flutter run -t test/dev/main.dart --flavor dev
```

ملفات إعداد Firebase مستثناة من git — انسخ قوالب `*.example` أولاً (راجع [CONTRIBUTING.md](../../CONTRIBUTING.md#project-setup)).

## البنى (Builds)

كل دفعة (push) إلى `main`/`develop` تُشغّل خط الأنابيب الكامل (lint، analyse، test، build) وتنشر إشعار بناء — الحالة، الإصدار، سجل التغييرات، ورابط للتشغيل — إلى **[قناة إشعارات البناء](https://t.me/acitsFlutterBuildNotifications)** على Telegram. تُرفق حزم APK/IPA الموقّعة لكل تشغيل بصفحة [GitHub Actions](https://github.com/aiserrock/acits-flutter/actions) الخاصة بذلك التشغيل (مرتبطة من كل إشعار).

## التوثيق

- [دليل المساهمة](../../CONTRIBUTING.md) — الإعداد، هيكل المشروع، الترجمة، الاختبار، سير عمل البناء وطلبات السحب (PR).
- [الويكي](https://github.com/aiserrock/acits-flutter/wiki) — ملاحظات حول البنية المعمارية، النسخ (flavors)، وتفاصيل خط أنابيب CI.
- [سياسة الأمان](../../SECURITY.md) — الإصدارات المدعومة وكيفية الإبلاغ عن ثغرة أمنية.
- [ميثاق السلوك](../../CODE_OF_CONDUCT.md)

## المجتمع

- [النقاشات](https://github.com/aiserrock/acits-flutter/discussions) — الأسئلة، الأفكار، والدردشة العامة.
- [المشكلات](https://github.com/aiserrock/acits-flutter/issues) — تقارير الأخطاء وطلبات الميزات.
- [إشعارات البناء](https://t.me/acitsFlutterBuildNotifications) على Telegram.

المساهمات مرحّب بها — راجع [CONTRIBUTING.md](../../CONTRIBUTING.md) قبل فتح طلب سحب (pull request).

## الترخيص

منشور بموجب [رخصة MIT](../../LICENSE).