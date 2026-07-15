import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:pro_image_editor/pro_image_editor.dart';

/// Открыть редактор фото поверх текущего экрана.
///
/// Возвращает отредактированные байты (зум/поворот/обрезка) или `null`, если
/// пользователь отменил. Работает одинаково в web (PWA, CanvasKit) и mobile —
/// всё на [Uint8List], без нативных плагинов и dart:io.
Future<Uint8List?> openPhotoEditor(BuildContext context, Uint8List source) {
  return Navigator.of(context).push<Uint8List>(
    MaterialPageRoute<Uint8List>(
      fullscreenDialog: true,
      builder: (_) => PhotoEditorScreen(source: source),
    ),
  );
}

/// Экран редактирования фото поверх [ProImageEditor].
///
/// Включён только crop/rotate (+ пинч-зум и зум двойным тапом в главном
/// редакторе). Остальные редакторы (paint/text/filter/blur/emoji/sticker/tune)
/// выключены — нужны только кадрирование, поворот и приближение.
class PhotoEditorScreen extends StatelessWidget {
  const PhotoEditorScreen({required this.source, super.key});

  final Uint8List source;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return ProImageEditor.memory(
      source,
      callbacks: ProImageEditorCallbacks(
        // Готовые байты кадрированного/повёрнутого фото. Отдаём их наверх через
        // pop — openPhotoEditor резолвится этим значением.
        onImageEditingComplete: (bytes) async {
          if (context.mounted) Navigator.of(context).pop(bytes);
        },
        // Крестик/назад без сохранения — отмена (openPhotoEditor -> null).
        onCloseEditor: (mode) {
          if (context.mounted) Navigator.of(context).pop();
        },
      ),
      configs: ProImageEditorConfigs(
        // Пинч-зум и зум двойным тапом по фото — главное требование. tools
        // оставляет в UI только crop/rotate, остальные редакторы скрыты.
        mainEditor: const MainEditorConfigs(
          enableZoom: true,
          enableDoubleTapZoom: true,
          tools: [SubEditorMode.cropRotate],
        ),
        cropRotateEditor: const CropRotateEditorConfigs(enableDoubleTap: true),
        theme: ThemeData.dark().copyWith(colorScheme: scheme),
      ),
    );
  }
}
