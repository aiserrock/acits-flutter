/// Removes personal data and secrets from text before it leaves the device.
abstract final class Scrubber {
  static const redacted = '[redacted]';

  static final _email = RegExp(r'[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}');
  static final _bearer = RegExp(r'Bearer\s+[A-Za-z0-9._~+/=-]+', caseSensitive: false);
  // Three base64url segments: a JWT, wherever it appears.
  static final _jwt = RegExp(r'eyJ[A-Za-z0-9_-]{5,}\.[A-Za-z0-9_-]{5,}\.[A-Za-z0-9_-]{5,}');
  static final _secretPair = RegExp(
    r'''(password|passwd|re_password|token|access|refresh|secret|authorization)(["']?\s*[:=]\s*["']?)[^"'\s,}&]+''',
    caseSensitive: false,
  );
  static final _phone = RegExp(r'(?<![\w.])\+?\d[\d\s()-]{8,}\d(?![\w.])');

  static const _sensitiveKeys = {'authorization', 'cookie', 'set-cookie', 'x-api-key', 'proxy-authorization'};

  /// [input] with e-mails, tokens, credentials and phone numbers replaced.
  static String text(String input) => input
      .replaceAll(_jwt, redacted)
      .replaceAll(_bearer, 'Bearer $redacted')
      .replaceAllMapped(_secretPair, (m) => '${m[1]}${m[2]}$redacted')
      .replaceAll(_email, redacted)
      .replaceAll(_phone, redacted);

  /// [headers] with credential-carrying entries replaced.
  static Map<String, String> headers(Map<String, String> headers) => {
    for (final MapEntry(:key, :value) in headers.entries)
      key: _sensitiveKeys.contains(key.toLowerCase()) ? redacted : text(value),
  };

  /// [url] without its query string: tokens and e-mails travel there.
  static String url(String url) {
    final index = url.indexOf('?');
    return text(index < 0 ? url : url.substring(0, index));
  }
}
