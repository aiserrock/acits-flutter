import 'dart:async';

import 'package:flutter/foundation.dart';

/// Выполняет действие на следующем кадре рендера
void proceedOnNextFrame(VoidCallback callback) async {
  return Future.delayed(const Duration(milliseconds: 16), callback);
}
