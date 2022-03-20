import 'package:acits_flutter/export.dart';
import 'package:acits_flutter/service/debug/debug_service.dart';
import 'package:acits_flutter/service/shared_pref/preference_storage.dart';
import 'package:acits_flutter/ui/screen/search_screen/search_spec_screen_route.dart';
import 'package:acits_flutter/ui/widget/button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../di/di_container.dart';
import '../../service/debug/debug_dev_service.dart';

class DebugScreen extends StatelessWidget {
  const DebugScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorRes.background,
      appBar: AppBar(
        backgroundColor: ColorRes.foreground,
        shadowColor: Colors.transparent,
        leading: CupertinoButton(
          onPressed: Navigator.of(context).pop,
          child: const Icon(
            Icons.arrow_back_ios_new,
            color: ColorRes.accent,
          ),
        ),
        title: _buildTitle(),
        centerTitle: true,
      ),
      body: _buildBody(context),
    );
  }

  Widget _buildTitle() {
    return const Text(
      'Debug screen',
      style: TextStyle(color: ColorRes.textPrimary),
    );
  }

  Widget _buildBody(BuildContext context) {
    return ListView(
      children: [
        const _SearchSpeciesCard(),
        _ConnectionCard(),
      ],
    );
  }
}

class _ConnectionCard extends StatelessWidget {
  _ConnectionCard({
    Key? key,
  })  : _debugDevService = getIt.get<DebugService>() as DebugDevService,
        super(key: key);

  final DebugDevService _debugDevService;

  final _formKey = GlobalKey<FormState>();
  final _proxyController = TextEditingController(text: getIt.get<PreferenceStorage>().proxy);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        child: Form(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                const SizedBox(height: 8.0),
                const Text(
                  'Connection',
                  style: StyleRes.subTitle,
                ),
                TextField(
                  key: _formKey,
                  controller: _proxyController,
                  decoration: const InputDecoration(
                    hintText: '192.168.0.102:9000',
                  ),
                ),
                const SizedBox(height: 16.0),
                PrimaryButton(
                  text: 'Применить',
                  onPressed: () => _accept(context),
                ),
                const SizedBox(height: 16.0),
                PrimaryButton(
                  text: 'Сбросить',
                  onPressed: () => _reset(context),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _accept(BuildContext context) {
    Navigator.of(context).pop();
    _debugDevService.setProxy(_proxyController.text);
  }

  void _reset(BuildContext context) {
    Navigator.of(context).pop();
    _debugDevService.setProxy(null);
  }
}

class _SearchSpeciesCard extends StatefulWidget {
  const _SearchSpeciesCard({Key? key}) : super(key: key);

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
            const Text(
              'AnimalTypeSelector',
              style: StyleRes.subTitle,
            ),
            const SizedBox(height: 8.0),
            ListTile(
              title: Text(_category?.name ?? '* tap to select'),
              subtitle: const Text('category'),
              onTap: () async {
                final result = await Navigator.of(context).push(SearchScreenRoute());
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
                  final result = await Navigator.of(context)
                      .push<Species>(SearchScreenRoute(parentSearch: _category));
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
                  final result =
                      await Navigator.of(context).push(SearchScreenRoute(parentSearch: _family));
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
