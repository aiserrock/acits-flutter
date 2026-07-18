import 'package:flutter_native_splash/flutter_native_splash.dart';

/// Нативная реализация: убирает нативный splash, который держался
/// `FlutterNativeSplash.preserve()` из `main()`.
void removeSplash() => FlutterNativeSplash.remove();
