import 'package:flutter/material.dart';
import 'package:ui_kit/ui_kit.dart';

/// [PrimaryButton] (fill / inline × enabled / disabled) и [DefaultIconButton].
class ButtonsPage extends StatelessWidget {
  const ButtonsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Buttons')),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          _label(context, 'PrimaryButton — fill'),
          PrimaryButton(text: 'Enabled', onPressed: () {}),
          const SizedBox(height: 12.0),
          const PrimaryButton(text: 'Disabled', onPressed: null),
          const SizedBox(height: 24.0),
          _label(context, 'PrimaryButton — inline (isFill: false)'),
          PrimaryButton(text: 'Enabled', isFill: false, onPressed: () {}),
          const SizedBox(height: 12.0),
          const PrimaryButton(text: 'Disabled', isFill: false, onPressed: null),
          const SizedBox(height: 24.0),
          _label(context, 'PrimaryButton — custom child'),
          PrimaryButton(
            onPressed: () {},
            child: const Row(
              mainAxisSize: MainAxisSize.min,
              children: [Icon(IconRes.paw, size: 20.0), SizedBox(width: 8.0), Text('С иконкой')],
            ),
          ),
          const SizedBox(height: 24.0),
          _label(context, 'DefaultIconButton'),
          Row(
            children: [
              DefaultIconButton(icon: const Icon(IconRes.close), onPressed: () {}),
              const SizedBox(width: 16.0),
              DefaultIconButton(icon: const Icon(IconRes.comment), onPressed: () {}),
            ],
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
