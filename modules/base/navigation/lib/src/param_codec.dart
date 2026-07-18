/// Типизированные кодеки path/query-параметров: единое место разбора «строка из
/// URL → значение» с безопасными фолбэками, чтобы билдеры роутов не разводили
/// `int.tryParse(state.pathParameters[...])` по месту.
abstract final class RouteParams {
  const RouteParams._();

  /// Обязательный int из path (кидает, если путь собран неверно — это баг роутинга).
  static int requireId(Map<String, String> pathParameters, [String key = 'id']) {
    final raw = pathParameters[key];
    final value = int.tryParse(raw ?? '');
    if (value == null) {
      throw ArgumentError('Route param "$key" is not an int: "$raw"');
    }
    return value;
  }

  /// Необязательный int из query (для edit/new и т.п.).
  static int? optionalInt(Map<String, String> queryParameters, String key) {
    return int.tryParse(queryParameters[key] ?? '');
  }

  static bool boolFlag(Map<String, String> queryParameters, String key) {
    return queryParameters[key] == 'true';
  }

  static String? optionalString(Map<String, String> queryParameters, String key) {
    final value = queryParameters[key];
    return (value == null || value.isEmpty) ? null : value;
  }
}
