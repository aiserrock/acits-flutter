import 'package:flutter/foundation.dart';

/// Перенесено из app `util/url_matcher.dart` без изменений, чтобы модуль
/// «комментарии» не тянул приложение. Разбивает текст на фрагменты, помечая
/// URL-подстроки для кликабельного рендера.
const urlPattern = r'(https?|http)://([-A-Z0-9.]+)(/[-A-Z0-9+&@#/%=~_|!:,.;]*)?(\?[A-Z0-9+&@#/%=~_|!:,.;]*)?';

@immutable
class TextUrlWrapper {
  const TextUrlWrapper({required this.value, this.isUrl = false});

  final bool isUrl;
  final String value;

  static List<TextUrlWrapper> fromString(String text) {
    final result = <TextUrlWrapper>[];
    text.splitMapJoin(
      RegExp(urlPattern, caseSensitive: false),
      onMatch: (match) {
        result.add(TextUrlWrapper(isUrl: true, value: match.group(0) ?? ''));
        return '';
      },
      onNonMatch: (noMatch) {
        result.add(TextUrlWrapper(value: noMatch));
        return '';
      },
    );
    return result;
  }
}
