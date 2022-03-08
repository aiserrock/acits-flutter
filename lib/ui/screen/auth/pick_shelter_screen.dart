import 'package:acits_flutter/di/di_container.dart';
import 'package:acits_flutter/gen/assets.gen.dart';
import 'package:acits_flutter/service/config/config_service.dart';
import 'package:acits_flutter/util/util.dart';
import 'package:flutter/material.dart';

import 'package:acits_flutter/generated/l10n.dart';
import 'package:acits_flutter/res/color.dart';
import 'package:acits_flutter/ui/widget/debug_drawer.dart';
import 'package:acits_flutter/api/openapi.swagger.dart';

class PickShelterList extends StatefulWidget {
  const PickShelterList({
    required this.shelterList,
    Key? key,
  }) : super(key: key);

  final PaginatedShelterShortSerializersList shelterList;

  @override
  _PickShelterListState createState() => _PickShelterListState();
}

class _PickShelterListState extends State<PickShelterList> {
  WidgetState<Object> _state = WidgetState()..content(Object());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: ColorRes.background,
        endDrawer: const Drawer(
          child: DebugDrawerContent(),
        ),
        appBar: AppBar(
          backgroundColor: ColorRes.foreground,
          shadowColor: Colors.transparent,
          leading: Assets.image.logoLeadingBar.svg(),
          title: Text(
            StringRes.current.shelterSelectShelter,
            style: const TextStyle(color: ColorRes.textPrimary),
          ),
          centerTitle: true,
        ),
        body: Column(
          children: [
            Expanded(
              child: StateBuilder<Object>(
                state: _state,
                loader: (_) => Container(),
                errorBuilder: (_, __) => Container(),
                builder: (_, __) => _buildContent(),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 16.0,
                right: 16.0,
                bottom: 40.0,
              ),
              child: Text(
                StringRes.current.loginDescribeMsg,
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ));
  }

  Widget _buildContent() {
    return SingleChildScrollView(
      physics: const AlwaysScrollableScrollPhysics(),
      child: Card(
        margin: const EdgeInsets.symmetric(
          vertical: 20.0,
          horizontal: 16.0,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: ListView.separated(
          padding: const EdgeInsets.all(.0),
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: widget.shelterList.results?.length ?? 0,
          itemBuilder: (_, index) => ListTile(
            title: Text((widget.shelterList.results ?? [])[index].name ?? ''),
            onTap: () => _pickShelter(index),
          ),
          separatorBuilder: (_, __) => const Divider(
            indent: 16.0,
            endIndent: 16.0,
            height: 2.0,
            thickness: 2.0,
          ),
        ),
      ),
    );
  }

  Future<void> _pickShelter(int index) async {
    final shelter = (widget.shelterList.results ?? [])[index];
    await _getConfig(shelter);
    Navigator.of(context).pop<ShelterShortSerializers?>(shelter);
  }

  Future<void> _getConfig(ShelterShortSerializers shelter) async {
    setState(() {
      _state = WidgetState()..loading();
    });
    await getIt<ConfigService>().initConfig(currentShelterId: shelter.id).catchError((e) {
      setState(() {
        _state = WidgetState()..error = e;
      });
    });
  }
}
