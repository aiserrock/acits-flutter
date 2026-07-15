import 'dart:typed_data';

import 'package:acits_flutter/service/document/doc_exporter/doc_exporter.dart';
import 'package:acits_flutter/service/document/pdf_doc_mixin.dart';
import 'package:acits_flutter/ui/screen/doc_viewer/cubit/doc_viewer_cubit.dart';
import 'package:acits_flutter/ui/widget/button.dart';
import 'package:acits_flutter/ui/widget/error_holder.dart';
import 'package:acits_flutter/ui/widget/loader.dart';
import 'package:acits_flutter/util/data_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pdfx/pdfx.dart';

/// Экран просмотра PDF-документа с кнопкой «Поделиться». Работает на всех
/// платформах: PDF рендерится из байтов (`PdfDocument.openData`), шаринг —
/// через кроссплатформенный [DocExporter].
class DocViewerScreen extends StatelessWidget {
  const DocViewerScreen(this.fetcher, {this.title, this.fileName, super.key});

  final PdfDocFetcher fetcher;

  final String? title;

  /// Имя файла для «Поделиться»/скачивания (например, «animal_42.pdf»).
  final String? fileName;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => DocViewerCubit(fetcher),
      child: _DocViewerView(title: title, fileName: fileName),
    );
  }
}

class _DocViewerView extends StatefulWidget {
  const _DocViewerView({this.title, this.fileName});

  final String? title;
  final String? fileName;

  @override
  State<_DocViewerView> createState() => _DocViewerViewState();
}

class _DocViewerViewState extends State<_DocViewerView> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _exporter = DocExporter();

  PdfControllerPinch? _controller;
  Uint8List? _controllerBytes;

  /// Поворот в альбомную ориентацию (toggle 0° ↔ 90°) для широких PDF.
  bool _landscape = false;

  static const _zoomStep = 1.4; // множитель на нажатие кнопки +/−
  static const _minScale = 1.0; // 100% — минимум
  static const _maxScale = 2.0; // 200% — максимум

  /// Флаг, пока clamp сам меняет матрицу — иначе listener зациклится.
  bool _clamping = false;

  @override
  void dispose() {
    _controller?.removeListener(_onTransform);
    _controller?.dispose();
    super.dispose();
  }

  /// На любое изменение матрицы (в т.ч. pinch) держим масштаб в пределах.
  void _onTransform() {
    if (_clamping) return;
    _applyScale(1.0); // 1.0 = ничего не множим, только клэмпим текущий
  }

  void _toggleRotate() => setState(() => _landscape = !_landscape);

  void _zoomBy(double factor) => _applyScale(factor);

  /// Множит текущий масштаб на [factor] и клэмпит в [_minScale, _maxScale]
  /// относительно центра вьюпорта. factor=1.0 — только клэмп без изменения.
  void _applyScale(double factor) {
    final controller = _controller;
    final size = context.size;
    if (controller == null || size == null) return;
    final center = Offset(size.width / 2, size.height / 2);

    final current = controller.value.getMaxScaleOnAxis();
    final target = (current * factor).clamp(_minScale, _maxScale);
    final applied = target / current;
    if ((applied - 1).abs() < 0.001) return; // уже в пределах — не трогаем

    _clamping = true;
    controller.value = controller.value.clone()
      ..translateByDouble(center.dx, center.dy, 0, 1)
      ..scaleByDouble(applied, applied, 1, 1)
      ..translateByDouble(-center.dx, -center.dy, 0, 1);
    _clamping = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.surface,
        shadowColor: Colors.transparent,
        leading: GestureDetector(
          child: Icon(Icons.arrow_back_ios, color: Theme.of(context).colorScheme.primary),
          onTap: () => Navigator.of(context).pop(),
        ),
        title: Text(widget.title ?? 'Doc viewer', style: TextStyle(color: Theme.of(context).colorScheme.onSurface)),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(
              _landscape ? Icons.rotate_90_degrees_ccw : Icons.rotate_90_degrees_cw,
              color: Theme.of(context).colorScheme.primary,
            ),
            tooltip: 'Rotate',
            onPressed: _toggleRotate,
          ),
        ],
      ),
      body: BlocBuilder<DocViewerCubit, DataState<Uint8List>>(
        builder: (context, state) => DataStateBuilder<Uint8List>(
          state: state,
          loader: (_) => const LoaderHolderWidget(),
          errorBuilder: (_, e) => ErrorHolderWidget(error: e, onPressed: context.read<DocViewerCubit>().fetchData),
          builder: (_, bytes) => _buildContent(bytes),
        ),
      ),
    );
  }

  String get _fileName {
    final name = widget.fileName ?? widget.title ?? 'document';
    return name.toLowerCase().endsWith('.pdf') ? name : '$name.pdf';
  }

  Widget _buildContent(Uint8List bytes) {
    final controller = _controllerFor(bytes);
    return Column(
      children: [
        Expanded(
          child: Stack(
            children: [
              // Поворот страницы внутри вьюпорта (не всего экрана). Pinch-zoom —
              // из коробки PdfViewPinch; кнопки +/− дублируют его для десктопа.
              Positioned.fill(
                child: RotatedBox(
                  quarterTurns: _landscape ? 1 : 0,
                  child: PdfViewPinch(controller: controller, minScale: _minScale, maxScale: _maxScale),
                ),
              ),
              Positioned(right: 12, bottom: 12, child: _zoomControls(bytes)),
            ],
          ),
        ),
        SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: PrimaryButton(
              child: const Text('Share'),
              onPressed: () => _exporter.share(bytes, fileName: _fileName, subject: widget.title),
            ),
          ),
        ),
      ],
    );
  }

  Widget _zoomControls(Uint8List bytes) {
    final scheme = Theme.of(context).colorScheme;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        FloatingActionButton.small(
          heroTag: 'zoom_in',
          backgroundColor: scheme.surface,
          foregroundColor: scheme.primary,
          onPressed: () => _zoomBy(_zoomStep),
          child: const Icon(Icons.add),
        ),
        const SizedBox(height: 8),
        FloatingActionButton.small(
          heroTag: 'zoom_out',
          backgroundColor: scheme.surface,
          foregroundColor: scheme.primary,
          onPressed: () => _zoomBy(1 / _zoomStep),
          child: const Icon(Icons.remove),
        ),
        const SizedBox(height: 8),
        FloatingActionButton.small(
          heroTag: 'download',
          backgroundColor: scheme.surface,
          foregroundColor: scheme.primary,
          onPressed: () => _exporter.download(bytes, fileName: _fileName),
          child: const Icon(Icons.download),
        ),
      ],
    );
  }

  /// Контроллер на набор байтов: пересоздаётся при смене документа (по ссылке).
  PdfControllerPinch _controllerFor(Uint8List bytes) {
    if (_controller == null || !identical(_controllerBytes, bytes)) {
      _controller?.removeListener(_onTransform);
      _controller?.dispose();
      _controller = PdfControllerPinch(document: PdfDocument.openData(bytes))..addListener(_onTransform);
      _controllerBytes = bytes;
    }
    return _controller!;
  }
}
