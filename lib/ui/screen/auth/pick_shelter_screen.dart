import 'package:acits_flutter/gen/assets.gen.dart';
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        backgroundColor: ColorRes.background,
        body: Column(
          children: [
            Expanded(
              child: ListView.separated(
                physics: const AlwaysScrollableScrollPhysics(),
                itemCount: widget.shelterList.results?.length ?? 0,
                itemBuilder: (_, index) => ListTile(
                  title: Text((widget.shelterList.results ?? [])[index].name ?? ''),
                  onTap: () => _pickShelter(index),
                ),
                separatorBuilder: (_, __) => const Divider(indent: 16.0, endIndent: 16.0),
              ),
            ),
            const SizedBox(height: 16.0),
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

  void _pickShelter(int index) {
    Navigator.of(context).pop<ShelterShortSerializers?>((widget.shelterList.results ?? [])[index]);
  }
}
