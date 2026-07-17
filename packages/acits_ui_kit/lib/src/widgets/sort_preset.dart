import 'package:equatable/equatable.dart';

/// Пресет сортировки для ленты чипсов.
///
/// Один чипс = целый готовый режим сортировки: подпись ([labelKey]) + значение
/// серверного параметра `ordering` ([ordering]). Пресеты взаимоисключающие —
/// активен ровно один. [id] — стабильный ключ для сравнения активного пресета
/// (не завязан на локализованную подпись).
class SortPreset extends Equatable {
  const SortPreset({required this.id, required this.labelKey, required this.ordering});

  /// Стабильный идентификатор пресета (для `selected`/сравнения).
  final String id;

  /// Ключ локализации подписи чипса (резолвится через easy_localization `.tr()`).
  final String labelKey;

  /// Значение query-параметра `ordering` для API. Префикс `-` — убывание.
  /// Вложенные поля — через `__` (DRF): напр. `prescription__animal__name`.
  final String ordering;

  @override
  List<Object?> get props => [id, labelKey, ordering];
}
