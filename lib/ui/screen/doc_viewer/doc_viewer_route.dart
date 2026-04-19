import 'package:flutter/material.dart';

import 'package:acits_flutter/service/document/pdf_doc_mixin.dart';
import 'package:acits_flutter/ui/screen/doc_viewer/doc_viewer_screen.dart';

/// Отображение и шаринг PDF документа
class DocViewerScreenRoute extends MaterialPageRoute<bool> {
  DocViewerScreenRoute({required PdfDocFetcher fetcher, String? title})
    : super(builder: (_) => DocViewerScreen(fetcher, title: title));
}
