// ignore_for_file: deprecated_member_use

import 'package:acits_flutter/export.dart';
import 'package:acits_flutter/domain/env.dart';
import 'package:acits_flutter/navigation/app_router.dart';
import 'package:acits_flutter/service/debug/debug_service.dart';
import 'package:acits_flutter/ui/widget/button.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_alice/alice.dart';
import 'package:go_router/go_router.dart';
import 'package:talker_flutter/talker_flutter.dart';

import '../../di/di_container.dart';
import '../../service/debug/debug_dev_service.dart';

class DebugScreen extends StatelessWidget {
  const DebugScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorRes.background,
      appBar: AppBar(
        backgroundColor: ColorRes.foreground,
        shadowColor: Colors.transparent,
        leading: CupertinoButton(
          onPressed: Navigator.of(context).pop,
          child: const Icon(Icons.arrow_back_ios_new, color: ColorRes.accent),
        ),
        title: _buildTitle(),
        centerTitle: true,
      ),
      body: _buildBody(context),
    );
  }

  Widget _buildTitle() {
    return const Text('Debug screen', style: TextStyle(color: ColorRes.textPrimary));
  }

  Widget _buildBody(BuildContext context) {
    // Порядок: сначала часто используемое (подключение/окружения), затем
    // вспомогательное (UIKit), внизу — Firebase-тесты и AnimalTypeSelector.
    return ListView(
      children: const [
        _LogsCard(),
        _ConnectionCard(),
        _ProxyCard(),
        _UIKitCard(),
        _FirebaseTestCard(),
        _SearchSpeciesCard(),
      ],
    );
  }
}

/// Открывает экран логов Talker (сеть, bloc-переходы, ручные `Log.*`).
class _LogsCard extends StatelessWidget {
  const _LogsCard();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              const SizedBox(height: 8.0),
              const Text('Логи', style: StyleRes.subTitle),
              const SizedBox(height: 8.0),
              PrimaryButton(
                onPressed: () => Navigator.of(context).push(
                  MaterialPageRoute<void>(builder: (_) => TalkerScreen(talker: getIt<Talker>())),
                ),
                child: Text('Открыть логи (Talker)'.toUpperCase()),
              ),
              const SizedBox(height: 8.0),
              // Alice — отдельный HTTP-инспектор (запросы/ответы, curl, поиск).
              PrimaryButton(
                onPressed: () => getIt<Alice>().showInspector(),
                child: Text('HTTP-инспектор (Alice)'.toUpperCase()),
              ),
              const SizedBox(height: 8.0),
            ],
          ),
        ),
      ),
    );
  }
}

/// Проверка Firebase (dev-проект acits-dev): Crashlytics и Analytics.
class _FirebaseTestCard extends StatelessWidget {
  const _FirebaseTestCard();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              const SizedBox(height: 8.0),
              const Text('Firebase', style: StyleRes.subTitle),
              const SizedBox(height: 8.0),
              // Crashlytics существует только на android/ios.
              if (!kIsWeb) ...[
                PrimaryButton(
                  onPressed: () async {
                    await FirebaseCrashlytics.instance.log('manual test crash from DebugScreen');
                    await FirebaseCrashlytics.instance.setCustomKey('test_source', 'debug_screen');
                    FirebaseCrashlytics.instance.crash();
                  },
                  child: Text('Test crash (fatal)'.toUpperCase()),
                ),
                const SizedBox(height: 8.0),
                PrimaryButton(
                  onPressed: () async {
                    await FirebaseCrashlytics.instance.recordError(
                      Exception('manual non-fatal test error from DebugScreen'),
                      StackTrace.current,
                      fatal: false,
                    );
                    _snack(context, 'Non-fatal error recorded');
                  },
                  child: Text('Test non-fatal error'.toUpperCase()),
                ),
                const SizedBox(height: 8.0),
              ],
              PrimaryButton(
                onPressed: () async {
                  await FirebaseAnalytics.instance.logEvent(
                    name: 'test_event',
                    parameters: {
                      'source': 'debug_screen',
                      'platform': kIsWeb ? 'web' : defaultTargetPlatform.name,
                    },
                  );
                  _snack(context, 'Analytics test_event sent');
                },
                child: Text('Test analytics event'.toUpperCase()),
              ),
              const SizedBox(height: 8.0),
            ],
          ),
        ),
      ),
    );
  }

  void _snack(BuildContext context, String msg) {
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
    }
  }
}

class _UIKitCard extends StatelessWidget {
  const _UIKitCard();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              const SizedBox(height: 8.0),
              const Text('UIKit', style: StyleRes.subTitle),
              const SizedBox(height: 8.0),
              PrimaryButton(
                onPressed: () {
                  // Пример deeplink подтверждения почты. Реальную ссылку с
                  // токеном подставляйте из тестового письма — живые токены в
                  // репозитории не храним.
                  const link =
                      'https://stage.app.acits.ru/api/v1/users/verify-email/<uidb64>/<sidb64>/<token>/';
                  context.push('${AppRoutes.emailConfirmation}?link=${Uri.encodeComponent(link)}');
                },
                child: Text('Email confirm'.toUpperCase()),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Контуры для ручного переключения: prod, stage, dev-0..3, затем Custom.
/// Custom — последний пункт, под ним поле ввода произвольного URL (mockoon).
final _domainUrlList = AcitsEnvUrls.all;

/// Индекс пункта Custom в radiobutton-списке (сразу после списка контуров).
const _customDomainIndex = -1;

/// Секция подключения: выбор контура/custom-URL (mockoon). Прокси — в [_ProxyCard].
class _ConnectionCard extends StatefulWidget {
  const _ConnectionCard();

  @override
  State<_ConnectionCard> createState() => _ConnectionCardState();
}

class _ConnectionCardState extends State<_ConnectionCard> {
  _ConnectionCardState() : _debug = getIt.get<DebugService>() as DebugDevService;

  final DebugDevService _debug;

  final _customUrlController = TextEditingController();

  /// Выбранный индекс в списке контуров; [_customDomainIndex] = выбран Custom.
  late int _domainIndex;

  @override
  void initState() {
    super.initState();
    _init();
  }

  @override
  void dispose() {
    _customUrlController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 8.0),
              const Center(child: Text('Endpoint', style: StyleRes.subTitle)),
              const SizedBox(height: 8.0),
              // Контуры окружений.
              ..._domainUrlList.asMap().entries.map(
                (entry) => RadioListTile<int>(
                  value: entry.key,
                  groupValue: _domainIndex,
                  onChanged: _onDomainChanged,
                  title: Text(entry.value),
                  contentPadding: EdgeInsets.zero,
                ),
              ),
              // Custom URL (mockoon / динамический стенд).
              RadioListTile<int>(
                value: _customDomainIndex,
                groupValue: _domainIndex,
                onChanged: _onDomainChanged,
                title: const Text('Custom (mockoon)'),
                contentPadding: EdgeInsets.zero,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 16.0, right: 8.0),
                child: TextField(
                  controller: _customUrlController,
                  enabled: _domainIndex == _customDomainIndex,
                  keyboardType: TextInputType.url,
                  decoration: const InputDecoration(
                    hintText: 'http://192.168.1.10:3000',
                    helperText: 'для mockoon используйте http и хост машины в сети',
                    helperMaxLines: 2,
                  ),
                ),
              ),
              const SizedBox(height: 16.0),
              PrimaryButton(text: 'Применить', onPressed: () => _accept(context)),
              const SizedBox(height: 16.0),
              PrimaryButton(text: 'Сбросить', onPressed: () => _reset(context)),
            ],
          ),
        ),
      ),
    );
  }

  void _init() {
    _customUrlController.text = _debug.customUrl ?? '';

    final domain = _debug.domainUrl;
    if (domain == null) {
      // Ничего не выбрано — дефолт dev-флейвора (dev-0).
      _domainIndex = _domainUrlList.indexOf(AcitsEnvUrls.dev(0));
    } else {
      final index = _domainUrlList.indexOf(domain);
      if (index > -1) {
        _domainIndex = index;
      } else {
        // Сохранённый URL не из списка контуров — значит это custom (mockoon).
        _domainIndex = _customDomainIndex;
        if (_customUrlController.text.isEmpty) _customUrlController.text = domain;
      }
    }
  }

  void _onDomainChanged(int? index) => setState(() => _domainIndex = index ?? 0);

  void _accept(BuildContext context) {
    // Определяем целевой baseUrl: контур из списка либо custom-поле.
    final String? targetUrl;
    if (_domainIndex == _customDomainIndex) {
      final custom = _customUrlController.text.trim();
      if (custom.isEmpty) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('Введите custom URL')));
        return;
      }
      _debug.customUrl = custom;
      targetUrl = custom;
    } else {
      targetUrl = _domainUrlList[_domainIndex];
    }

    _debug.domainUrl = targetUrl;

    Navigator.of(context).pop();
    // Смена контура/custom-URL — заставка «Применение…» + рестарт дерева.
    // (Клиенты пересоздаются из свежего baseUrl — этого достаточно.)
    _debug.reloadApp();
  }

  void _reset(BuildContext context) {
    Navigator.of(context).pop();
    _debug.domainUrl = null;
    _debug.customUrl = null;
    _debug.reloadApp();
  }
}

/// Секция прокси (Charles/mitmproxy) — отдельно от контуров, т.к. прокси
/// применяется только при ПОЛНОМ ручном перезапуске приложения (мягкий рестарт
/// дерева не пересоздаёт системные соединения). Своя кнопка + алерт.
class _ProxyCard extends StatefulWidget {
  const _ProxyCard();

  @override
  State<_ProxyCard> createState() => _ProxyCardState();
}

class _ProxyCardState extends State<_ProxyCard> {
  _ProxyCardState() : _debug = getIt.get<DebugService>() as DebugDevService;

  final DebugDevService _debug;
  final _proxyController = TextEditingController();
  late bool _proxyEnabled;

  @override
  void initState() {
    super.initState();
    _proxyEnabled = _debug.proxyEnabled;
    _proxyController.text = _debug.proxyUrl ?? '';
  }

  @override
  void dispose() {
    _proxyController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 8.0),
              Row(
                children: [
                  const Text('Proxy (Charles)', style: StyleRes.subTitle),
                  const Spacer(),
                  Switch(value: _proxyEnabled, onChanged: _onProxyToggled),
                ],
              ),
              TextField(
                controller: _proxyController,
                enabled: _proxyEnabled,
                keyboardType: TextInputType.url,
                onChanged: (v) => _debug.proxyUrl = v.trim(),
                decoration: const InputDecoration(
                  hintText: '192.168.0.102:8888',
                  helperText: 'перезапустите приложение вручную для применения',
                  helperMaxLines: 2,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _onProxyToggled(bool value) {
    setState(() => _proxyEnabled = value);
    // Сохраняем сразу (кнопки нет). Адрес тоже пишем — на случай, если юзер
    // ввёл его до включения тумблера.
    _debug.proxyEnabled = value;
    _debug.proxyUrl = _proxyController.text.trim();
    // При включении — предупреждаем, что нужен ручной перезапуск.
    if (value) _debug.showRestartRequired();
  }
}

class _SearchSpeciesCard extends StatefulWidget {
  const _SearchSpeciesCard();

  @override
  _SearchSpeciesCardState createState() => _SearchSpeciesCardState();
}

class _SearchSpeciesCardState extends State<_SearchSpeciesCard> {
  Species? _category;
  Species? _family;
  Species? _kind;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        margin: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            const SizedBox(height: 8.0),
            const Text('AnimalTypeSelector', style: StyleRes.subTitle),
            const SizedBox(height: 8.0),
            ListTile(
              title: Text(_category?.name ?? '* tap to select'),
              subtitle: const Text('category'),
              onTap: () async {
                final result = await context.push<Species>(AppRoutes.searchSpec);
                if (result != null) {
                  setState(() {
                    _category = result;
                    _family = null;
                    _kind = null;
                  });
                }
              },
            ),
            ListTile(
              title: Text(_family?.name ?? '* tap to select'),
              subtitle: const Text('family'),
              onTap: () async {
                if (_category != null) {
                  final result = await context.push<Species>(
                    AppRoutes.searchSpec,
                    extra: _category,
                  );
                  if (result != null) {
                    setState(() {
                      _family = result;
                      _kind = null;
                    });
                  }
                }
              },
            ),
            ListTile(
              title: Text(_kind?.name ?? '* tap to select'),
              subtitle: const Text('kind'),
              onTap: () async {
                if (_family != null) {
                  final result = await context.push<Species>(AppRoutes.searchSpec, extra: _family);
                  if (result != null) {
                    setState(() {
                      _kind = result;
                    });
                  }
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
