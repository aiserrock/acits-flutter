import 'dart:async';

import 'package:acits_flutter/generated/l10n.dart';
import 'package:flutter/foundation.dart';

/// Выполняет действие на следующем кадре рендера
void proceedOnNextFrame(VoidCallback callback) async {
  return Future.delayed(const Duration(milliseconds: 16), callback);
}

/// Алиас для доступа к текущей локализации
StringRes get l10n => StringRes.current;
