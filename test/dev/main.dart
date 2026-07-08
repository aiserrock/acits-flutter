import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:logging/logging.dart';

import 'package:acits_flutter/main.dart';
import 'di/di_container.dart';

// Раньше dev-сборка подмешивала Charles-сертификаты прошлого разработчика в
// глобальный HttpOverrides (см. закомментированный _addDebugHttpCerts ниже).
// Отключено: эти сертификаты просрочены (2022–2023) и без запущенного Charles
// ломали ВСЕ HTTPS-запросы — приложение выглядело как «нет интернета».
// import 'dart:io';
// import 'package:flutter/foundation.dart';
// import 'res/cert_res.dart';
// import 'ssl/http_overrides.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  _setupLogging();
  // if (!kIsWeb) await _addDebugHttpCerts(); // см. комментарий выше
  await initDevDi();
  runApp(const AcitsApp());
}

void _setupLogging() {
  Logger.root.level = Level.ALL;
  Logger.root.onRecord.listen((rec) {
    // ignore: avoid_print
    print('${rec.level.name}: ${rec.time}: ${rec.message}');
  });
}

// Проксирование dev-трафика через Charles. Оставлено как справка о том, как это
// работало раньше. Чтобы вернуть: раскомментировать импорты и вызов выше,
// заменить просроченные assets/cert/ssl_charles_*.pem на актуальный экспорт
// вашего Charles root-сертификата (Help → SSL Proxying → Save Charles Root
// Certificate) и запустить сам Charles.
//
// Future<void> _addDebugHttpCerts() async {
//   final certs = await Future.wait(
//     [CertRes.nikitaAir13, CertRes.nikitaMac2013, CertRes.nikitaMacPro13].map(rootBundle.load),
//   );
//
//   HttpOverrides.global = SslHttpOverrides(
//     withTrustedRoots: true,
//     certBytes: certs.map((e) => e.buffer.asInt8List()).toList(),
//   );
// }
