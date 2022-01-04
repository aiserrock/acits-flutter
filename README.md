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
fvm flutter pub run build_runner build
```

### OpenAPI

https://pub.dev/packages/swagger_dart_code_generator

```bash
fvm flutter pub run build_runner build --delete-conflicting-outputs
```
