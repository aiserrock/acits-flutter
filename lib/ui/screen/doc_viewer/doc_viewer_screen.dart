import 'dart:io';

import 'package:acits_flutter/res/color.dart';
import 'package:acits_flutter/service/document/pdf_doc_mixin.dart';
import 'package:acits_flutter/ui/screen/doc_viewer/cubit/doc_viewer_cubit.dart';
import 'package:acits_flutter/ui/widget/button.dart';
import 'package:acits_flutter/ui/widget/error_holder.dart';
import 'package:acits_flutter/ui/widget/loader.dart';
import 'package:acits_flutter/util/data_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pdfx/pdfx.dart';
import 'package:share_plus/share_plus.dart';

/// Экран просмотра PDF-документа с кнопкой «Поделиться».
class DocViewerScreen extends StatelessWidget {
  const DocViewerScreen(this.fetcher, {this.title, super.key});

  final PdfDocFetcher fetcher;

  final String? title;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => DocViewerCubit(fetcher),
      child: _DocViewerView(title: title),
    );
  }
}

class _DocViewerView extends StatefulWidget {
  const _DocViewerView({this.title});

  final String? title;

  @override
  State<_DocViewerView> createState() => _DocViewerViewState();
}

class _DocViewerViewState extends State<_DocViewerView> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  PdfController? _controller;
  String? _controllerPath;

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
      body: BlocBuilder<DocViewerCubit, DataState<File>>(
        builder: (context, state) => DataStateBuilder<File>(
          state: state,
          loader: (_) => const LoaderHolderWidget(),
          errorBuilder: (_, e) =>
              ErrorHolderWidget(error: e, onPressed: context.read<DocViewerCubit>().fetchData),
          builder: (_, file) => _buildContent(file),
        ),
      ),
    );
  }

  Widget _buildContent(File file) {
    final controller = _controllerFor(file);
    return Column(
      children: [
        Expanded(child: PdfView(controller: controller)),
        SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: PrimaryButton(
              child: const Text('Share'),
              onPressed: () =>
                  SharePlus.instance.share(ShareParams(files: [XFile(file.absolute.path)])),
            ),
          ),
        ),
      ],
    );
  }

  /// Создаёт `PdfController` один раз на файл; при смене файла старый диспозится.
  PdfController _controllerFor(File file) {
    final path = file.absolute.path;
    if (_controller == null || _controllerPath != path) {
      _controller?.dispose();
      _controller = PdfController(document: PdfDocument.openFile(path));
      _controllerPath = path;
    }
    return _controller!;
  }
}
