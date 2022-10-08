# acits_flutter

Flutter client for https://acits.ru/

## Desc

Acits – Бесплатное программное обеспечение для контроля за животными внутри приюта

## CLI

### Native splash screen gen

https://pub.dev/packages/flutter_native_splash

```dart
./flutter_native_splash.yaml
assets/image/logo_native.png
```

```bash
flutter pub run flutter_native_splash:create
```

### DI

https://pub.dev/packages/get_it

https://pub.dev/packages/injectable

```bash
fvm flutter pub run build_runner build --delete-conflicting-outputs
```

### OpenAPI

https://pub.dev/packages/swagger_dart_code_generator

```bash
fvm flutter pub run build_runner build --delete-conflicting-outputs && fvm flutter format -l 100 .
```

### Build apk/aab
```bash
fvm flutter build appbundle -t test/dev/main.dart --flavor dev --release --obfuscate --split-debug-info=./build/app/outputs/symbols/dev
fvm flutter build apk -t test/dev/main.dart --flavor dev --release
```

```bash
fvm flutter build appbundle -t lib/main.dart --flavor prod --release --obfuscate --split-debug-info=./build/app/outputs/symbols/prod
fvm flutter build apk -t lib/main.dart --flavor prod --release --obfuscate --split-debug-info=./build/app/debug_info  
```

```bash
fvm flutter build ios -t test/dev/main.dart --flavor dev --release --obfuscate --split-debug-info=./build/app/outputs/symbols/prod
fvm flutter build ios -t lib/main.dart --flavor prod --release --obfuscate --split-debug-info=./build/app/outputs/symbols/prod
```

### Build iOS testflight
```bash
export LANG=en_US.UTF-8
(fvm flutter clean && fvm flutter pub get && cd ios && pod repo update && pod install)
fvm flutter build ios --flavor dev -t test/dev/main.dart --no-codesign --obfuscate --split-debug-info=./build/app/outputs/symbols/dev
(cd ios && fastlane releaseDev)      
```
