# Навык: Написание тестов

## Общие принципы

- Используй `bloc_test` для тестирования BLoC классов
- Используй `flutter_test` для общих тестов
- **ВСЕГДА** покрывай BLoC тестами все возможные кейсы
- Тесты должны быть **простыми и читаемыми**
- Один тест — один кейс. Не комбинируй несколько проверок в одном тесте
- Именуй тесты описательно на английском языке

## Структура тестов

```
feature_<name>/
└── test/
    ├── bloc/
    │   └── <screen_name>_bloc_test.dart
    ├── service/
    │   └── <service_name>_test.dart
    └── widget/
        └── <widget_name>_test.dart
```

## BLoC тесты

### Шаблон BLoC теста

```dart
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

// Моки
class MockMyService extends Mock implements MyService {}

void main() {
  late MockMyService mockService;
  late MyBloc bloc;

  setUp(() {
    mockService = MockMyService();
    bloc = MyBloc(mockService);
  });

  tearDown(() {
    bloc.close();
  });

  group('MyBloc', () {
    test('начальное состояние — MyInitial', () {
      expect(bloc.state, isA<MyInitial>());
    });

    group('MyLoadRequested', () {
      final testData = MyData(id: 1, name: 'test');

      blocTest<MyBloc, MyState>(
        'эмитит [MyLoading, MyLoaded] при успешной загрузке',
        build: () {
          when(() => mockService.getData())
              .thenAnswer((_) async => testData);
          return MyBloc(mockService);
        },
        act: (bloc) => bloc.add(const MyLoadRequested()),
        expect: () => [
          isA<MyLoading>(),
          isA<MyLoaded>().having((s) => s.data, 'data', testData),
        ],
        verify: (_) {
          verify(() => mockService.getData()).called(1);
        },
      );

      blocTest<MyBloc, MyState>(
        'эмитит [MyLoading, MyError] при ошибке',
        build: () {
          when(() => mockService.getData())
              .thenThrow(Exception('Network error'));
          return MyBloc(mockService);
        },
        act: (bloc) => bloc.add(const MyLoadRequested()),
        expect: () => [
          isA<MyLoading>(),
          isA<MyError>(),
        ],
      );
    });
  });
}
```

### Обязательные кейсы для BLoC тестов

Для **каждого** события в BLoC необходимо покрыть:

1. **Начальное состояние** — проверка что bloc создается с правильным начальным состоянием
2. **Успешный сценарий** — happy path с корректными данными
3. **Ошибочный сценарий** — обработка исключений и ошибок сети
4. **Граничные случаи** — пустые данные, null-значения, пустые списки
5. **Повторные вызовы** — корректная обработка повторных событий
6. **Зависимости между событиями** — если состояние зависит от предыдущих событий

### Правила для BLoC тестов

- **ВСЕГДА** создавай новый BLoC в `build` callback `blocTest`, а не используй общий
- Используй `mocktail` для моков (НЕ `mockito`)
- Проверяй количество вызовов сервисов через `verify`
- Используй `having` для проверки конкретных полей состояния
- Группируй тесты по событиям через `group`

## Тесты сервисов

Пиши тесты для сервисов **только когда явно запрошено** или когда сервис содержит сложную бизнес-логику.

```dart
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockRepository extends Mock implements MyRepository {}

void main() {
  late MockRepository mockRepo;
  late MyServiceImpl service;

  setUp(() {
    mockRepo = MockRepository();
    service = MyServiceImpl(mockRepo);
  });

  group('MyServiceImpl', () {
    group('getData', () {
      test('возвращает трансформированные данные', () async {
        when(() => mockRepo.fetchData())
            .thenAnswer((_) async => MyResponse(items: [], totalCount: 0));

        final result = await service.getData();

        expect(result, isA<MyEntity>());
        expect(result.items, isEmpty);
      });
    });
  });
}
```

## Запуск тестов

```bash
# Все тесты
melos test

# Тесты конкретного пакета
fvm flutter test packages/feature_<name>/test/

# Конкретный тест-файл
fvm flutter test packages/feature_<name>/test/bloc/my_bloc_test.dart
```

## Чек-лист перед завершением

- [ ] Все BLoC events покрыты тестами
- [ ] Проверены success и error сценарии
- [ ] Проверены граничные случаи (пустые данные, null)
- [ ] Все тесты проходят (`fvm flutter test`)
- [ ] Моки используют `mocktail`
- [ ] Тесты изолированы друг от друга (новый bloc в каждом blocTest)
