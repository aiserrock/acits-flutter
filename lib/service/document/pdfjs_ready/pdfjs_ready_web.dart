import 'dart:async';
import 'dart:js_interop';

import 'package:acits_flutter/util/logger/log.dart';

/// Есть ли на странице загруженный pdf.js (`globalThis.pdfjsLib`).
@JS('pdfjsLib')
external JSObject? get _pdfjsLib;

/// Ждёт появления `pdfjsLib` на странице. pdf.js подключён ES-модулем в
/// index.html и грузится отложенно, поэтому опрашиваем с коротким интервалом
/// до таймаута. По истечении таймаута выходим тихо — рендерер pdfx сам бросит
/// понятную ошибку, а UI покажет retry.
Future<void> pdfjsEnsureReady() async {
  if (_pdfjsLib != null) return;

  const pollInterval = Duration(milliseconds: 50);
  const timeout = Duration(seconds: 10);
  var waited = Duration.zero;

  while (_pdfjsLib == null && waited < timeout) {
    await Future<void>.delayed(pollInterval);
    waited += pollInterval;
  }

  if (_pdfjsLib == null) {
    Log.warning('pdfjs still not loaded after ${timeout.inSeconds}s');
  } else {
    Log.debug('pdfjs ready after ${waited.inMilliseconds}ms');
  }
}
