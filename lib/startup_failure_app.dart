import 'dart:ui' show PlatformDispatcher;

import 'package:material_ui/material_ui.dart';

/// Shown when the startup pipeline throws before the app can run (DI,
/// localization or storage failed). Without it the native splash would stay on
/// screen forever.
///
/// It cannot rely on anything the pipeline sets up: no DI, no easy_localization,
/// no theme from ui_kit. Texts follow the system language (Russian or English).
class StartupFailureApp extends StatelessWidget {
  const StartupFailureApp({required this.onRetry, super.key});

  /// Runs the startup pipeline again.
  final Future<void> Function() onRetry;

  @override
  Widget build(BuildContext context) {
    final ru = PlatformDispatcher.instance.locale.languageCode == 'ru';
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(colorSchemeSeed: const Color(0xFF6776E0), useMaterial3: true),
      darkTheme: ThemeData(colorSchemeSeed: const Color(0xFF6776E0), brightness: Brightness.dark, useMaterial3: true),
      home: _StartupFailureView(ru: ru, onRetry: onRetry),
    );
  }
}

class _StartupFailureView extends StatefulWidget {
  const _StartupFailureView({required this.ru, required this.onRetry});

  final bool ru;
  final Future<void> Function() onRetry;

  @override
  State<_StartupFailureView> createState() => _StartupFailureViewState();
}

class _StartupFailureViewState extends State<_StartupFailureView> {
  bool _retrying = false;

  Future<void> _retry() async {
    setState(() => _retrying = true);
    try {
      await widget.onRetry();
    } finally {
      if (mounted) setState(() => _retrying = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final ru = widget.ru;
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 420),
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.error_outline, size: 64, color: theme.colorScheme.error),
                  const SizedBox(height: 16),
                  Text(
                    ru ? 'Не удалось запустить приложение' : 'The app could not start',
                    textAlign: TextAlign.center,
                    style: theme.textTheme.titleLarge,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    ru
                        ? 'Попробуйте ещё раз. Если ошибка повторяется, перезапустите приложение или обновите его.'
                        : 'Please try again. If it keeps happening, restart or update the app.',
                    textAlign: TextAlign.center,
                    style: theme.textTheme.bodyMedium,
                  ),
                  const SizedBox(height: 24),
                  if (_retrying)
                    const CircularProgressIndicator()
                  else
                    FilledButton(onPressed: _retry, child: Text(ru ? 'Повторить' : 'Try again')),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
