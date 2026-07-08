import 'dart:io';

import 'package:acits_flutter/service/document/pdf_doc_mixin.dart';
import 'package:acits_flutter/util/data_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// Cubit экрана просмотра PDF-документа.
///
/// Владеет состоянием загрузки [DataState] файла через [PdfDocFetcher].
/// UI-контроллер `PdfController` из pdfx остаётся во [StatefulWidget] экрана
/// и диспозится там.
class DocViewerCubit extends Cubit<DataState<File>> {
  DocViewerCubit(this._fetcher) : super(const DataState.loading()) {
    fetchData();
  }

  final PdfDocFetcher _fetcher;

  /// Загружает файл документа. Повторно вызывается из UI при ошибке.
  Future<void> fetchData() async {
    emit(const DataState.loading());
    try {
      final file = await _fetcher();
      emit(DataState.content(file));
    } catch (e) {
      emit(DataState.error(e));
    }
  }
}
