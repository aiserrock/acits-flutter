import 'package:acits_flutter/di/di_container.dart';
import 'package:acits_flutter/ui/screen/debug_screen/debug_screen.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

@Singleton(as: DebugService)
class DebugService {
  void openDebugScreen() {
    final navigator = getIt<GlobalKey<NavigatorState>>();

    navigator.currentState
        ?.push(MaterialPageRoute(builder: (_) => const DebugScreen()));
  }
}
