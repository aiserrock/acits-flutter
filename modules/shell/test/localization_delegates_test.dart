import 'package:cupertino_ui/cupertino_ui.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shell/res/l10n.dart';

/// Подменяет assets-загрузку: тесту нужны только делегаты, не реальные переводы.
class _StubLoader extends AssetLoader {
  const _StubLoader();

  @override
  Future<Map<String, dynamic>?> load(String path, Locale locale) async => <String, dynamic>{'hello': 'hi'};
}

void main() {
  setUpAll(() async {
    SharedPreferences.setMockInitialValues({});
    await EasyLocalization.ensureInitialized();
  });

  /// Те же аргументы локализации, что `MaterialApp.router` в AppScaffold.
  Widget app({required Locale locale, required void Function(BuildContext) onBuild}) {
    return EasyLocalization(
      supportedLocales: L10n.supportedLocales,
      path: 'unused',
      fallbackLocale: L10n.fallbackLocale,
      startLocale: locale,
      assetLoader: const _StubLoader(),
      saveLocale: false,
      child: Builder(
        builder: (context) => MaterialApp(
          localizationsDelegates: L10n.delegates(context),
          supportedLocales: context.supportedLocales,
          locale: context.locale,
          home: Builder(
            builder: (context) {
              onBuild(context);
              return const SizedBox.shrink();
            },
          ),
        ),
      ),
    );
  }

  testWidgets('reads Russian MaterialLocalizations through the app configuration', (tester) async {
    late MaterialLocalizations l10n;
    await tester.pumpWidget(app(locale: const Locale('ru'), onBuild: (c) => l10n = MaterialLocalizations.of(c)));
    await tester.pumpAndSettle();

    expect(tester.takeException(), isNull);
    expect(l10n.okButtonLabel, 'ОК');
    expect(l10n.cancelButtonLabel, 'Отмена');
  });

  testWidgets('reads English MaterialLocalizations after the locale switches', (tester) async {
    late MaterialLocalizations l10n;
    await tester.pumpWidget(app(locale: const Locale('en'), onBuild: (c) => l10n = MaterialLocalizations.of(c)));
    await tester.pumpAndSettle();

    expect(tester.takeException(), isNull);
    expect(l10n.cancelButtonLabel, 'Cancel');
  });

  testWidgets('reads Russian CupertinoLocalizations and keeps the easy_localization delegate', (tester) async {
    late CupertinoLocalizations cupertino;
    late String translated;
    await tester.pumpWidget(
      app(
        locale: const Locale('ru'),
        onBuild: (c) {
          cupertino = CupertinoLocalizations.of(c);
          translated = 'hello'.tr();
        },
      ),
    );
    await tester.pumpAndSettle();

    expect(cupertino.alertDialogLabel, 'Оповещение');
    expect(translated, 'hi');
  });
}
