/// Заглушка для платформ без io/web (не должна вызываться в реальной сборке).
Future<void> shareTextPlatform(String text) async {
  throw UnsupportedError('shareText не поддержан на этой платформе');
}
