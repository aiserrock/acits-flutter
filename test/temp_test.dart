import 'package:flutter_test/flutter_test.dart';

/// Тест заглушка для проверки CI/CDƒ
void main() {
  setUpAll(() {});

  stubExample();
}

void stubExample() {
  return test('stubExample', (() {
    expect(true, true, reason: 'Test failed!');
  }));
}
