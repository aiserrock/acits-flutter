import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';

import 'package:acits_flutter/res/color.dart';
import 'package:acits_flutter/util/app_version.dart';
import 'package:acits_flutter/util/web_insets/web_insets.dart';

/// Текстовая метка версии приложения (`v0.7.0 (20)`).
///
/// Используется под формой логина и в личной шторке (profile). Если версия ещё
/// не загружена ([AppVersion.load] в main) — виджет схлопывается в пустое место.
class AppVersionLabel extends StatelessWidget {
  const AppVersionLabel({super.key, this.style});

  final TextStyle? style;

  @override
  Widget build(BuildContext context) {
    final label = AppVersion.label;
    if (label.isEmpty) return const SizedBox.shrink();
    // На web под меткой версии — safe-area диагностика (временно): видно, что
    // возвращает библиотека insets на реальном устройстве.
    final debug = kIsWeb ? WebInsets.debugInfo : '';
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          label,
          textAlign: TextAlign.center,
          style: style ?? const TextStyle(fontSize: 12.0, color: ColorRes.textSecondary),
        ),
        if (debug.isNotEmpty)
          Text(
            debug,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 10.0, color: ColorRes.textSecondary),
          ),
      ],
    );
  }
}
