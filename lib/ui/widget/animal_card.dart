import 'package:acits_flutter/ui/screen/animal_detail/animal_detail_screen.dart';
import 'package:acits_flutter/ui/screen/animal_edit/animal_edit_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';

import 'package:acits_flutter/export.dart';

/// Карточка животного в списке
class AnimalCardWidget extends StatelessWidget {
  AnimalCardWidget(
    this.itemData, {
    Key? key,
  }) : super(key: key);

  final AnimalRead? itemData;
  final _formatter = DateFormat('dd.MM.yyyy');

  @override
  Widget build(BuildContext context) {
    return Slidable(
      endActionPane: _buildSlidablePane(context),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8.0),
        child: Stack(
          children: [
            CupertinoButton(
              padding: const EdgeInsets.only(),
              onPressed: () => _navigateDetail(context),
              child: Container(
                decoration: const BoxDecoration(color: ColorRes.foreground),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildAvatar(),
                    const SizedBox(width: 8.0),
                    _buildContent(),
                  ],
                ),
              ),
            ),
            _buildActions(),
          ],
        ),
      ),
    );
  }

  Widget _buildActions() {
    return Align(
      alignment: Alignment.topRight,
      child: Builder(builder: (context) {
        return Column(
          children: [
            CupertinoButton(
              padding: const EdgeInsets.only(),
              child: const Icon(
                Icons.more_vert,
                color: ColorRes.accent,
              ),
              onPressed: () {
                SlidableController? controller = Slidable.of(context);
                controller?.openEndActionPane();
              },
            ),
            CupertinoButton(
              padding: const EdgeInsets.only(),
              child: const Icon(
                Icons.download,
                color: ColorRes.accent,
              ),
              onPressed: () {},
            ),
          ],
        );
      }),
    );
  }

  ActionPane _buildSlidablePane(BuildContext context) {
    return ActionPane(
      motion: const BehindMotion(),
      children: [
        SlidableAction(
          onPressed: (_) {},
          backgroundColor: ColorRes.background,
          icon: IconRes.prescription,
          foregroundColor: ColorRes.accent,
        ),
        SlidableAction(
          onPressed: (_) {},
          backgroundColor: ColorRes.background,
          icon: IconRes.comment,
          foregroundColor: ColorRes.accent,
        ),
        SlidableAction(
          onPressed: (_) => Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) => AnimalEditScreen(id: itemData?.id),
            ),
          ),
          backgroundColor: ColorRes.background,
          icon: Icons.edit_outlined,
          foregroundColor: ColorRes.accent,
        ),
        SlidableAction(
          onPressed: (_) {},
          backgroundColor: ColorRes.background,
          icon: Icons.delete_forever,
          foregroundColor: ColorRes.error,
        ),
      ],
    );
  }

  Widget _buildContent() {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 28.0),
              child: Text(
                itemData?.name ?? '',
                style: StyleRes.title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Text(
              itemData?.id?.toString() ?? '',
              style: StyleRes.content.copyWith(fontSize: 16.0),
              maxLines: 1,
            ),
            const SizedBox(height: 4.0),
            Padding(
              padding: const EdgeInsets.only(right: 28.0),
              child: _buildSpec(),
            ),
            const SizedBox(height: 8.0),
            _buildStatus(),
            const SizedBox(height: 4.0),
            _buildAdmit(),
          ],
        ),
      ),
    );
  }

  Row _buildStatus() {
    return Row(
      children: [
        Container(
          height: 16.0,
          width: 16.0,
          decoration: BoxDecoration(
            color: itemData?.statusColor,
            borderRadius: BorderRadius.circular(8.0),
          ),
        ),
        const SizedBox(width: 8.0),
        Expanded(
          child: Text(
            itemData?.statusString ?? '',
            style: StyleRes.content.copyWith(
              color: ColorRes.textPrimary,
            ),
          ),
        )
      ],
    );
  }

  Widget _buildAvatar() {
    final thumb = itemData?.thumb;
    return Padding(
      padding: const EdgeInsets.only(
        left: 12.0,
        top: 16.0,
        bottom: 16.0,
      ),
      child: SizedBox(
        height: 80.0,
        width: 80.0,
        child: thumb == null
            ? Assets.image.animalStub.image()
            : CircleAvatar(
                maxRadius: 80.0,
                backgroundImage: NetworkImage(thumb),
                backgroundColor: ColorRes.background,
              ),
      ),
    );
  }

  Widget _buildAdmit() {
    return Text.rich(
      TextSpan(
        children: [
          TextSpan(text: StringRes.current.animalAdmitted, style: StyleRes.content),
          const TextSpan(text: (': '), style: StyleRes.content),
          TextSpan(
            text: itemData?.dateJoined != null ? _formatter.format(itemData!.dateJoined!) : '',
            style: StyleRes.content.copyWith(
              color: ColorRes.textPrimary,
            ),
          ),
        ],
      ),
      maxLines: 3,
    );
  }

  Widget _buildSpec() {
    return Text.rich(
      TextSpan(
        children: [
          TextSpan(
            text: (itemData?.spec?['parent_name'] ?? ''),
            style: StyleRes.content.copyWith(
              color: ColorRes.textPrimary,
            ),
          ),
          const TextSpan(text: (', '), style: StyleRes.mainContent),
          TextSpan(
            text: itemData?.spec?['name'] ?? '',
            style: StyleRes.content.copyWith(
              color: ColorRes.textPrimary,
            ),
          ),
        ],
      ),
      maxLines: 3,
    );
  }

  void _navigateDetail(BuildContext context) {
    if (itemData?.id == null) return;
    Navigator.of(context, rootNavigator: true).push(
      MaterialPageRoute(
        builder: (_) => AnimalDetailScreen(id: itemData!.id!),
      ),
    );
  }
}
