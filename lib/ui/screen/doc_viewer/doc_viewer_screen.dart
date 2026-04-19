import 'dart:io';

import 'package:acits_flutter/res/color.dart';
import 'package:acits_flutter/service/document/pdf_doc_mixin.dart';
import 'package:acits_flutter/ui/widget/button.dart';
import 'package:acits_flutter/ui/widget/error_holder.dart';
import 'package:acits_flutter/ui/widget/loader.dart';
import 'package:acits_flutter/util/util.dart';
import 'package:flutter/material.dart';
import 'package:pdfx/pdfx.dart';
import 'package:share_plus/share_plus.dart';

class DocViewerScreen extends StatefulWidget {
  const DocViewerScreen(this.fetcher, {this.title, super.key});

  final PdfDocFetcher fetcher;

  final String? title;

  @override
  State<DocViewerScreen> createState() => _DocViewerScreenState();
}

class _DocViewerScreenState extends State<DocViewerScreen> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  var _state = ScreenDataState<File>()..loading();
  PdfController? _controller;

  @override
  void initState() {
    super.initState();

    _fetchData();
  }

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
      body: StateBuilder<File>(
        state: _state,
        builder: (_, file) {
          final controller = PdfController(document: PdfDocument.openFile(file.absolute.path));
          _controller = controller;
          return Column(
            children: [
              Expanded(child: PdfView(controller: controller)),
              SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: PrimaryButton(
                    child: const Text('Share'),
                    onPressed: () => Share.shareXFiles([XFile(file.absolute.path)]),
                  ),
                ),
              ),
            ],
          );
        },
        loader: (_) => const LoaderHolderWidget(),
        errorBuilder: (_, e) {
          return ErrorHolderWidget(error: e, onPressed: _fetchData);
        },
      ),
    );
  }

  void _fetchData() {
    setState(() {
      _state = ScreenDataState()..loading();
    });

    widget.fetcher
        .call()
        .then(
          (file) => setState(() {
            _state = ScreenDataState(file);
          }),
        )
        .catchError((e) {
          setState(() => _state = ScreenDataState()..error = e);
        });
  }
}
