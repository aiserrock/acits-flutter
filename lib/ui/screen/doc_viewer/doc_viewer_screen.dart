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

  PdfController? _controller;
  Uint8List? _controllerBytes;

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
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
        Expanded(child: PdfView(controller: controller)),
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

  /// Создаёт `PdfController` один раз на набор байтов; при смене документа
  /// старый диспозится. Идентичность — по ссылке на байты (fetcher отдаёт новый
  /// Uint8List на каждую загрузку), без побайтового хэша на каждый ребилд.
  PdfController _controllerFor(Uint8List bytes) {
    if (_controller == null || !identical(_controllerBytes, bytes)) {
      _controller?.dispose();
      _controller = PdfController(document: PdfDocument.openData(bytes));
      _controllerBytes = bytes;
    }
    return _controller!;
  }
}
