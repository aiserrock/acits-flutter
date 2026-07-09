import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:acits_flutter/service/debug/debug_service.dart';

import '../../di/di_container.dart';
import 'debug_floating_button.dart';

/// Рисует поверх приложения плавающую debug-кнопку (dev-сборка). Передаётся в
/// `MaterialApp.builder` через `AcitsApp.overlayBuilder`, поэтому [child] уже
/// внутри MaterialApp (есть MediaQuery/Directionality). Кнопка видна только в
/// debug mode; long-press скрывает её до перезапуска.
class DebugOverlay extends StatefulWidget {
  const DebugOverlay({required this.child, super.key});

  final Widget child;

  @override
  State<DebugOverlay> createState() => _DebugOverlayState();
}

class _DebugOverlayState extends State<DebugOverlay> {
  bool _visible = true;

  @override
  Widget build(BuildContext context) {
    if (!kDebugMode) return widget.child;

    return Stack(
      children: [
        widget.child,
        if (_visible)
          DebugFloatingButton(
            onTap: () => getIt<DebugService>().openDebugScreen(),
            onLongPress: () => setState(() => _visible = false),
          ),
      ],
    );
  }
}
