[English](../../CONTRIBUTING.md) · [中文](../zh/CONTRIBUTING.md) · [हिन्दी](../hi/CONTRIBUTING.md) · [Español](../es/CONTRIBUTING.md) · [Français](../fr/CONTRIBUTING.md) · **العربية** · [Русский](../ru/CONTRIBUTING.md)

# المساهمة في acits_flutter

شكرًا لاهتمامك بالمساهمة في **acits_flutter** — عميل موبايل بتقنية Flutter لموقع [acits.ru](https://acits.ru)، برنامج مجاني ومفتوح المصدر لتتبع الحيوانات داخل ملجأ الحيوانات.

هذا المشروع مرخّص بموجب **رخصة MIT**. بمساهمتك، فإنك توافق على ترخيص مساهماتك بنفس الشروط.

المستودع: [github.com/aiserrock/acits-flutter](https://github.com/aiserrock/acits-flutter)

---

## جدول المحتويات

- [المتطلبات الأساسية](#prerequisites)
- [إعداد المشروع](#project-setup)
- [نموذج التفريع (Branching)](#branching-model)
- [رسائل الالتزام (Commit)](#commit-messages)
- [معايير كتابة الكود](#coding-standards)
- [التوطين (Localisation)](#localisation)
- [الاختبار](#testing)
- [قائمة التحقق قبل فتح طلب السحب](#pre-pr-checklist)
- [فتح طلب سحب (Pull Request)](#opening-a-pull-request)
- [الإبلاغ عن الأخطاء](#reporting-bugs)

---

## المتطلبات الأساسية

سلسلة الأدوات مثبّتة على إصدار محدد عبر **FVM** (Flutter Version Management) من خلال ملف `.fvmrc` الموجود في جذر المستودع.

| الأداة | الإصدار |
| --- | --- |
| Flutter | 3.44.0 |
| Dart | 3.12.0 |
| FVM | أحدث إصدار مستقر |

قم بتثبيت FVM وحزمة SDK المحددة:

```bash
dart pub global activate fvm
fvm install
```

استخدم دائمًا البادئة `fvm` مع أوامر Flutter وDart لضمان استخدام حزمة SDK المحددة:

```bash
fvm flutter <command>
fvm dart <command>
```

يلزم أيضًا توفّر سلسلة أدوات Android و/أو iOS تعمل بشكل صحيح (Android Studio / Xcode) لبناء التطبيق وتشغيله.

---

## إعداد المشروع

1. قم بعمل **Fork** للمستودع على GitHub، ثم **استنسخ (clone)** نسختك:

   ```bash
   git clone git@github.com:<your-username>/acits-flutter.git
   cd acits-flutter
   ```

2. **أضف الـ remote الأساسي (upstream)** لتتمكن من مزامنة نسختك:

   ```bash
   git remote add upstream git@github.com:aiserrock/acits-flutter.git
   ```

3. **اجلب التبعيات (dependencies):**

   ```bash
   fvm flutter pub get
   ```

4. **انسخ قوالب الإعدادات النموذجية.** ملفات إعدادات Firebase مُستثناة من Git (gitignored)؛ انسخ القوالب ذات اللاحقة `*.example` واملأها ببياناتك الخاصة:

   ```bash
   # Android — لكل نكهة (flavour) ملف مستقل:
   cp android/app/src/dev/google-services.json.example android/app/src/dev/google-services.json
   cp android/app/src/prod/google-services.json.example android/app/src/prod/google-services.json
   # iOS
   cp ios/Runner/GoogleService-Info.plist.example ios/Runner/GoogleService-Info.plist
   ```

   > يتبع ملف `key.properties.example` الموجود تحت `android/keystore/` النمط نفسه إذا احتجت إلى إعداد التوقيع (signing) محليًا.

5. **ولّد الكود.** يستخدم المشروع توليد الكود (code generation) لحقن التبعيات (injectable)، وتسلسل JSON، وChopper:

   ```bash
   fvm dart run build_runner build --delete-conflicting-outputs
   ```

6. **شغّل التطبيق.** توجد نكهتان (flavours)، ولكل منهما نقطة دخول خاصة بها:

   ```bash
   # نكهة dev
   fvm flutter run -t test/dev/main.dart --flavor dev

   # نكهة prod
   fvm flutter run -t lib/main.dart --flavor prod
   ```

---

## نموذج التفريع (Branching)

نتّبع نموذج تفريع على نمط **git-flow**:

| الفرع | الغرض |
| --- | --- |
| `main` | كود مستقر جاهز للإصدار. قابل للنشر دائمًا. لا تستهدفه مباشرة بطلبات السحب. |
| `develop` | فرع التكامل حيث يتم دمج أعمال الميزات. جميع المساهمات تستهدف `develop`. |
| `feature/*` | ميزات وإصلاحات فردية، متفرّعة من `develop`. |

أنشئ فرعك من `develop`:

```bash
git fetch upstream
git checkout develop
git merge upstream/develop
git checkout -b feature/short-descriptive-name
```

تُفتح طلبات السحب دائمًا **مقابل `develop`**، وليس أبدًا مقابل `main`.

---

## رسائل الالتزام (Commit)

نستخدم [**Conventional Commits**](https://www.conventionalcommits.org/). لكل رسالة التزام الصيغة التالية:

```
<type>(<optional scope>): <description>
```

الأنواع الشائعة:

| النوع | المعنى |
| --- | --- |
| `feat` | ميزة جديدة. |
| `fix` | إصلاح خطأ. |
| `refactor` | تغيير في الكود لا يصلح خطأ ولا يضيف ميزة. |
| `docs` | توثيق فقط. |
| `test` | إضافة اختبارات أو تصحيحها. |
| `chore` | تغييرات في عملية البناء أو الأدوات أو التبعيات. |
| `style` | تغييرات تنسيقية لا تؤثر على الكود. |

أمثلة:

```text
feat(animals): add photo gallery to animal detail screen
fix(auth): handle expired token on cold start
docs: update contributing guide for FVM 3.44
```

---

## معايير كتابة الكود

- **طول السطر هو 100** (وليس الافتراضي في Dart وهو 80). نسّق كل تغيير:

  ```bash
  fvm dart format -l 100 lib test
  ```

- **إدارة الحالة تستخدم Cubits من `flutter_bloc`** بالإضافة إلى `DataState<T>` مغلقة (sealed) (`lib/util/data_state.dart`) يتم عرضها عبر `DataStateBuilder`. تُصدر الـ Cubits عبر `safeEmit` (`lib/util/bloc_ext.dart`) لتجنّب الإصدار بعد الإغلاق. مدخلات النماذج تستخدم `formz`؛ النماذج تستخدم `equatable`.

- **الأحداث والحالات هي كلاسات مغلقة (sealed).** حيثما يُستخدم BLoC كامل، عرّف أحداثه وحالاته ككلاسات مغلقة مرفقة بملف الـ bloc. يُفضَّل استخدام Cubit مع `DataState<T>` للشاشات ذات نمط الطلب/الاستجابة المباشر.

- **التنقل يستخدم `go_router`** (`lib/navigation/app_router.dart`). المسارات مُعرَّفة كثوابت في `AppRoutes`؛ يتم تمرير الكائنات المعقدة عبر `extra` وترميزها عبر `AppExtraCodec`. لا تستخدم استدعاءات `Navigator` الأمرية أو المسارات المسمّاة.

- **حقن التبعيات يستخدم `get_it` + `injectable` 3.** يتم استدعاء `initDi()` في `main` قبل `runApp`. أعد تشغيل `build_runner` بعد أي تعديل على أي تعليق توضيحي (annotation) من نوع `@injectable`. **لا تسجّل الـ Cubits/BLoCs في حاوية حقن التبعيات (DI)** — بل وفّرها عبر `BlocProvider` في ودجت الشاشة واستخرج تبعياتها من `getIt` في الـ constructor.

- **الشبكات تستخدم Chopper + Dio،** المولَّدة من مواصفة OpenAPI الموجودة تحت `doc/api/` إلى `lib/api/`. لا تُعدّل يدويًا الملفات المولَّدة (`*.g.dart`، `*.chopper.dart`، `*.swagger.dart`). للـ DTOs المكتوبة يدويًا استخدم `@JsonSerializable` مع `part '<name>.g.dart';`.

- **التخزين** يمرّ عبر الأغلفة (wrappers) الموجودة في `lib/service/` حول `flutter_secure_storage` و`shared_preferences`. لا تستدعِ `SharedPreferences.getInstance()` مباشرة من داخل الميزات.

- **يُفضَّل استخدام استيرادات `package:`** (`package:acits_flutter/...`) بدلًا من الاستيرادات النسبية (relative). يوفّر كل مجلد شاشة ملف تجميع (barrel) باسم `<feature>.dart`؛ ملف التجميع العام للمشروع `export.dart` يعيد تصدير العناصر المشتركة.

- **التعليقات التوثيقية (doc-comments) تُكتب باللغة الروسية** لتتوافق مع قاعدة الكود الحالية.

### هيكل المشروع

```text
lib/
├── api/           # طبقة HTTP المولَّدة من Chopper/OpenAPI (لا تُعدَّل)
├── di/            # حاوية get_it + injectable
├── domain/        # نماذج المجال (domain) بلغة Dart الصرفة
├── generated/     # LocaleKeys المولَّدة (لا تُعدَّل)
├── navigation/    # إعدادات go_router (app_router.dart، AppRoutes)
├── res/           # رموز التصميم (الألوان، الأنماط، الأيقونات)
├── service/       # خدمات قابلة للحقن مجمّعة حسب الاهتمام
├── ui/
│   ├── screen/<feature>/   # bloc-or-cubit / view / model لكل شاشة
│   └── widget/             # ودجتس مشتركة على مستوى التطبيق
├── util/          # أدوات مساعدة، DataState، bloc_ext
└── export.dart    # ملف التجميع العام للمشروع
```

---

## التوطين (Localisation)

يستخدم التوطين حزمة **easy_localization**. توجد الترجمات في `assets/translations/en.json` و`assets/translations/ru.json`، وتُولَّد المفاتيح في `LocaleKeys` (`lib/generated/locale_keys.g.dart`). كل من الإنجليزية والروسية مكتملتان، واللغة الاحتياطية (fallback) هي `ru`.

**لا يُسمح بأي نصوص ظاهرة للمستخدم مكتوبة مباشرة (hardcoded)** في واجهة المستخدم.

لإضافة نص:

1. أضف **نفس المفتاح** إلى **كلٍّ** من `assets/translations/en.json` **و** `assets/translations/ru.json`.
2. أعد توليد المفاتيح:

   ```bash
   fvm dart run easy_localization:generate \
     -S assets/translations -O lib/generated -o locale_keys.g.dart -f keys
   ```

3. استخدمه في الكود:

   ```dart
   Text(LocaleKeys.someKey.tr())
   ```

---

## الاختبار

- **اختبارات الوحدة (Unit) وBLoC/Cubit** موجودة في `test/unit/` وتستخدم `mocktail` + `bloc_test`:

  ```bash
  fvm flutter test
  ```

  لتشغيل ملف واحد أو المطابقة بالاسم:

  ```bash
  fvm flutter test test/unit/path/to/foo_test.dart
  fvm flutter test --name "description substring"
  ```

- **اختبارات شاملة (End-to-end)** تستخدم **Patrol** (`integration_test/`، مُعدَّة في قسم `patrol:` من `pubspec.yaml`):

  ```bash
  patrol test --flavor dev
  ```

يجب أن تُشحَن الميزات الجديدة مع اختبارات. يجب أن تتضمّن إصلاحات الأخطاء اختبار انحدار (regression) عندما يكون ذلك عمليًا.

---

## قائمة التحقق قبل فتح طلب السحب

قبل فتح طلب سحب (pull request)، تأكد من كل بند أدناه:

- [ ] الكود منسَّق: `fvm dart format -l 100 lib test`.
- [ ] التحليل الساكن (static analysis) نظيف: `fvm flutter analyze`.
- [ ] جميع الاختبارات ناجحة: `fvm flutter test`.
- [ ] تمت إعادة توليد الكود المولَّد إذا تغيّر أي تعليق توضيحي من نوع `@injectable` / `@JsonSerializable` / Chopper: `fvm dart run build_runner build --delete-conflicting-outputs`.
- [ ] تمت إضافة مفاتيح التوطين الجديدة إلى **كلا** الملفين `en.json` و`ru.json`، وتمت إعادة توليد `LocaleKeys`.
- [ ] لا توجد نصوص ظاهرة للمستخدم مكتوبة مباشرة (hardcoded) متبقية في واجهة المستخدم.
- [ ] الالتزامات (commits) تتبع معيار Conventional Commits.
- [ ] الفرع مبنيّ على `develop`.

التزم (commit) بأي ملفات معاد توليدها — الملفات المولَّدة الملتزم بها في المستودع هي المصدر الموثوق للمحلِّل (analyser).

---

## فتح طلب سحب (Pull Request)

1. ادفع فرع الميزة الخاص بك إلى نسختك (fork):

   ```bash
   git push -u origin feature/short-descriptive-name
   ```

2. افتح طلب سحب **مقابل `develop`** على المستودع الأساسي (upstream).

3. املأ وصف طلب السحب: ما الذي تغيّر، ولماذا، وكيف تم اختباره. **اربط التذكرة (issue) ذات الصلة** (مثل `Closes #123`) لتُتَابع وتُغلق تلقائيًا عند الدمج.

4. تأكد من أن **CI أخضر (ناجح).** يقوم سير العمل (workflow) في `.github/workflows/ci.yml` بتشغيل التحليل + الاختبار، وبناء APK لنكهة dev على Android، وبناء غير موقَّع (unsigned) على iOS.

5. عالِج ملاحظات المراجعة عبر دفع التزامات (commits) إضافية إلى نفس الفرع.

اجعل طلبات السحب مركّزة وصغيرة بشكل معقول — تُراجَع طلبات السحب الصغيرة وتُدمَج بشكل أسرع.

---

## الإبلاغ عن الأخطاء

يُرجى فتح تذكرة (issue) على GitHub باستخدام **قوالب التذاكر (issue templates)** المتوفرة. يتضمّن تقرير الخطأ الجيد:

- عنوانًا واضحًا وواصفًا.
- خطوات إعادة الإنتاج (reproduce).
- السلوك المتوقَّع مقابل السلوك الفعلي.
- النكهة (`dev` / `prod`)، والجهاز، وإصدار نظام التشغيل.
- السجلات (logs)، أو لقطات الشاشة، أو تسجيل شاشة عند الحاجة.

ابحث في التذاكر الموجودة أولًا لتجنّب التكرار. للتقارير الحساسة أمنيًا، تواصل مع القائمين على المشروع بشكل خاص بدلًا من فتح تذكرة عامة.

---

شكرًا لمساعدتك في تحسين acits_flutter ودعم ملاجئ الحيوانات.
