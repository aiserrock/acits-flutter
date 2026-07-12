import 'package:flutter/material.dart';

import 'package:acits_flutter/service/debug/debug_service.dart';

import '../../di/di_container.dart';
import '../../service/debug/debug_dev_service.dart';
import 'debug_floating_button.dart';

/// Рисует поверх приложения плавающую debug-кнопку (dev-сборка). Передаётся в
/// `MaterialApp.builder` через `AcitsApp.overlayBuilder`, поэтому [child] уже
/// внутри MaterialApp (есть MediaQuery/Directionality). Кнопка видна во ВСЕХ
/// режимах dev-флейвора (включая release-web на GitHub Pages — это сборка для
/// разработчиков). В prod этот класс не попадает вовсе (подключается только в
/// test/dev/main.dart).
///
/// Видимость — через `DebugDevService.debugButtonStream` (по образцу
/// a production app): long-press скрывает кнопку, открытие debug-экрана скрывает её
/// на время экрана и возвращает после закрытия.
class DebugOverlay extends StatelessWidget {
  const DebugOverlay({required this.child, super.key});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final debug = getIt<DebugService>() as DebugDevService;

    return Stack(
      children: [
        child,
        StreamBuilder<bool>(
          initialData: true,
          stream: debug.debugButtonStream,
          builder: (context, snapshot) {
            if (!snapshot.requireData) return const SizedBox.shrink();
            return DebugFloatingButton(
              onTap: debug.openDebugScreen,
              onLongPress: debug.hideDebugButton,
            );
          },
        ),
      ],
    );
  }
}
