import 'dart:typed_data';

import 'package:acits_core/acits_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/pdf_doc_mixin.dart';
import '../../../domain/port/pdfjs_ready_port.dart';
import '../../../util/bloc_ext.dart';
import '../../../util/log.dart';

/// Cubit экрана просмотра PDF-документа.
///
/// Владеет состоянием загрузки [DataState] байтов PDF через [PdfDocFetcher].
/// Байты — единый кроссплатформенный формат (нет привязки к dart:io File).
/// UI-контроллер `PdfController` из pdfx остаётся во [StatefulWidget] экрана
/// и диспозится там.
class DocViewerCubit extends Cubit<DataState<Uint8List>> {
  DocViewerCubit(this._fetcher, this._pdfjsReady) : super(const DataState.loading()) {
    fetchData();
  }

  final PdfDocFetcher _fetcher;
  final PdfjsReadyPort _pdfjsReady;

  /// Загружает байты документа. Повторно вызывается из UI при ошибке.
  Future<void> fetchData() async {
    Log.info('[doc_viewer] fetchData старт');
    safeEmit(const DataState.loading());
    try {
      final bytes = await _fetcher();
      Log.info('[doc_viewer] PDF получен: ${bytes.lengthInBytes}B, ждём pdf.js');
      // На web дожидаемся pdf.js, иначе рендерер pdfx бросит
      // «Pdfjs library not loaded». На остальных платформах — no-op.
      await _pdfjsReady.ensure();
      Log.info('[doc_viewer] pdf.js готов, показываем ${bytes.lengthInBytes}B');
      safeEmit(DataState.content(bytes));
    } catch (e, s) {
      Log.error('[doc_viewer] fetchData упал (${e.runtimeType})', e, s);
      safeEmit(DataState.error(e));
    }
  }
}
