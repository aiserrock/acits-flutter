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
  _addDebugHttpCerts();
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

void _addDebugHttpCerts() {
  HttpOverrides.global = SslHttpOverrides(
    //ignore: avoid_redundant_argument_values
    withTrustedRoots: true,
    certFilePathes: [
      CertRes.nikitaAir13,
      CertRes.nikitaMac2013,
      CertRes.nikitaMacPro13,
    ],
  );
}
