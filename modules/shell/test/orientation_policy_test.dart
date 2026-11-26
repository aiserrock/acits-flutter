import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shell/shell.dart';

void main() {
  test('a phone stays locked to portrait', () {
    expect(OrientationPolicy.forShortestSide(390), [DeviceOrientation.portraitUp]);
    expect(OrientationPolicy.forShortestSide(599), [DeviceOrientation.portraitUp]);
  });

  test('tablets, foldables and wide windows rotate freely', () {
    expect(OrientationPolicy.forShortestSide(600), isEmpty);
    expect(OrientationPolicy.forShortestSide(820), isEmpty);
  });
}
