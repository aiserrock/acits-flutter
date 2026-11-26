import 'package:flutter/services.dart';
import 'package:util/util.dart';
import 'package:ui_kit/ui_kit.dart';
import 'package:material_ui/material_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pdfx/pdfx.dart';

import 'package:media/domain/domain.dart';
import 'package:media/presentation/doc_viewer/cubit/cubit.dart';
import 'package:media/util/util.dart';

/// Экран просмотра PDF-документа с кнопкой «Поделиться». Работает на всех
/// платформах: PDF рендерится из байтов (`PdfDocument.openData`), шаринг —
/// через кроссплатформенный [DocExporterPort].
class DocViewerScreen extends StatelessWidget {
  const DocViewerScreen(
    this.fetcher, {
    required this.exporter,
    required this.pdfjsReady,
    this.title,
    this.fileName,
    super.key,
  });

  final PdfDocFetcher fetcher;

  final DocExporterPort exporter;
  final PdfjsReadyPort pdfjsReady;

  final String? title;

  /// Имя файла для «Поделиться»/скачивания (например, «animal_42.pdf»).
  final String? fileName;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => DocViewerCubit(fetcher, pdfjsReady),
      child: _DocViewerView(title: title, fileName: fileName, exporter: exporter),
    );
  }
}

class _DocViewerView extends StatefulWidget {
  const _DocViewerView({required this.exporter, this.title, this.fileName});

  final DocExporterPort exporter;
  final String? title;
  final String? fileName;

  @override
  State<_DocViewerView> createState() => _DocViewerViewState();
}

class _DocViewerViewState extends State<_DocViewerView> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  PdfControllerPinch? _controller;
  Uint8List? _controllerBytes;

  /// Поворот в альбомную ориентацию (toggle 0° ↔ 90°) для широких PDF.
  bool _landscape = false;

  static const _zoomStep = 1.4; // множитель на нажатие кнопки +/−
  static const _minScale = 1.0; // 100% — минимум
  static const _maxScale = 2.0; // 200% — максимум

  /// Флаг, пока clamp сам меняет матрицу — иначе listener зациклится.
  bool _clamping = false;

  DocExporterPort get _exporter => widget.exporter;

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

  /// Страницы доступны, когда документ загружен и вьюпорт привязан к контроллеру
  /// (до этого `page`/`nextPage` читают неинициализированное состояние pdfx).
  bool get _pdfReady => _controller?.loadingState.value == PdfLoadingState.success;

  static const _pageDuration = Duration(milliseconds: 250);

  void _nextPage() {
    final controller = _controller;
    if (!_pdfReady || controller == null) return;
    controller.nextPage(duration: _pageDuration, curve: Curves.easeInOut);
  }

  void _previousPage() {
    final controller = _controller;
    if (!_pdfReady || controller == null) return;
    controller.previousPage(duration: _pageDuration, curve: Curves.easeInOut);
  }

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
    // На medium+ кнопки зума и страниц переезжают в AppBar (на телефоне зум —
    // pinch и FAB-кнопки, листание — прокрутка).
    final wide = WindowSize.fromWidth(MediaQuery.sizeOf(context).width) != WindowSize.compact;
    final l10n = MaterialLocalizations.of(context);
    final primary = Theme.of(context).colorScheme.primary;
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.surface,
        shadowColor: Colors.transparent,
        leading: IconButton(
          tooltip: MaterialLocalizations.of(context).backButtonTooltip,
          onPressed: () => Navigator.of(context).pop(),
          icon: Icon(Icons.arrow_back_ios, color: Theme.of(context).colorScheme.primary),
        ),
        title: Text(widget.title ?? 'Doc viewer', style: TextStyle(color: Theme.of(context).colorScheme.onSurface)),
        centerTitle: true,
        actions: [
          if (wide) ...[
            IconButton(
              icon: Icon(Icons.keyboard_arrow_up, color: primary),
              tooltip: l10n.previousPageTooltip,
              onPressed: _previousPage,
            ),
            IconButton(
              icon: Icon(Icons.keyboard_arrow_down, color: primary),
              tooltip: l10n.nextPageTooltip,
              onPressed: _nextPage,
            ),
            IconButton(
              icon: Icon(Icons.zoom_out, color: primary),
              tooltip: 'Zoom out',
              onPressed: () => _zoomBy(1 / _zoomStep),
            ),
            IconButton(
              icon: Icon(Icons.zoom_in, color: primary),
              tooltip: 'Zoom in',
              onPressed: () => _zoomBy(_zoomStep),
            ),
          ],
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
    final wide = WindowSize.fromWidth(MediaQuery.sizeOf(context).width) != WindowSize.compact;
    final content = Column(
      children: [
        Expanded(
          child: Stack(
            children: [
              // Поворот страницы внутри вьюпорта (не всего экрана). Pinch-zoom —
              // из коробки PdfViewPinch; кнопки +/− дублируют его для десктопа.
              // Ширина страницы ограничена колонкой ContentWidth.reading по центру.
              Positioned.fill(
                child: ContentWidth(
                  maxWidth: ContentWidth.reading,
                  alignment: Alignment.center,
                  child: RotatedBox(
                    quarterTurns: _landscape ? 1 : 0,
                    child: PdfViewPinch(controller: controller, minScale: _minScale, maxScale: _maxScale),
                  ),
                ),
              ),
              Positioned(right: 12, bottom: 12, child: _zoomControls(bytes, showZoom: !wide)),
            ],
          ),
        ),
        SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: PrimaryButton(child: const Text('Share'), onPressed: () => _onShare(bytes)),
          ),
        ),
      ],
    );
    // Клавиатура: +/− — зум, PageUp/PageDown и ←/→ — страницы.
    return CallbackShortcuts(
      bindings: {
        const SingleActivator(LogicalKeyboardKey.equal): () => _zoomBy(_zoomStep),
        const SingleActivator(LogicalKeyboardKey.equal, shift: true): () => _zoomBy(_zoomStep),
        const SingleActivator(LogicalKeyboardKey.add): () => _zoomBy(_zoomStep),
        const SingleActivator(LogicalKeyboardKey.numpadAdd): () => _zoomBy(_zoomStep),
        const SingleActivator(LogicalKeyboardKey.minus): () => _zoomBy(1 / _zoomStep),
        const SingleActivator(LogicalKeyboardKey.numpadSubtract): () => _zoomBy(1 / _zoomStep),
        const SingleActivator(LogicalKeyboardKey.pageDown): _nextPage,
        const SingleActivator(LogicalKeyboardKey.arrowRight): _nextPage,
        const SingleActivator(LogicalKeyboardKey.pageUp): _previousPage,
        const SingleActivator(LogicalKeyboardKey.arrowLeft): _previousPage,
      },
      child: Focus(autofocus: true, child: content),
    );
  }

  /// Шаринг с полным трейлом в Talker: клик → размер → исход/ошибка.
  /// Юзер копирует лог из TalkerScreen и отдаёт для диагностики.
  Future<void> _onShare(Uint8List bytes) async {
    Log.info(
      '[doc_viewer] нажат Share: file=$_fileName size=${bytes.lengthInBytes}B '
      'title=${widget.title} landscape=$_landscape',
    );
    try {
      await _exporter.share(bytes, fileName: _fileName, subject: widget.title);
      Log.info('[doc_viewer] share завершён: $_fileName');
    } catch (e, s) {
      Log.error('[doc_viewer] share упал: $_fileName', e, s);
    }
  }

  Future<void> _onDownload(Uint8List bytes) async {
    Log.info('[doc_viewer] нажат Download: file=$_fileName size=${bytes.lengthInBytes}B');
    try {
      await _exporter.download(bytes, fileName: _fileName);
      Log.info('[doc_viewer] download завершён: $_fileName');
    } catch (e, s) {
      Log.error('[doc_viewer] download упал: $_fileName', e, s);
    }
  }

  Widget _zoomControls(Uint8List bytes, {required bool showZoom}) {
    final scheme = Theme.of(context).colorScheme;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (showZoom) ...[
          FloatingActionButton.small(
            heroTag: 'zoom_in',
            tooltip: 'Zoom in',
            backgroundColor: scheme.surface,
            foregroundColor: scheme.primary,
            onPressed: () => _zoomBy(_zoomStep),
            child: const Icon(Icons.add),
          ),
          const SizedBox(height: 8),
          FloatingActionButton.small(
            heroTag: 'zoom_out',
            tooltip: 'Zoom out',
            backgroundColor: scheme.surface,
            foregroundColor: scheme.primary,
            onPressed: () => _zoomBy(1 / _zoomStep),
            child: const Icon(Icons.remove),
          ),
          const SizedBox(height: 8),
        ],
        FloatingActionButton.small(
          heroTag: 'download',
          tooltip: 'Download',
          backgroundColor: scheme.surface,
          foregroundColor: scheme.primary,
          onPressed: () => _onDownload(bytes),
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
      // ВАЖНО: на web pdfx передаёт буфер в pdf.js как transferable — исходный
      // Uint8List становится detached (length=0). Отдаём КОПИЮ, чтобы `bytes`
      // остался целым для share/download.
      _controller = PdfControllerPinch(document: PdfDocument.openData(Uint8List.fromList(bytes)))
        ..addListener(_onTransform);
      _controllerBytes = bytes;
    }
    return _controller!;
  }
}
