import 'dart:convert';

/// Кодек для поля `extra` в go_router.
///
/// Зачем: Flutter Inspector и дебаг навигации пытаются сериализовать содержимое
/// `extra`. Большие/сложные объекты (модели, колбэки) ломают инспектор и могут
/// приводить к ошибкам. Решение: заменяем все НЕ-примитивные значения на токен
/// и храним оригинал во внутреннем временном хранилище до момента чтения.
///
/// Основано на официальном примере go_router:
/// https://github.com/flutter/packages/blob/main/packages/go_router/example/lib/extra_codec.dart
///
/// !!! НЕ предназначен для передачи «живых» объектов (контроллеры, контекст).
///
/// Правило роутов приложения: идентичность экрана живёт в path/query, а `extra`
/// — только необязательный in-memory кэш уже загруженной сущности (сейчас это
/// `AnimalNote` экрана правки комментария и `List<Shelter>` экрана выбора
/// приюта). Билдеры роутов обязаны работать при `extra == null`: токен живёт
/// только в рамках процесса и извлекается один раз, поэтому после перезагрузки
/// страницы и повторного «вперёд/назад» кэша уже нет.
///
/// Как работает:
/// - Примитивы (String, num, bool, null) — передаются как есть.
/// - Коллекции из одних примитивов (`List`, `Map<String, Object?>`) — кодируются
///   рекурсивно.
/// - Любой другой объект, а также список с не-примитивными элементами →
///   сохраняется целиком в [_ExtraTokenStore] и заменяется на карту вида
///   `{"__extra_token__": "<id>"}`.
/// - При декодировании токены восстанавливаются в исходные объекты и
///   одновременно удаляются из хранилища (извлечение ровно один раз).
///
/// Ограничения: токены живут в рамках процесса, объект извлекается один раз,
/// payload должен быть маленьким и короткоживущим. Где возможно — предпочитать
/// path/query-параметры и ID вместо передачи объектов.
class AppExtraCodec extends Codec<Object?, Object?> {
  const AppExtraCodec();

  static const _kTokenKey = '__extra_token__';

  static final _enc = _AppExtraEncoder();
  static final _dec = _AppExtraDecoder();

  @override
  Converter<Object?, Object?> get encoder => _enc;

  @override
  Converter<Object?, Object?> get decoder => _dec;

  static Object? _encode(Object? value) {
    if (value == null || value is String || value is num || value is bool) {
      return value;
    }
    if (value is List) {
      // Список сущностей (например, `List<Shelter>`) токенизируется целиком, чтобы
      // при декодировании вернуться тем же типизированным списком, а не
      // `List<Object?>` из отдельных токенов.
      if (value.any((item) => !_isPlain(item))) return <String, Object?>{_kTokenKey: _ExtraTokenStore.put(value)};
      return value.map(_encode).toList();
    }
    if (value is Map) {
      final result = <String, Object?>{};
      for (final entry in value.entries) {
        if (entry.key is String) result[entry.key as String] = _encode(entry.value);
      }
      return result;
    }
    return <String, Object?>{_kTokenKey: _ExtraTokenStore.put(value)};
  }

  /// Значение, которое кодек пропускает как есть (рекурсивно для коллекций).
  static bool _isPlain(Object? value) {
    if (value == null || value is String || value is num || value is bool) return true;
    if (value is List) return value.every(_isPlain);
    if (value is Map) return value.entries.every((e) => e.key is String && _isPlain(e.value));
    return false;
  }

  static Object? _decode(Object? value) {
    if (value is Map) {
      if (value.length == 1 && value.containsKey(_kTokenKey)) {
        final token = value[_kTokenKey] as String?;
        return token == null ? null : _ExtraTokenStore.take(token);
      }
      final result = <String, Object?>{};
      for (final entry in value.entries) {
        if (entry.key is String) result[entry.key as String] = _decode(entry.value);
      }
      return result;
    }
    if (value is List) {
      return value.map(_decode).toList();
    }
    return value;
  }
}

class _AppExtraEncoder extends Converter<Object?, Object?> {
  @override
  Object? convert(Object? input) => AppExtraCodec._encode(input);
}

class _AppExtraDecoder extends Converter<Object?, Object?> {
  @override
  Object? convert(Object? input) => AppExtraCodec._decode(input);
}

/// Временное хранилище объектов, которые нельзя представить примитивами.
/// Данные живут до первого успешного извлечения ([take]).
class _ExtraTokenStore {
  _ExtraTokenStore._();

  static final Map<String, Object> _store = <String, Object>{};
  static int _counter = 0;

  static String put(Object value) {
    final token = 'extra_${_counter++}_${identityHashCode(value)}';
    _store[token] = value;
    return token;
  }

  static Object? take(String token) => _store.remove(token);
}
