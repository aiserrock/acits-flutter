import 'package:flutter/material.dart';

import 'package:acits_flutter/service/debug/debug_service.dart';

import '../../di/di_container.dart';
import 'debug_floating_button.dart';

/// Рисует поверх приложения плавающую debug-кнопку (dev-сборка). Передаётся в
/// `MaterialApp.builder` через `AcitsApp.overlayBuilder`, поэтому [child] уже
/// внутри MaterialApp (есть MediaQuery/Directionality). Кнопка видна во ВСЕХ
/// режимах dev-флейвора (включая release-web на GitHub Pages — это сборка для
/// разработчиков); long-press скрывает её до перезапуска. В prod этот класс
/// не попадает вовсе (подключается только в test/dev/main.dart).
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
