import 'package:flutter/material.dart';
import 'package:ui_kit/ui_kit.dart';

/// Модальные шторки: [showUiBottomSheet] (M3) и [bsSelectorActions]
/// (iOS-style список действий с «Отмена»).
class BottomSheetPage extends StatelessWidget {
  const BottomSheetPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('BottomSheet')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            PrimaryButton(
              text: 'showUiBottomSheet',
              isFill: false,
              onPressed: () => showUiBottomSheet<void>(
                context: context,
                builder: (_) => const Padding(
                  padding: EdgeInsets.all(24.0),
                  child: Text('Содержимое шторки', textAlign: TextAlign.center),
                ),
              ),
            ),
            const SizedBox(height: 16.0),
            PrimaryButton(
              text: 'bsSelectorActions',
              isFill: false,
              onPressed: () => showUiBottomSheet<void>(
                context: context,
                builder: (sheetContext) => bsSelectorActions(sheetContext, {
                  const Text('Редактировать'): () => Navigator.pop(sheetContext),
                  const Text('Поделиться'): () => Navigator.pop(sheetContext),
                  const Text('Удалить'): () => Navigator.pop(sheetContext),
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
