import 'package:ui_kit/acits_ui_kit.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('WindowSize.fromWidth maps widths to classes at the M3 boundaries', () {
    expect(WindowSize.fromWidth(375), WindowSize.compact);
    expect(WindowSize.fromWidth(599), WindowSize.compact);
    expect(WindowSize.fromWidth(600), WindowSize.medium);
    expect(WindowSize.fromWidth(700), WindowSize.medium);
    expect(WindowSize.fromWidth(839), WindowSize.medium);
    expect(WindowSize.fromWidth(840), WindowSize.expanded);
    expect(WindowSize.fromWidth(1000), WindowSize.expanded);
    expect(WindowSize.fromWidth(1199), WindowSize.expanded);
    expect(WindowSize.fromWidth(1200), WindowSize.large);
    expect(WindowSize.fromWidth(1300), WindowSize.large);
  });
}
