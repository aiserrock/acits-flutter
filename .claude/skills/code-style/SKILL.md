# Навык: Code Style

## Dart Code Style

### Базовые правила
- Длина строки: **100 символов**
- Форматирование: `fvm dart format -l 100`
- Линтер: `mm_flutter_linter` (кастомные правила проекта)

### Именование

| Элемент | Стиль | Пример |
|---------|-------|--------|
| Классы | UpperCamelCase | `MyBloc`, `FinanceScreen` |
| Файлы | snake_case | `my_bloc.dart`, `finance_screen.dart` |
| Переменные | lowerCamelCase | `totalAmount`, `isLoading` |
| Константы | lowerCamelCase | `defaultPageSize` |
| Приватные | _ prefix | `_service`, `_onLoadRequested` |
| Enum values | lowerCamelCase | `MyStatus.active` |

### Структура файлов

Порядок элементов в файле:
1. `part` / `part of` директивы
2. Константы класса (static const)
3. Поля (final fields)
4. Конструкторы
5. Factory конструкторы
6. Публичные методы
7. Приватные методы

### Импорты

Порядок импортов:
1. `dart:` библиотеки
2. `package:` внешние зависимости
3. `package:` внутренние пакеты проекта (ссылка на корневой barrel файл пакета с library)

Разделяй группы пустой строкой.

```dart
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:sharable_domain/sharable_domain.dart';

// НИКОГДА НЕ используйте относительные импорты для файлов внутри пакета:
import '../widgets/my_widget.dart'; // ЗАПРЕЩЕНО
```

## Кастомные правила проекта

### Обязательные

1. **Sealed classes для Events и States** — НИКОГДА не используй freezed для BLoC events/states
2. **JsonSerializable для DTO** — НИКОГДА не используй freezed для network DTO
3. **Barrel exports** — ВСЕГДА создавай barrel файлы для пакетов
4. **Локализация** — НИКОГДА не хардкодь строки в UI, используй `S.of(context)`
5. **ISimpleKeyValueStorage** — НИКОГДА не используй SharedPreferences напрямую
6. **Документация на русском** — ВСЕ doc-comments пишутся на русском языке
7. **Part imports для BLoC** — Events и States подключаются через `part`/`part of`

### Стиль BLoC

```dart
// ПРАВИЛЬНО: sealed class
sealed class MyEvent {
  const MyEvent();
}

// НЕПРАВИЛЬНО: freezed
@freezed
class MyEvent with _$MyEvent {
  const factory MyEvent.load() = _Load;
}
```

### Стиль DTO

```dart
// ПРАВИЛЬНО: JsonSerializable
@JsonSerializable()
class MyResponse {
  final String data;
  MyResponse({required this.data});
  factory MyResponse.fromJson(Map<String, dynamic> json) =>
      _$MyResponseFromJson(json);
}

// НЕПРАВИЛЬНО: freezed для DTO
@freezed
class MyResponse with _$MyResponse {
  const factory MyResponse({required String data}) = _MyResponse;
}
```

### Стиль виджетов

```dart
// ПРАВИЛЬНО: StatelessWidget с const конструктором
class MyWidget extends StatelessWidget {
  final String title;

  const MyWidget({required this.title, super.key});

  @override
  Widget build(BuildContext context) {
    return Text(title);
  }
}
```

### Документация

```dart
// ПРАВИЛЬНО: русский язык
/// Блок для управления состоянием экрана финансов.
/// Загружает данные о балансе и транзакциях.
class FinanceBloc extends Bloc<FinanceEvent, FinanceState> {
```

### Обработка ошибок

- Используй try/catch в BLoC для обработки ошибок сервисов
- Не глотай ошибки — всегда логируй или пробрасывай
- Для сетевых ошибок используется `NetworkException` и `ServerException`

### Null Safety

- Предпочитай non-nullable типы где возможно
- Используй `required` для обязательных параметров
- Избегай `!` (null assertion) — используй null-check или `??`

## Чек-лист Code Style

- [ ] Длина строк <= 100 символов
- [ ] Импорты сгруппированы и отсортированы
- [ ] Sealed classes для BLoC events/states
- [ ] JsonSerializable для DTO
- [ ] Barrel exports присутствуют
- [ ] Документация на русском
- [ ] Нет хардкоженных строк в UI
- [ ] Форматирование: `fvm dart format -l 100`

## Дополнительные кастомные правила

<!-- Новые кастомные правила добавляются ниже этой линии -->
