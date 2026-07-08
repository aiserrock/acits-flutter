<div align="center">
  <a href="https://acits.ru/">
    <img src="../../assets/image/logo_native.png" alt="ACITS" width="360">
  </a>

  <p><strong>इसे अन्य भाषाओं में पढ़ें</strong></p>
  <p>
    <a href="../zh/README.md">🇨🇳 中文</a> ·
    <a href="../../README.md">🇬🇧 English</a> ·
    <a href="../es/README.md">🇪🇸 Español</a> ·
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

[acits.ru](https://acits.ru/) के लिए Flutter मोबाइल क्लाइंट — एक पशु आश्रय के भीतर जानवरों की ट्रैकिंग के लिए मुफ्त और ओपन-सोर्स सॉफ़्टवेयर।

आश्रय के कर्मचारी और क्यूरेटर अपनी देखरेख में मौजूद जानवरों की एक लाइव रजिस्ट्री रखते हैं: चिकित्सा नुस्खे, शेड्यूल, गोद लेने के आवेदक, दस्तावेज़ और तस्वीरें। ऐप `dev` और `prod` फ़्लेवर में उपलब्ध है और एक जनरेट किए गए OpenAPI क्लाइंट के ज़रिए ACITS बैकएंड से संवाद करता है।

## टेक स्टैक

`flutter_bloc` (Cubit) · `go_router` · `easy_localization` · `get_it` + `injectable` · Chopper/Dio (OpenAPI) · Firebase · e2e के लिए Patrol। [FVM](https://fvm.app) के ज़रिए Flutter 3.44 / Dart 3.12 पर पिन किया गया।

## क्विक स्टार्ट

```bash
git clone https://github.com/aiserrock/acits-flutter.git
cd acits-flutter
fvm install && fvm flutter pub get
fvm dart run build_runner build --delete-conflicting-outputs
fvm flutter run -t test/dev/main.dart --flavor dev
```

Firebase कॉन्फ़िग फ़ाइलें gitignored हैं — पहले `*.example` टेम्पलेट्स कॉपी करें (देखें [CONTRIBUTING.md](../../CONTRIBUTING.md#project-setup))।

## बिल्ड्स

CI पुल रिक्वेस्ट पर चलता है (lint, analyse, test, build) — `main`/`develop` में सीधा मर्ज कुछ भी ट्रिगर नहीं करता, क्योंकि उसे लाने वाला PR पहले ही पूरी पाइपलाइन से गुज़र चुका होता है।

`v*` टैग पुश करने पर (जैसे `v0.5.1`) Android/iOS/web बिल्ड होते हैं, dev APK के साथ एक [GitHub Release](https://github.com/aiserrock/acits-flutter/releases) पब्लिश होता है, `prod` वेब बिल्ड **[GitHub Pages](https://aiserrock.github.io/acits-flutter/)** पर डिप्लॉय होता है, और **[बिल्ड नोटिफिकेशन चैनल](https://t.me/acitsFlutterBuildNotifications)** पर Telegram पर एक बिल्ड नोटिफिकेशन पोस्ट होता है।

**[लाइव PWA](https://aiserrock.github.io/acits-flutter/)** — `prod` वेब बिल्ड, जिसे Progressive Web App के रूप में इंस्टॉल किया जा सकता है।

## दस्तावेज़ीकरण

- [योगदान गाइड](../../CONTRIBUTING.md) — सेटअप, प्रोजेक्ट संरचना, लोकलाइज़ेशन, टेस्टिंग, बिल्ड और PR वर्कफ़्लो।
- [Wiki](https://github.com/aiserrock/acits-flutter/wiki) — आर्किटेक्चर नोट्स, फ़्लेवर, और CI पाइपलाइन विवरण।
- [सुरक्षा नीति](../../SECURITY.md) — समर्थित वर्ज़न और भेद्यता की रिपोर्ट कैसे करें।
- [आचार संहिता](../../CODE_OF_CONDUCT.md)

## समुदाय

- [Discussions](https://github.com/aiserrock/acits-flutter/discussions) — प्रश्न, विचार, और सामान्य चर्चा।
- [Issues](https://github.com/aiserrock/acits-flutter/issues) — बग रिपोर्ट और फ़ीचर अनुरोध।
- Telegram पर [बिल्ड नोटिफिकेशन](https://t.me/acitsFlutterBuildNotifications)।

योगदान का स्वागत है — पुल रिक्वेस्ट खोलने से पहले [CONTRIBUTING.md](../../CONTRIBUTING.md) देखें।

## लाइसेंस

[MIT लाइसेंस](../../LICENSE) के तहत जारी किया गया।