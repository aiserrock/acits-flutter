import 'dart:io';

import 'package:acits_flutter/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:logging/logging.dart';
import 'di/di_container.dart';
import 'res/cert_res.dart';
import 'ssl/http_overrides.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome?.setPreferredOrientations([DeviceOrientation.portraitUp]);
  _setupLogging();
  await _addDebugHttpCerts();
  await initDevDi();
  runApp(const MyApp());
}

void _setupLogging() {
  Logger.root.level = Level.ALL;
  Logger.root.onRecord.listen((rec) {
    // ignore: avoid_print
    print('${rec.level.name}: ${rec.time}: ${rec.message}');
  });
}

Future<void> _addDebugHttpCerts() async {
  final cert = await rootBundle
      .loadString(CertRes.nikitaAir13)
      .then((value) => value.split('').map(int.parse).toList());
  final cert1 = await rootBundle
      .loadString(CertRes.nikitaMac2013)
      .then((value) => value.split('').map(int.parse).toList());
  final cert2 = await rootBundle
      .loadString(CertRes.nikitaMacPro13)
      .then((value) => value.split('').map(int.parse).toList());

  HttpOverrides.global = SslHttpOverrides(
    withTrustedRoots: true,
    certBytes: [
      cert,
      cert1,
      cert2,
    ],
  );
}
