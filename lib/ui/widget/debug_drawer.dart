import 'package:acits_flutter/generated/l10n.dart';
import 'package:flutter/material.dart';

class DebugDrawerContent extends StatelessWidget {
  const DebugDrawerContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        const DrawerHeader(
          child: SizedBox(
            height: 128.0,
            child: Center(child: Text('Debug panel')),
          ),
        ),
        ListTile(
          title: const Text('Locale RU'),
          onTap: () {
            StringRes.delegate.load(const Locale('ru'));

            if (Scaffold.of(context).isEndDrawerOpen) {
              Navigator.of(context).pop();
            }
          },
        ),
        ListTile(
          title: const Text('Locale EN'),
          onTap: () {
            StringRes.delegate.load(const Locale('en'));

            if (Scaffold.of(context).isEndDrawerOpen) {
              Navigator.of(context).pop();
            }
          },
        ),
      ],
    );
  }
}
