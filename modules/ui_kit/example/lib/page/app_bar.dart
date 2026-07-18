import 'package:flutter/material.dart';
import 'package:ui_kit/ui_kit.dart';

/// [UiAppBar] (токен-ориентированный, back + actions) и legacy [DefaultAppBar].
class AppBarPage extends StatelessWidget {
  const AppBarPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        _Demo(
          title: 'UiAppBar — back + action',
          child: Scaffold(
            appBar: UiAppBar(
              title: 'Заголовок',
              onBack: () {},
              actions: [IconButton(icon: const Icon(Icons.more_vert), onPressed: () {})],
            ),
            body: const Center(child: Text('Body')),
          ),
        ),
        _Demo(
          title: 'UiAppBar — только заголовок',
          child: Scaffold(
            appBar: UiAppBar(title: 'Без кнопки назад'),
            body: const Center(child: Text('Body')),
          ),
        ),
        _Demo(
          title: 'DefaultAppBar',
          child: Scaffold(
            appBar: DefaultAppBar(titleString: 'Default', onBackPressure: () {}),
            body: const Center(child: Text('Body')),
          ),
        ),
      ],
    );
  }
}

class _Demo extends StatelessWidget {
  const _Demo({required this.title, required this.child});

  final String title;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: Theme.of(context).textTheme.titleSmall),
          const SizedBox(height: 8.0),
          SizedBox(
            height: 160.0,
            child: ClipRRect(borderRadius: BorderRadius.circular(12.0), child: child),
          ),
        ],
      ),
    );
  }
}
