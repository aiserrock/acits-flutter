import 'package:acits_flutter/util/url_cors_proxy.dart';
import 'package:acits_flutter/util/url_matcher.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('TextUrlWrapper.fromString', () {
    test('plain text with no url yields a single non-url segment', () {
      final result = TextUrlWrapper.fromString('just plain text');
      expect(result, hasLength(1));
      expect(result.single.isUrl, isFalse);
      expect(result.single.value, 'just plain text');
    });

    test('a bare url is detected as a single url segment', () {
      final result = TextUrlWrapper.fromString('https://example.com');
      final urls = result.where((e) => e.isUrl).toList();
      expect(urls, hasLength(1));
      expect(urls.single.value, 'https://example.com');
    });

    test('http scheme is matched too', () {
      final result = TextUrlWrapper.fromString('http://example.com/path');
      final urls = result.where((e) => e.isUrl).toList();
      expect(urls, hasLength(1));
      expect(urls.single.value, 'http://example.com/path');
    });

    test('url embedded in text splits into non-url + url + non-url', () {
      final result = TextUrlWrapper.fromString('see https://a.io/x now');
      expect(result.where((e) => e.isUrl), hasLength(1));
      expect(result.firstWhere((e) => e.isUrl).value, 'https://a.io/x');
      final joined = result.map((e) => e.value).join();
      expect(joined, 'see https://a.io/x now');
    });

    test('preserves ordering and reconstructs the original string', () {
      const text = 'a https://one.com b http://two.org/p?q=1 c';
      final result = TextUrlWrapper.fromString(text);
      expect(result.map((e) => e.value).join(), text);
      expect(result.where((e) => e.isUrl).map((e) => e.value).toList(), [
        'https://one.com',
        'http://two.org/p?q=1',
      ]);
    });

    test('matches url with query string', () {
      final result = TextUrlWrapper.fromString('https://example.com/search?q=cats&sort=1');
      final urls = result.where((e) => e.isUrl).toList();
      expect(urls, hasLength(1));
      expect(urls.single.value, 'https://example.com/search?q=cats&sort=1');
    });

    test('case-insensitive scheme is matched', () {
      final result = TextUrlWrapper.fromString('HTTPS://EXAMPLE.COM');
      expect(result.where((e) => e.isUrl), hasLength(1));
      expect(result.firstWhere((e) => e.isUrl).value, 'HTTPS://EXAMPLE.COM');
    });

    test('empty string yields a single empty non-url segment', () {
      final result = TextUrlWrapper.fromString('');
      expect(result, hasLength(1));
      expect(result.single.isUrl, isFalse);
      expect(result.single.value, '');
    });
  });

  group('TextUrlWrapper constructor', () {
    test('defaults isUrl to false', () {
      const wrapper = TextUrlWrapper(value: 'x');
      expect(wrapper.isUrl, isFalse);
      expect(wrapper.value, 'x');
    });

    test('honors explicit isUrl', () {
      const wrapper = TextUrlWrapper(value: 'https://x.com', isUrl: true);
      expect(wrapper.isUrl, isTrue);
    });
  });

  group('UrlCorsProxy.add (non-web VM)', () {
    test('null stays null', () {
      expect(UrlCorsProxy.add(null), isNull);
    });

    test('url is returned unchanged on non-web', () {
      const url = 'https://example.com/file.pdf';
      expect(UrlCorsProxy.add(url), url);
    });

    test('empty string is returned unchanged', () {
      expect(UrlCorsProxy.add(''), '');
    });
  });
}
