import 'dart:typed_data';

import 'package:crop_your_image/crop_your_image.dart';
import 'package:flutter/material.dart';
import 'package:image/image.dart' as img;

/// Открыть редактор фото поверх текущего экрана.
///
/// Возвращает отредактированные байты (обрезанные/повёрнутые) или `null`, если
/// пользователь отменил. Работает одинаково в web и mobile — всё на [Uint8List],
/// без нативных плагинов и dart:io.
Future<Uint8List?> openPhotoEditor(BuildContext context, Uint8List source) {
  return Navigator.of(context).push<Uint8List>(
    MaterialPageRoute<Uint8List>(fullscreenDialog: true, builder: (_) => PhotoEditorScreen(source: source)),
  );
}

/// Экран редактирования фото: пинч-зум + пан (в web — колесо мыши), поворот 90°
/// кнопками и обрезка рамкой со свободным соотношением или пресетами.
///
/// Зум/пан и рамку обрезки обеспечивает [Crop] (`interactive: true`). Поворота в
/// пакете нет — крутим сами через `image.copyRotate` над байтами и подменяем их
/// в контроллере (`CropController.image`), что кросс-платформенно.
class PhotoEditorScreen extends StatefulWidget {
  const PhotoEditorScreen({required this.source, super.key});

  final Uint8List source;

  @override
  State<PhotoEditorScreen> createState() => _PhotoEditorScreenState();
}

class _PhotoEditorScreenState extends State<PhotoEditorScreen> {
  final _controller = CropController();

  /// Текущие байты, подаваемые в [Crop]. Меняются при повороте.
  late Uint8List _bytes = widget.source;

  /// Выбранный пресет соотношения сторон (null = свободное).
  double? _aspectRatio;

  /// Идёт ли операция обрезки/поворота (блокируем кнопки, показываем индикатор).
  bool _busy = false;

  static const _ratios = <_RatioPreset>[
    _RatioPreset('Свободно', null),
    _RatioPreset('1:1', 1.0),
    _RatioPreset('4:3', 4 / 3),
    _RatioPreset('16:9', 16 / 9),
  ];

  /// Повернуть исходные байты на [quarterTurns] * 90° и обновить контроллер.
  Future<void> _rotate(int quarterTurns) async {
    if (_busy) return;
    setState(() => _busy = true);
    try {
      final decoded = img.decodeImage(_bytes);
      if (decoded == null) return;
      final rotated = img.copyRotate(decoded, angle: 90 * quarterTurns);
      final newBytes = Uint8List.fromList(img.encodePng(rotated));
      _bytes = newBytes;
      _controller.image = newBytes; // подменяем без пересоздания виджета
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  void _setRatio(double? ratio) {
    setState(() => _aspectRatio = ratio);
    _controller.aspectRatio = ratio;
  }

  void _done() {
    if (_busy) return;
    setState(() => _busy = true);
    _controller.crop();
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        leading: IconButton(icon: const Icon(Icons.close), onPressed: _busy ? null : () => Navigator.of(context).pop()),
        actions: [
          TextButton(
            onPressed: _busy ? null : _done,
            child: Text(
              'Готово',
              style: TextStyle(color: _busy ? Colors.white38 : scheme.primary, fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: Crop(
              image: _bytes,
              controller: _controller,
              aspectRatio: _aspectRatio,
              interactive: true,
              baseColor: Colors.black,
              maskColor: Colors.black.withValues(alpha: .6),
              scrollZoomSensitivity: 0.05,
              cornerDotBuilder: (size, _) => DotControl(color: scheme.primary),
              progressIndicator: Center(child: CircularProgressIndicator(color: scheme.primary)),
              onCropped: (result) {
                switch (result) {
                  case CropSuccess(:final croppedImage):
                    if (mounted) Navigator.of(context).pop(croppedImage);
                  case CropFailure():
                    if (mounted) setState(() => _busy = false);
                }
              },
            ),
          ),
          _buildToolbar(scheme),
        ],
      ),
    );
  }

  Widget _buildToolbar(ColorScheme scheme) {
    return SafeArea(
      top: false,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: _busy ? null : () => _rotate(-1),
                  icon: const Icon(Icons.rotate_left, color: Colors.white),
                  tooltip: 'Повернуть влево',
                ),
                const SizedBox(width: 24.0),
                IconButton(
                  onPressed: _busy ? null : () => _rotate(1),
                  icon: const Icon(Icons.rotate_right, color: Colors.white),
                  tooltip: 'Повернуть вправо',
                ),
              ],
            ),
            const SizedBox(height: 8.0),
            Wrap(
              spacing: 8.0,
              children: _ratios.map((preset) {
                final selected = _aspectRatio == preset.value;
                return ChoiceChip(
                  label: Text(preset.label),
                  selected: selected,
                  onSelected: _busy ? null : (_) => _setRatio(preset.value),
                  labelStyle: TextStyle(color: selected ? scheme.onPrimary : Colors.white),
                  selectedColor: scheme.primary,
                  backgroundColor: Colors.white24,
                  showCheckmark: false,
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}

class _RatioPreset {
  const _RatioPreset(this.label, this.value);

  final String label;
  final double? value;
}
