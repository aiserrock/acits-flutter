import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:logging/logging.dart';
import 'package:flutter_driver/driver_extension.dart';

import 'package:acits_flutter/main.dart';
import '../dev/di/di_container.dart';
import '../dev/res/cert_res.dart';
import '../dev/ssl/http_overrides.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  enableFlutterDriverExtension();
  _setupLogging();
  if (!kIsWeb) await _addDebugHttpCerts();
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
  final certs = await Future.wait(
    [CertRes.nikitaAir13, CertRes.nikitaMac2013, CertRes.nikitaMacPro13].map(rootBundle.load),
  );

  HttpOverrides.global = SslHttpOverrides(
    withTrustedRoots: true,
    certBytes: certs.map((e) => e.buffer.asInt8List()).toList(),
  );
}
