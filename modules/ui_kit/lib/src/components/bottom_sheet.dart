import 'package:flutter/material.dart';

/// Показ M3-модального bottom sheet с токен-ориентированными скруглениями.
/// Фон/тень приходят из темы; здесь фиксируется форма верхних углов.
Future<T?> showUiBottomSheet<T>({
  required BuildContext context,
  required WidgetBuilder builder,
  bool isScrollControlled = false,
}) {
  return showModalBottomSheet<T>(
    context: context,
    isScrollControlled: isScrollControlled,
    backgroundColor: Theme.of(context).colorScheme.surfaceContainerLow,
    shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(16.0))),
    builder: (context) => SafeArea(child: builder(context)),
  );
}
