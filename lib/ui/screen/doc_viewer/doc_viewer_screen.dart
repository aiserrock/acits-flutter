import 'dart:typed_data';

import 'package:acits_flutter/res/color.dart';
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

  /// Поворот страницы на экране: 0/1/2/3 четверти (0°/90°/180°/270°). Крутится
  /// сама страница внутри вьюпорта — экран не вращается. Нужно для альбомных
  /// PDF, которые иначе показываются мелко по центру.
  int _quarterTurns = 0;

  /// Множитель зума на одно нажатие кнопки +/−.
  static const _zoomStep = 1.4;

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  void _rotate() => setState(() => _quarterTurns = (_quarterTurns + 1) % 4);

  /// Масштабирует относительно центра вьюпорта: сдвигаем к центру, множим,
  /// сдвигаем обратно. Клэмпим в пределах min/max scale просмотрщика.
  void _zoomBy(double factor) {
    final controller = _controller;
    if (controller == null) return;

    final size = context.size;
    if (size == null) return;
    final center = Offset(size.width / 2, size.height / 2);

    final current = controller.value.getMaxScaleOnAxis();
    final target = (current * factor).clamp(1.0, 20.0);
    final applied = target / current;
    if ((applied - 1).abs() < 0.001) return;

    controller.value = controller.value.clone()
      ..translateByDouble(center.dx, center.dy, 0, 1)
      ..scaleByDouble(applied, applied, 1, 1)
      ..translateByDouble(-center.dx, -center.dy, 0, 1);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: ColorRes.foreground,
        shadowColor: Colors.transparent,
        leading: GestureDetector(
          child: const Icon(Icons.arrow_back_ios, color: ColorRes.accent),
          onTap: () => Navigator.of(context).pop(),
        ),
        title: Text(
          widget.title ?? 'Doc viewer',
          style: const TextStyle(color: ColorRes.textPrimary),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.rotate_90_degrees_cw, color: ColorRes.accent),
            tooltip: 'Rotate',
            onPressed: _rotate,
          ),
        ],
      ),
      body: BlocBuilder<DocViewerCubit, DataState<Uint8List>>(
        builder: (context, state) => DataStateBuilder<Uint8List>(
          state: state,
          loader: (_) => const LoaderHolderWidget(),
          errorBuilder: (_, e) =>
              ErrorHolderWidget(error: e, onPressed: context.read<DocViewerCubit>().fetchData),
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
              // RotatedBox поворачивает страницу внутри вьюпорта (не сам экран),
              // чтобы альбомный PDF занял всю ширину. Pinch-to-zoom — из коробки
              // PdfViewPinch; кнопки +/− дублируют зум для десктопа без тача.
              Positioned.fill(
                child: RotatedBox(
                  quarterTurns: _quarterTurns,
                  child: PdfViewPinch(controller: controller),
                ),
              ),
              Positioned(right: 12, bottom: 12, child: _zoomControls()),
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

  Widget _zoomControls() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        FloatingActionButton.small(
          heroTag: 'zoom_in',
          backgroundColor: ColorRes.foreground,
          foregroundColor: ColorRes.accent,
          onPressed: () => _zoomBy(_zoomStep),
          child: const Icon(Icons.add),
        ),
        const SizedBox(height: 8),
        FloatingActionButton.small(
          heroTag: 'zoom_out',
          backgroundColor: ColorRes.foreground,
          foregroundColor: ColorRes.accent,
          onPressed: () => _zoomBy(1 / _zoomStep),
          child: const Icon(Icons.remove),
        ),
      ],
    );
  }

  /// Создаёт `PdfControllerPinch` один раз на набор байтов; при смене документа
  /// старый диспозится. Идентичность — по ссылке на байты (fetcher отдаёт новый
  /// Uint8List на каждую загрузку), без побайтового хэша на каждый ребилд.
  PdfControllerPinch _controllerFor(Uint8List bytes) {
    if (_controller == null || !identical(_controllerBytes, bytes)) {
      _controller?.dispose();
      _controller = PdfControllerPinch(document: PdfDocument.openData(bytes));
      _controllerBytes = bytes;
    }
    return _controller!;
  }
}
