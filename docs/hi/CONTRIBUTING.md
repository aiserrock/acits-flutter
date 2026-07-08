[English](../../CONTRIBUTING.md) · [中文](../zh/CONTRIBUTING.md) · **हिन्दी** · [Español](../es/CONTRIBUTING.md) · [Français](../fr/CONTRIBUTING.md) · [العربية](../ar/CONTRIBUTING.md) · [Русский](../ru/CONTRIBUTING.md)

# acits_flutter में योगदान देना

**acits_flutter** में योगदान देने में आपकी रुचि के लिए धन्यवाद — यह [acits.ru](https://acits.ru) के लिए Flutter मोबाइल क्लाइंट है, जो पशु आश्रय स्थलों के अंदर जानवरों को ट्रैक करने के लिए एक निःशुल्क और ओपन-सोर्स सॉफ़्टवेयर है।

यह प्रोजेक्ट **MIT लाइसेंस** के अंतर्गत लाइसेंस प्राप्त है। योगदान देकर, आप सहमत होते हैं कि आपके योगदान भी इन्हीं शर्तों के तहत लाइसेंस प्राप्त होंगे।

रिपॉज़िटरी: [github.com/aiserrock/acits-flutter](https://github.com/aiserrock/acits-flutter)

---

## विषय-सूची

- [पूर्वापेक्षाएँ](#prerequisites)
- [प्रोजेक्ट सेटअप](#project-setup)
- [ब्रांचिंग मॉडल](#branching-model)
- [कमिट संदेश](#commit-messages)
- [कोडिंग मानक](#coding-standards)
- [स्थानीयकरण](#localisation)
- [टेस्टिंग](#testing)
- [PR-पूर्व चेकलिस्ट](#pre-pr-checklist)
- [पुल रिक्वेस्ट खोलना](#opening-a-pull-request)
- [बग रिपोर्ट करना](#reporting-bugs)

---

## पूर्वापेक्षाएँ

टूलचेन को रिपॉज़िटरी रूट में मौजूद `.fvmrc` फ़ाइल के माध्यम से **FVM** (Flutter Version Management) से पिन किया गया है।

| टूल | संस्करण |
| --- | --- |
| Flutter | 3.44.0 |
| Dart | 3.12.0 |
| FVM | नवीनतम स्थिर संस्करण |

FVM और पिन की गई SDK इंस्टॉल करें:

```bash
dart pub global activate fvm
fvm install
```

Flutter और Dart कमांड्स के आगे हमेशा `fvm` लगाएँ ताकि पिन की गई SDK इस्तेमाल हो:

```bash
fvm flutter <command>
fvm dart <command>
```

ऐप को बिल्ड और रन करने के लिए एक कार्यशील Android और/या iOS टूलचेन (Android Studio / Xcode) भी आवश्यक है।

---

## प्रोजेक्ट सेटअप

1. GitHub पर रिपॉज़िटरी को **फोर्क** करें और अपने फोर्क को **क्लोन** करें:

   ```bash
   git clone git@github.com:<your-username>/acits-flutter.git
   cd acits-flutter
   ```

2. **upstream remote जोड़ें** ताकि आप अपने फोर्क को सिंक में रख सकें:

   ```bash
   git remote add upstream git@github.com:aiserrock/acits-flutter.git
   ```

3. **डिपेंडेंसीज़ फ़ेच करें:**

   ```bash
   fvm flutter pub get
   ```

4. **उदाहरण कॉन्फ़िगरेशन टेम्पलेट्स कॉपी करें।** Firebase कॉन्फ़िगरेशन फ़ाइलें gitignore में हैं; `*.example` टेम्पलेट्स कॉपी करें और अपने खुद के क्रेडेंशियल्स भरें:

   ```bash
   # Android — प्रति-flavour, प्रत्येक flavour के लिए एक फ़ाइल:
   cp android/app/src/dev/google-services.json.example android/app/src/dev/google-services.json
   cp android/app/src/prod/google-services.json.example android/app/src/prod/google-services.json
   # iOS
   cp ios/Runner/GoogleService-Info.plist.example ios/Runner/GoogleService-Info.plist
   ```

   > `android/keystore/` के अंतर्गत `key.properties.example` भी उसी पैटर्न का पालन करती है, यदि आपको स्थानीय रूप से साइनिंग कॉन्फ़िगर करने की आवश्यकता हो।

5. **कोड जनरेट करें।** प्रोजेक्ट DI (injectable), JSON सीरियलाइज़ेशन, और Chopper के लिए कोड जनरेशन का उपयोग करता है:

   ```bash
   fvm dart run build_runner build --delete-conflicting-outputs
   ```

6. **ऐप चलाएँ।** दो flavours मौजूद हैं, प्रत्येक का अपना एंट्री पॉइंट है:

   ```bash
   # dev flavour
   fvm flutter run -t test/dev/main.dart --flavor dev

   # prod flavour
   fvm flutter run -t lib/main.dart --flavor prod
   ```

---

## ब्रांचिंग मॉडल

हम **git-flow** शैली के ब्रांचिंग मॉडल का पालन करते हैं:

| ब्रांच | उद्देश्य |
| --- | --- |
| `main` | स्थिर, रिलीज़-तैयार कोड। हमेशा डिप्लॉय करने योग्य। इसे सीधे PR से टारगेट न करें। |
| `develop` | इंटीग्रेशन ब्रांच जहाँ फ़ीचर वर्क आता है। सभी योगदान `develop` को टारगेट करते हैं। |
| `feature/*` | `develop` से ब्रांच किए गए व्यक्तिगत फ़ीचर्स और फ़िक्स। |

अपनी ब्रांच `develop` से बनाएँ:

```bash
git fetch upstream
git checkout develop
git merge upstream/develop
git checkout -b feature/short-descriptive-name
```

पुल रिक्वेस्ट हमेशा **`develop` के विरुद्ध** खोले जाते हैं, कभी `main` के विरुद्ध नहीं।

---

## कमिट संदेश

हम [**Conventional Commits**](https://www.conventionalcommits.org/) का उपयोग करते हैं। प्रत्येक कमिट संदेश का रूप होता है:

```
<type>(<optional scope>): <description>
```

सामान्य प्रकार:

| प्रकार | अर्थ |
| --- | --- |
| `feat` | एक नया फ़ीचर। |
| `fix` | एक बग फ़िक्स। |
| `refactor` | एक कोड परिवर्तन जो न तो बग फ़िक्स करता है और न ही फ़ीचर जोड़ता है। |
| `docs` | केवल दस्तावेज़ीकरण। |
| `test` | टेस्ट जोड़ना या सुधारना। |
| `chore` | बिल्ड प्रोसेस, टूलिंग, या डिपेंडेंसी परिवर्तन। |
| `style` | बिना कोड प्रभाव के फ़ॉर्मेटिंग परिवर्तन। |

उदाहरण:

```text
feat(animals): add photo gallery to animal detail screen
fix(auth): handle expired token on cold start
docs: update contributing guide for FVM 3.44
```

---

## कोडिंग मानक

- **लाइन की लंबाई 100** है (Dart के डिफ़ॉल्ट 80 के बजाय)। हर परिवर्तन को फ़ॉर्मेट करें:

  ```bash
  fvm dart format -l 100 lib test
  ```

- **स्टेट मैनेजमेंट `flutter_bloc` Cubits** का उपयोग करता है, साथ ही एक sealed `DataState<T>` (`lib/util/data_state.dart`) जिसे `DataStateBuilder` के माध्यम से रेंडर किया जाता है। Cubits `safeEmit` (`lib/util/bloc_ext.dart`) के माध्यम से emit करते हैं ताकि close के बाद emit न हो। फ़ॉर्म इनपुट्स के लिए `formz` इस्तेमाल होता है; मॉडल्स के लिए `equatable`।

- **इवेंट्स और स्टेट्स sealed classes हैं।** जहाँ पूर्ण BLoC का उपयोग किया जाता है, वहाँ इसके इवेंट्स और स्टेट्स को bloc फ़ाइल से जुड़ी sealed classes के रूप में परिभाषित करें। सीधी request/response स्क्रीन्स के लिए `DataState<T>` के साथ Cubit को प्राथमिकता दें।

- **नेविगेशन `go_router`** (`lib/navigation/app_router.dart`) का उपयोग करता है। रूट्स को `AppRoutes` में constants के रूप में घोषित किया जाता है; जटिल ऑब्जेक्ट्स को `extra` के माध्यम से पास किया जाता है और `AppExtraCodec` के माध्यम से एन्कोड किया जाता है। imperative `Navigator` कॉल्स या named routes का उपयोग न करें।

- **डिपेंडेंसी इंजेक्शन `get_it` + `injectable` 3** का उपयोग करता है। `initDi()` को `main` में `runApp` से पहले कॉल किया जाता है। किसी भी `@injectable` एनोटेशन को छूने के बाद `build_runner` को फिर से चलाएँ। **Cubits/BLoCs को DI में रजिस्टर न करें** — इन्हें स्क्रीन widget पर `BlocProvider` के माध्यम से प्रदान करें और कंस्ट्रक्टर में `getIt` से इनकी डिपेंडेंसीज़ प्राप्त करें।

- **नेटवर्किंग Chopper + Dio** का उपयोग करती है, जो `doc/api/` के अंतर्गत OpenAPI स्पेक से `lib/api/` में जनरेट होती है। जनरेट की गई फ़ाइलों (`*.g.dart`, `*.chopper.dart`, `*.swagger.dart`) को कभी भी हाथ से एडिट न करें। हाथ से लिखे गए DTOs के लिए `@JsonSerializable` के साथ `part '<name>.g.dart';` का उपयोग करें।

- **स्टोरेज** `flutter_secure_storage` और `shared_preferences` के आसपास `lib/service/` में मौजूद wrappers के माध्यम से होती है। फ़ीचर्स से सीधे `SharedPreferences.getInstance()` को कॉल न करें।

- **relative imports के बजाय `package:` imports को प्राथमिकता दें** (`package:acits_flutter/...`)। प्रत्येक स्क्रीन फ़ोल्डर एक `<feature>.dart` barrel प्रदान करता है; प्रोजेक्ट-व्यापी `export.dart` barrel साझा हिस्सों को फिर से एक्सपोर्ट करता है।

- **Doc-comments रूसी भाषा में लिखी जाती हैं** ताकि मौजूदा कोडबेस से मेल खाएँ।

### प्रोजेक्ट लेआउट

```text
lib/
├── api/           # Chopper/OpenAPI generated HTTP layer (do not edit)
├── di/            # get_it + injectable container
├── domain/        # plain Dart domain models
├── generated/     # generated LocaleKeys (do not edit)
├── navigation/    # go_router configuration (app_router.dart, AppRoutes)
├── res/           # design tokens (colour, style, icons)
├── service/       # injectable services grouped by concern
├── ui/
│   ├── screen/<feature>/   # bloc-or-cubit / view / model per screen
│   └── widget/             # app-wide shared widgets
├── util/          # helpers, DataState, bloc_ext
└── export.dart    # project-wide barrel
```

---

## स्थानीयकरण

स्थानीयकरण **easy_localization** का उपयोग करता है। अनुवाद `assets/translations/en.json` और `assets/translations/ru.json` में रहते हैं, और keys को `LocaleKeys` (`lib/generated/locale_keys.g.dart`) में जनरेट किया जाता है। अंग्रेज़ी और रूसी दोनों पूर्ण हैं; फ़ॉलबैक locale `ru` है।

UI में **कोई हार्डकोडेड यूज़र-फेसिंग स्ट्रिंग्स** की अनुमति नहीं है।

एक स्ट्रिंग जोड़ने के लिए:

1. **समान key** को `assets/translations/en.json` **और** `assets/translations/ru.json` दोनों में जोड़ें।
2. keys को फिर से जनरेट करें:

   ```bash
   fvm dart run easy_localization:generate \
     -S assets/translations -O lib/generated -o locale_keys.g.dart -f keys
   ```

3. इसे कोड में उपयोग करें:

   ```dart
   Text(LocaleKeys.someKey.tr())
   ```

---

## टेस्टिंग

- **Unit और BLoC/Cubit टेस्ट** `test/unit/` में रहते हैं और `mocktail` + `bloc_test` का उपयोग करते हैं:

  ```bash
  fvm flutter test
  ```

  एक फ़ाइल चलाएँ या नाम से मिलान करें:

  ```bash
  fvm flutter test test/unit/path/to/foo_test.dart
  fvm flutter test --name "description substring"
  ```

- **End-to-end टेस्ट** **Patrol** का उपयोग करते हैं (`integration_test/`, `pubspec.yaml` के `patrol:` ब्लॉक में कॉन्फ़िगर किया गया):

  ```bash
  patrol test --flavor dev
  ```

नए फ़ीचर्स के साथ टेस्ट भी होने चाहिए। बग फ़िक्स में जहाँ व्यावहारिक हो, regression टेस्ट शामिल होना चाहिए।

---

## PR-पूर्व चेकलिस्ट

पुल रिक्वेस्ट खोलने से पहले, नीचे दिए गए हर आइटम की पुष्टि करें:

- [ ] कोड फ़ॉर्मेट किया गया है: `fvm dart format -l 100 lib test`.
- [ ] स्टैटिक एनालिसिस साफ़ है: `fvm flutter analyze`.
- [ ] सभी टेस्ट पास होते हैं: `fvm flutter test`.
- [ ] यदि किसी `@injectable` / `@JsonSerializable` / Chopper एनोटेशन में परिवर्तन हुआ हो तो जनरेट किया गया कोड फिर से जनरेट किया गया है: `fvm dart run build_runner build --delete-conflicting-outputs`.
- [ ] नई स्थानीयकरण keys **दोनों** `en.json` और `ru.json` में जोड़ी गई हैं, और `LocaleKeys` को फिर से जनरेट किया गया है।
- [ ] UI में कोई हार्डकोडेड यूज़र-फेसिंग स्ट्रिंग्स नहीं बची हैं।
- [ ] कमिट्स Conventional Commits का पालन करते हैं।
- [ ] ब्रांच `develop` पर आधारित है।

किसी भी फिर से जनरेट की गई फ़ाइल को कमिट करें — रिपॉज़िटरी में कमिट की गई जनरेट की गई फ़ाइलें एनालाइज़र के लिए सोर्स ऑफ़ ट्रुथ हैं।

---

## पुल रिक्वेस्ट खोलना

1. अपनी feature ब्रांच को अपने फोर्क पर पुश करें:

   ```bash
   git push -u origin feature/short-descriptive-name
   ```

2. upstream रिपॉज़िटरी पर **`develop` के विरुद्ध** एक पुल रिक्वेस्ट खोलें।

3. PR विवरण भरें: क्या बदला, क्यों, और इसका परीक्षण कैसे किया गया। संबंधित issue को **लिंक करें** (जैसे `Closes #123`) ताकि यह ट्रैक हो और मर्ज होने पर स्वतः बंद हो जाए।

4. सुनिश्चित करें कि **CI ग्रीन है।** `.github/workflows/ci.yml` पर वर्कफ़्लो analyse + test, एक Android dev APK बिल्ड, और एक unsigned iOS बिल्ड चलाता है।

5. समीक्षा फ़ीडबैक को उसी ब्रांच पर अतिरिक्त कमिट्स पुश करके संबोधित करें।

PRs को केंद्रित और उचित रूप से छोटा रखें — छोटे PRs की समीक्षा और मर्ज तेज़ी से होते हैं।

---

## बग रिपोर्ट करना

कृपया दिए गए **issue templates** का उपयोग करके GitHub पर एक issue खोलें। एक अच्छी बग रिपोर्ट में शामिल होता है:

- एक स्पष्ट, वर्णनात्मक शीर्षक।
- पुनरुत्पादन के चरण।
- अपेक्षित बनाम वास्तविक व्यवहार।
- flavour (`dev` / `prod`), डिवाइस, और OS संस्करण।
- प्रासंगिक होने पर लॉग्स, स्क्रीनशॉट्स, या स्क्रीन रिकॉर्डिंग।

डुप्लिकेट से बचने के लिए पहले मौजूदा issues खोजें। सुरक्षा-संवेदनशील रिपोर्ट्स के लिए, सार्वजनिक issue दर्ज करने के बजाय मेंटेनर्स से निजी तौर पर संपर्क करें।

---

acits_flutter को बेहतर बनाने और पशु आश्रय स्थलों का समर्थन करने में मदद करने के लिए धन्यवाद।
