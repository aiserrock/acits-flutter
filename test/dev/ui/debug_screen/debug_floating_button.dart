import 'package:flutter/material.dart';

/// Плавающая draggable-кнопка входа в дебаг-экран (dev-сборка).
/// Паттерн из app_sortman: перетаскивается по экрану, прилипает к ближайшему
/// краю. Tap — действие [onTap] (открыть DebugScreen), long-press — [onLongPress]
/// (скрыть кнопку).
class DebugFloatingButton extends StatefulWidget {
  const DebugFloatingButton({required this.onTap, required this.onLongPress, super.key});

  final VoidCallback onTap;
  final VoidCallback onLongPress;

  @override
  State<DebugFloatingButton> createState() => _DebugFloatingButtonState();
}

class _DebugFloatingButtonState extends State<DebugFloatingButton> {
  // Стартовая позиция — правый край, примерно на 60% высоты.
  Alignment _alignment = const Alignment(0.95, 0.4);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Positioned.fill(
      child: SafeArea(
        child: GestureDetector(
          onPanUpdate: (details) => _drag(details, size),
          onPanEnd: (_) => _snapToSide(),
          onTap: widget.onTap,
          onLongPress: widget.onLongPress,
          child: Align(
            alignment: _alignment,
            child: const DecoratedBox(
              decoration: BoxDecoration(color: Colors.green, shape: BoxShape.circle),
              child: SizedBox(
                height: 48,
                width: 48,
                child: Icon(Icons.bug_report, color: Colors.white),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _drag(DragUpdateDetails details, Size size) {
    setState(() {
      final dx = details.delta.dx / (size.width / 2);
      final dy = details.delta.dy / (size.height / 2);
      _alignment = Alignment(
        (_alignment.x + dx).clamp(-1.0, 1.0),
        (_alignment.y + dy).clamp(-1.0, 1.0),
      );
    });
  }

  // Прилипание к ближайшему боковому краю после отпускания.
  void _snapToSide() {
    setState(() {
      _alignment = Alignment(_alignment.x < 0 ? -0.95 : 0.95, _alignment.y);
    });
  }
}
