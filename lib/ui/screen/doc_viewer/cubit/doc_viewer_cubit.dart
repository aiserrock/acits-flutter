import 'dart:typed_data';

import 'package:acits_flutter/service/document/pdf_doc_mixin.dart';
import 'package:acits_flutter/util/data_state.dart';
import 'package:acits_flutter/util/logger/log.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:acits_flutter/util/bloc_ext.dart';

/// Cubit экрана просмотра PDF-документа.
///
/// Владеет состоянием загрузки [DataState] байтов PDF через [PdfDocFetcher].
/// Байты — единый кроссплатформенный формат (нет привязки к dart:io File).
/// UI-контроллер `PdfController` из pdfx остаётся во [StatefulWidget] экрана
/// и диспозится там.
class DocViewerCubit extends Cubit<DataState<Uint8List>> {
  DocViewerCubit(this._fetcher) : super(const DataState.loading()) {
    fetchData();
  }

  final PdfDocFetcher _fetcher;

  /// Загружает байты документа. Повторно вызывается из UI при ошибке.
  Future<void> fetchData() async {
    Log.debug('DocViewerCubit.fetchData');
    safeEmit(const DataState.loading());
    try {
      final bytes = await _fetcher();
      Log.info('DocViewerCubit.fetchData ok: ${bytes.lengthInBytes} bytes');
      safeEmit(DataState.content(bytes));
    } catch (e, s) {
      Log.error('DocViewerCubit.fetchData failed', e, s);
      safeEmit(DataState.error(e));
    }
  }
}
