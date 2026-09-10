// Генератор фирменной иконки запуска «ACITS UI Kit».
//
// Запуск: `fvm flutter test tool/gen_icon.dart`
// (используем test-раннер ради живого Flutter engine и доступа к `dart:ui`).
//
// Пишет два PNG в assets/branding/:
//   • icon.png            — 1024², акцентный градиент #6776E0 + белая монограмма
//                           «A» (фон для iOS/web).
//   • icon_foreground.png — 1024², только монограмма на прозрачном фоне
//                           (передний план Android adaptive icon).
import 'dart:io';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

const _brand = Color(0xFF6776E0);
const _brandDark = Color(0xFF4B5AC4);

Future<void> _writePng(String path, ui.Image image) async {
  final data = await image.toByteData(format: ui.ImageByteFormat.png);
  await File(path).writeAsBytes(data!.buffer.asUint8List());
}

/// Рисует монограмму «A» как две сходящиеся штанги + перекладину — фирменный,
/// геометричный, без зависимости от установленных шрифтов (стабильно в CI).
void _paintMonogram(Canvas canvas, double size, Color color) {
  final stroke = size * 0.11;
  final paint = Paint()
    ..color = color
    ..style = PaintingStyle.stroke
    ..strokeWidth = stroke
    ..strokeCap = StrokeCap.round
    ..strokeJoin = StrokeJoin.round;

  final cx = size / 2;
  final top = size * 0.26;
  final bottom = size * 0.74;
  final halfSpan = size * 0.20;

  final apex = Offset(cx, top);
  final left = Offset(cx - halfSpan, bottom);
  final right = Offset(cx + halfSpan, bottom);

  canvas.drawPath(
    Path()
      ..moveTo(left.dx, left.dy)
      ..lineTo(apex.dx, apex.dy)
      ..lineTo(right.dx, right.dy),
    paint,
  );

  // Перекладина на ~62% высоты.
  final barY = top + (bottom - top) * 0.62;
  final barHalf = halfSpan * (barY - top) / (bottom - top);
  canvas.drawLine(Offset(cx - barHalf, barY), Offset(cx + barHalf, barY), paint);
}

void main() {
  test('generate ACITS UI Kit launcher icon', () async {
    const size = 1024.0;

    // --- icon.png: градиентная плитка + белая монограмма ---
    final recorder = ui.PictureRecorder();
    final canvas = Canvas(recorder);
    final rect = const Rect.fromLTWH(0, 0, size, size);
    canvas.drawRect(
      rect,
      Paint()
        ..shader = const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [_brand, _brandDark],
        ).createShader(rect),
    );
    _paintMonogram(canvas, size, Colors.white);
    final withBg = await recorder.endRecording().toImage(size.toInt(), size.toInt());
    await _writePng('assets/branding/icon.png', withBg);

    // --- icon_foreground.png: монограмма на прозрачном (adaptive foreground) ---
    // Adaptive icon обрезает ~1/3 по краям → рисуем крупнее в safe-zone центра.
    final fgRecorder = ui.PictureRecorder();
    final fgCanvas = Canvas(fgRecorder);
    _paintMonogram(fgCanvas, size, Colors.white);
    final fg = await fgRecorder.endRecording().toImage(size.toInt(), size.toInt());
    await _writePng('assets/branding/icon_foreground.png', fg);

    expect(File('assets/branding/icon.png').existsSync(), isTrue);
    expect(File('assets/branding/icon_foreground.png').existsSync(), isTrue);
  });
}
