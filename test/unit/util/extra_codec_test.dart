import 'package:acits_flutter/navigation/extra_codec.dart';
import 'package:flutter_test/flutter_test.dart';

/// Небольшой не-примитивный класс для проверки токенизации.
class _Payload {
  const _Payload(this.value);

  final int value;
}

void main() {
  const codec = AppExtraCodec();

  group('AppExtraCodec primitives', () {
    test('String passes through encode/decode unchanged', () {
      expect(codec.encode('hello'), 'hello');
      expect(codec.decode('hello'), 'hello');
    });

    test('num passes through unchanged', () {
      expect(codec.encode(42), 42);
      expect(codec.decode(42), 42);
      expect(codec.encode(3.14), 3.14);
      expect(codec.decode(3.14), 3.14);
    });

    test('bool passes through unchanged', () {
      expect(codec.encode(true), true);
      expect(codec.decode(false), false);
    });

    test('null passes through unchanged', () {
      expect(codec.encode(null), isNull);
      expect(codec.decode(null), isNull);
    });
  });

  group('AppExtraCodec collections of primitives', () {
    test('Map<String, Object?> of primitives round-trips', () {
      final map = <String, Object?>{'name': 'Rex', 'age': 3, 'active': true, 'note': null};
      final encoded = codec.encode(map);
      final decoded = codec.decode(encoded);
      expect(decoded, map);
    });

    test('nested list/map of primitives round-trips', () {
      final data = <String, Object?>{
        'ids': [1, 2, 3],
        'meta': <String, Object?>{
          'flag': false,
          'tags': ['a', 'b'],
          'inner': <String, Object?>{'x': 1},
        },
      };
      final encoded = codec.encode(data);
      final decoded = codec.decode(encoded);
      expect(decoded, data);
    });
  });

  group('AppExtraCodec non-primitive tokenization', () {
    test('encodes to a token map and decodes back to the SAME instance', () {
      const payload = _Payload(7);
      final encoded = codec.encode(payload);

      expect(encoded, isA<Map<String, Object?>>());
      final encodedMap = encoded as Map<String, Object?>;
      expect(encodedMap.keys.single, '__extra_token__');
      expect(encodedMap['__extra_token__'], isA<String>());

      final decoded = codec.decode(encoded);
      expect(identical(decoded, payload), isTrue);
    });

    test('take() is one-shot: second decode of same token yields null', () {
      const payload = _Payload(9);
      final encoded = codec.encode(payload);

      final first = codec.decode(encoded);
      expect(identical(first, payload), isTrue);

      final second = codec.decode(encoded);
      expect(second, isNull);
    });

    test('non-primitive nested inside a map is restored to same instance', () {
      const payload = _Payload(11);
      final encoded = codec.encode(<String, Object?>{'obj': payload, 'n': 1});
      final decoded = codec.decode(encoded) as Map<String, Object?>;

      expect(decoded['n'], 1);
      expect(identical(decoded['obj'], payload), isTrue);
    });
  });
}
