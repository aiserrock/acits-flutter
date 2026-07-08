import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

class DebugDrawerContent extends StatelessWidget {
  const DebugDrawerContent({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        const DrawerHeader(
          child: SizedBox(height: 128.0, child: Center(child: Text('Debug panel'))),
        ),
        ListTile(
          title: const Text('Locale RU'),
          onTap: () {
            context.setLocale(const Locale('ru'));

            if (Scaffold.of(context).isEndDrawerOpen) {
              Navigator.of(context).pop();
            }
          },
        ),
        ListTile(
          title: const Text('Locale EN'),
          onTap: () {
            context.setLocale(const Locale('en'));

            if (Scaffold.of(context).isEndDrawerOpen) {
              Navigator.of(context).pop();
            }
          },
        ),
      ],
    );
  }
}
