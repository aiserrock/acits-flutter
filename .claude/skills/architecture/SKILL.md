# Навык: Архитектура и структура проекта

## Общие принципы архитектуры

Проект использует **feature-first модульную архитектуру** с чистым разделением ответственности.

### State Management
- **flutter_bloc** для управления состоянием
- Events и States — **sealed** классы. НИКОГДА не используй freezed для них
- Events и States подключаются через `part` import к файлу bloc
- Bloc располагается в `ui/<screen_name>/bloc/`

### Dependency Injection
- **GetIt** + **Injectable** для DI
- Аннотации: `@factory`, `@singleton`, `@lazySingleton`
- Регистрация модулей в `packages/base/di/`
- Фичи регистрируют сервисы навигации через router service классы в `packages/base/navigation`
- **НИКОГДА** не регистрируй Bloc внутри DI, он должен предоставляться через BlocProvider в виджете экрана

### Navigation
- **go_router** для декларативной маршрутизации
- Централизованный роутинг в `packages/base/navigation/`
- Паттерн Router Service для изоляции фич
- Фичи общаются **только через модуль навигации** — никаких прямых зависимостей между фичами

### Barrel Files
- **Всегда** используй barrel exports для API пакетов
- Главный barrel: `lib/<package_name>.dart`
- Barrel по слоям: `lib/data/data.dart`, `lib/domain/domain.dart`, `lib/ui/ui.dart`

## Структура пакетов

### Shared пакеты

#### `sharable_domain`
- Entities — доменные модели
- Interfaces — интерфейсы для сервисов (реализуются в feature пакетах)
- Common utils — общие утилиты

#### `sharable_base_ui`
- UIKit — виджеты дизайн-системы (кнопки, поля ввода, карточки и т.д.)
- Common widgets — общие UI компоненты
- UI utils — локализация (`S.of(context)`), ассеты, темы
- Дизайн-токены: цвета, текстовые стили, тени, границы

### Feature пакеты (`feature_<name>`)

Каждый feature пакет самодостаточен и следует структуре:

```
feature_<name>/
├── lib/
│   ├── data/
│   │   ├── repository/
│   │   │   ├── request/          # Request DTOs (@JsonSerializable)
│   │   │   ├── response/         # Response DTOs (@JsonSerializable + Transformable)
│   │   │   ├── obj/              # Object DTOs (@JsonSerializable + Transformable)
│   │   │   └── <name>_repository.dart  # Repository implementation
│   │   ├── <name>_service_impl.dart # Service implementations
│   │   └── data.dart             # Barrel export для data layer
│   │
│   ├── ui/
│   │   ├── <screen_name>/
│   │   │   ├── <screen_name>_screen.dart   # Экран
│   │   │   ├── bloc/
│   │   │   │   ├── <screen_name>_bloc.dart     # BLoC
│   │   │   │   ├── <screen_name>_event.dart    # Events (part of bloc)
│   │   │   │   └── <screen_name>_state.dart    # States (part of bloc)
│   │   │   └── widgets/
│   │   │       └── ...           # Виджеты, специфичные для экрана
│   │   └── ui.dart               # Barrel export для ui layer
│   │
│   ├── <feature_name>.dart                    # Главный barrel export
│   └── <feature_name>_router_service.dart     # Интерфейс router service
│
├── test/                         # Тесты
└── pubspec.yaml
```

### Base пакеты (`packages/base/`)
- `di/` — конфигурация DI (GetIt + Injectable)
- `navigation/` — маршрутизация (go_router), реализация router service интерфейсов
- `network/` — HTTP клиент и API
- `flavor_init/` — конфигурация flavors
- `flags/` — feature flags
- `flutter_crash_reporter/` — Sentry crash reporting

## Паттерны DTO

**ВАЖНО**: Для network request/response/obj DTOs **ВСЕГДА** используй `@JsonSerializable`, а НЕ `@freezed`.

### Request DTO
```dart
import 'package:json_annotation/json_annotation.dart';

part 'my_request.g.dart';

@JsonSerializable()
class MyRequest {
  final int? page;
  final int? size;

  MyRequest({this.page, this.size});

  factory MyRequest.fromJson(Map<String, dynamic> json) =>
      _$MyRequestFromJson(json);

  Map<String, dynamic> toJson() => _$MyRequestToJson(this);
}
```

### Response DTO
```dart
import 'package:json_annotation/json_annotation.dart';
import 'package:sharable_domain/sharable_domain.dart';

part 'my_response.g.dart';

@JsonSerializable()
class MyResponse implements Transformable<MyEntity> {
  final List<MyObj> items;
  final int totalCount;

  MyResponse({required this.items, required this.totalCount});

  factory MyResponse.fromJson(Map<String, dynamic> json) =>
      _$MyResponseFromJson(json);

  @override
  MyEntity transform() {
    return MyEntity(
      items: items.map((item) => item.transform()).toList(),
      totalCount: totalCount,
    );
  }
}
```

### Object DTO
```dart
import 'package:json_annotation/json_annotation.dart';
import 'package:sharable_domain/sharable_domain.dart';

part 'my_obj.g.dart';

@JsonSerializable()
class MyObj implements Transformable<MyDomainObject> {
  final int id;
  final String name;

  MyObj({required this.id, required this.name});

  factory MyObj.fromJson(Map<String, dynamic> json) =>
      _$MyObjFromJson(json);

  @override
  MyDomainObject transform() {
    return MyDomainObject(id: id, name: name);
  }
}
```

## BLoC паттерн

```dart
// my_bloc.dart
import 'package:flutter_bloc/flutter_bloc.dart';

part 'my_event.dart';
part 'my_state.dart';

class MyBloc extends Bloc<MyEvent, MyState> {
  final MyService _service;

  MyBloc(this._service) : super(const MyInitial()) {
    on<MyLoadRequested>(_onLoadRequested);
  }

  Future<void> _onLoadRequested(
    MyLoadRequested event,
    Emitter<MyState> emit,
  ) async {
    emit(const MyLoading());
    try {
      final result = await _service.getData();
      emit(MyLoaded(data: result));
    } catch (e) {
      emit(MyError(message: e.toString()));
    }
  }
}

// my_event.dart
part of 'my_bloc.dart';

sealed class MyEvent {
  const MyEvent();
}

class MyLoadRequested extends MyEvent {
  const MyLoadRequested();
}

// my_state.dart
part of 'my_bloc.dart';

sealed class MyState {
  const MyState();
}

class MyInitial extends MyState {
  const MyInitial();
}

class MyLoading extends MyState {
  const MyLoading();
}

class MyLoaded extends MyState {
  final MyData data;
  const MyLoaded({required this.data});
}

class MyError extends MyState {
  final String message;
  const MyError({required this.message});
}
```

## Локализация
- Строки хранятся в `packages/sharable_base_ui/lib/l10n/intl_ru.arb`
- **НИКОГДА не хардкодь строки в UI** — всегда добавляй в `.arb` файл
- Доступ: `S.of(context).<string_key>`
- Именование ключей описывает расположение: `moreFinanceTitle` = экран More, раздел Finance, заголовок
- После добавления строк выполни: `fvm dart run melos intl`

## Storage
- **НИКОГДА не используй SharedPreferences напрямую**
- Используй `ISimpleKeyValueStorage` из `mm_storage_core`
- Для шифрованного хранилища: `IEncryptedKeyValueStorage` из `mm_storage_encrypted`

## После генерации кода
Всегда выполняй `fvm dart run melos genone <package_name>` после добавления или изменения аннотаций Injectable или JsonSerializable.
