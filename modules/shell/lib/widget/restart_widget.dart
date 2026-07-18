import 'package:flutter/material.dart';

/// Обёртка над всем деревом приложения, которая умеет:
///  1. Пересоздать поддерево «начисто» (смена [Key] → Flutter выбрасывает и
///     заново строит дерево вместе со всеми BlocProvider/StatefulWidget). Нужно
///     при пересоздании DI (смена окружения/прокси в dev), иначе виджеты держали
///     бы старые ссылки на сервисы, захваченные в конструкторах.
///  2. Показать поверх дерева полноэкранную заставку «Применение…» ([overlay])
///     на время применения настроек. Заставка живёт в этом же дереве (Stack),
///     поэтому не требует внешнего Overlay/Navigator-контекста.
///
/// Использование:
/// ```dart
/// RestartWidget(child: MyApp());
/// // показать заставку:
/// RestartWidget.showOverlay(context, const ApplyingOverlay());
/// // пересоздать дерево (и убрать заставку):
/// RestartWidget.restartApp(context);
/// ```
class RestartWidget extends StatefulWidget {
  const RestartWidget({required this.child, super.key});

  final Widget child;

  /// Хендл на состояние — стабилен между reset/init DI (RestartWidget сам не
  /// пересоздаётся при рестарте поддерева), поэтому надёжнее, чем искать по
  /// context после `getIt.reset()`, когда старый navigator-контекст мог
  /// «отвязаться».
  static _RestartWidgetState? _current;

  /// Пересоздать всё дерево. Заодно скрывает заставку (новое дерево строится
  /// без неё).
  static void restartApp() => _current?.restart();

  /// Показать полноэкранную заставку поверх дерева (без рестарта).
  static void showOverlay(Widget overlay) => _current?.showOverlay(overlay);

  /// Скрыть заставку.
  static void hideOverlay() => _current?.hideOverlay();

  @override
  State<RestartWidget> createState() => _RestartWidgetState();
}

class _RestartWidgetState extends State<RestartWidget> {
  Key _key = UniqueKey();
  Widget? _overlay;

  @override
  void initState() {
    super.initState();
    RestartWidget._current = this;
  }

  @override
  void dispose() {
    if (identical(RestartWidget._current, this)) RestartWidget._current = null;
    super.dispose();
  }

  void restart() => setState(() {
    _key = UniqueKey();
    _overlay = null;
  });

  void showOverlay(Widget overlay) => setState(() => _overlay = overlay);

  void hideOverlay() => setState(() => _overlay = null);

  @override
  Widget build(BuildContext context) {
    final child = KeyedSubtree(key: _key, child: widget.child);
    if (_overlay == null) return child;

    // Directionality/Material — заставка выше MaterialApp, у неё нет наследуемых
    // Directionality и Material-контекста, задаём их явно.
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Stack(
        fit: StackFit.expand,
        children: [
          child,
          Material(type: MaterialType.transparency, child: _overlay),
        ],
      ),
    );
  }
}
