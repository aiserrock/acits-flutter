import 'package:share_plus/share_plus.dart';

/// mobile/desktop: системный share-sheet с текстом через share_plus.
Future<void> shareTextPlatform(String text) async {
  await SharePlus.instance.share(ShareParams(text: text));
}
