import 'package:flutter/material.dart';

import 'package:acits_flutter/res/theme.dart';
import 'package:acits_flutter/util/app_version.dart';

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
    return Text(
      label,
      textAlign: TextAlign.center,
      style: style ?? TextStyle(fontSize: 12.0, color: context.appColors.textSecondary),
    );
  }
}
