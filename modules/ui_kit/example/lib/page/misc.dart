import 'package:flutter/material.dart';
import 'package:ui_kit/ui_kit.dart';

/// Прочие виджеты: [AppLogo] (адаптивный к теме), [VisibleItem] (показ/скрытие
/// с сохранением места в дереве).
class MiscPage extends StatefulWidget {
  const MiscPage({super.key});

  @override
  State<MiscPage> createState() => _MiscPageState();
}

class _MiscPageState extends State<MiscPage> {
  bool _visible = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Misc')),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          _label(context, 'AppLogo (флипается по теме)'),
          AppLogo(
            light: Assets.icon.logoBar.svg(height: 48.0),
            dark: Assets.icon.logoBarDark.svg(height: 48.0),
          ),
          const SizedBox(height: 16.0),
          AppLogo(
            light: Assets.icon.logoLeadingBar.svg(height: 40.0),
            dark: Assets.icon.logoLeadingBarDark.svg(height: 40.0),
          ),
          const Divider(height: 40.0),
          _label(context, 'VisibleItem'),
          SwitchListTile(
            title: const Text('isVisible'),
            value: _visible,
            onChanged: (v) => setState(() => _visible = v),
          ),
          Container(
            height: 80.0,
            alignment: Alignment.center,
            color: Theme.of(context).colorScheme.surfaceContainerHigh,
            child: VisibleItem(
              isVisible: _visible,
              child: Text(
                'Виден при isVisible == true',
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _label(BuildContext context, String text) => Padding(
    padding: const EdgeInsets.only(bottom: 8.0),
    child: Text(text, style: Theme.of(context).textTheme.titleSmall),
  );
}
