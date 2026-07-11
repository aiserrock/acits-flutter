import 'package:flutter/material.dart';

/// Обёртка, позволяющая пересоздать всё поддерево виджетов «начисто».
///
/// Меняет [Key] у поддерева → Flutter выбрасывает и заново строит всё дерево,
/// вместе со всеми BlocProvider/StatefulWidget. Нужно, когда пересоздаются
/// DI-зависимости (смена окружения/прокси в dev): иначе виджеты продолжали бы
/// держать старые ссылки на сервисы, захваченные в конструкторах.
///
/// Использование:
/// ```dart
/// RestartWidget(child: MyApp());
/// // ...откуда угодно:
/// RestartWidget.restartApp(context);
/// ```
class RestartWidget extends StatefulWidget {
  const RestartWidget({required this.child, super.key});

  final Widget child;

  static void restartApp(BuildContext context) {
    context.findAncestorStateOfType<_RestartWidgetState>()?.restart();
  }

  @override
  State<RestartWidget> createState() => _RestartWidgetState();
}

class _RestartWidgetState extends State<RestartWidget> {
  Key _key = UniqueKey();

  void restart() => setState(() => _key = UniqueKey());

  @override
  Widget build(BuildContext context) {
    return KeyedSubtree(key: _key, child: widget.child);
  }
}
