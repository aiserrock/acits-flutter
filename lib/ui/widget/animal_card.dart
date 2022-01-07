import 'package:acits_flutter/ui/screen/animal_detail/animal_detail_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:acits_flutter/export.dart';

class AnimalCardWidget extends StatelessWidget {
  AnimalCardWidget(
    this.itemData, {
    Key? key,
  }) : super(key: key);

  final Animal? itemData;

  final _formatter = DateFormat('dd.MM.yyyy');

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      padding: const EdgeInsets.only(),
      onPressed: () => _navigateDetail(context),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8.0),
        child: Stack(
          children: [
            Positioned.fill(
              child: _buildActionBar(),
            ),
            Container(
              decoration: const BoxDecoration(color: ColorRes.foreground),
              margin: const EdgeInsets.only(right: 34.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildAvatar(),
                  const SizedBox(width: 8.0),
                  _buildContent(),
                ],
              ),
            ),
          ],
        ),
      ),
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
            Text(
              itemData?.name ?? '',
              style: StyleRes.title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            Text(
              itemData?.id?.toString() ?? '',
              style: StyleRes.content.copyWith(fontSize: 16.0),
              maxLines: 1,
            ),
            const SizedBox(height: 4.0),
            _buildSpec(),
            const SizedBox(height: 8.0),
            Row(
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
            ),
            const SizedBox(height: 4.0),
            _buildAdmit(),
          ],
        ),
      ),
    );
  }

  Widget _buildAvatar() {
    return Padding(
      padding: const EdgeInsets.only(
        left: 12.0,
        top: 16.0,
        bottom: 16.0,
      ),
      child: SizedBox(
        height: 80.0,
        width: 80.0,
        child: itemData?.avatar == null
            ? Assets.image.animalStub.image()
            : CircleAvatar(
                maxRadius: 80.0,
                backgroundImage: NetworkImage(itemData!.avatar!),
                backgroundColor: ColorRes.background,
              ),
      ),
    );
  }

  Widget _buildActionBar() {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        color: ColorRes.accent.withOpacity(.7),
        child: Flex(
          direction: Axis.vertical,
          mainAxisSize: MainAxisSize.max,
          children: [
            _buildActionBtn(
              onPressed: () {},
              child: Assets.icon.prescription.svg(
                color: ColorRes.foreground,
                height: 18.0,
                width: 18.0,
              ),
            ),
            _buildActionBtn(
              onPressed: () {},
              child: Assets.icon.comment.svg(
                color: ColorRes.foreground,
                height: 18.0,
                width: 18.0,
              ),
            ),
            _buildActionBtn(
              onPressed: () {},
              icon: Icons.download,
              color: ColorRes.foreground,
            ),
            _buildActionBtn(
              onPressed: () {},
              icon: Icons.edit,
              color: ColorRes.foreground,
            ),
            _buildActionBtn(
              onPressed: () {},
              icon: Icons.delete,
              color: ColorRes.error,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionBtn({
    required void Function()? onPressed,
    Widget? child,
    IconData? icon,
    Color color = ColorRes.inactiveIcon,
    double size = 18.0,
  }) {
    return Flexible(
      fit: FlexFit.tight,
      child: CupertinoButton(
        padding: const EdgeInsets.symmetric(
          vertical: 2.0,
          horizontal: 8.0,
        ),
        minSize: 24.0,
        child: child ??
            Icon(
              icon,
              color: color,
              size: size,
            ),
        onPressed: () {},
      ),
    );
  }

  Widget _buildAdmit() {
    return Text.rich(
      TextSpan(
        children: [
          TextSpan(
              text: StringRes.current.animalAdmitted, style: StyleRes.content),
          const TextSpan(text: (': '), style: StyleRes.content),
          TextSpan(
            text: itemData?.dateJoined != null
                ? _formatter.format(itemData!.dateJoined!)
                : '',
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
