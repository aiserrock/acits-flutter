import 'package:flutter/material.dart';
import 'package:ui_kit/ui_kit.dart';

/// [AdaptiveScaffold] — адаптивная навигация (bottom bar / rail / two-pane).
/// Ресайзните окно, чтобы пересечь брейкпоинты [WindowSize].
class AdaptiveScaffoldPage extends StatefulWidget {
  const AdaptiveScaffoldPage({super.key});

  @override
  State<AdaptiveScaffoldPage> createState() => _AdaptiveScaffoldPageState();
}

class _AdaptiveScaffoldPageState extends State<AdaptiveScaffoldPage> {
  int _index = 0;

  @override
  Widget build(BuildContext context) {
    final size = WindowSize.fromWidth(MediaQuery.sizeOf(context).width);
    return AdaptiveScaffold(
      selectedIndex: _index,
      onDestinationSelected: (i) => setState(() => _index = i),
      destinations: const [
        AdaptiveDestination(icon: Icon(IconRes.today), label: 'Today'),
        AdaptiveDestination(icon: Icon(IconRes.paw), label: 'Animals'),
        AdaptiveDestination(icon: Icon(IconRes.calendar), label: 'Calendar'),
      ],
      body: Center(child: Text('Window size: ${size.name}\nSelected tab: $_index', textAlign: TextAlign.center)),
      secondaryPane: const Center(child: Text('Secondary pane (large)')),
    );
  }
}
