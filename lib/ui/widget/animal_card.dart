import 'package:acits_flutter/ui/screen/animal_detail/animal_detail_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';

import 'package:acits_flutter/export.dart';

/// Карточка животного в списке
class AnimalCardWidget extends StatefulWidget {
  const AnimalCardWidget(
    this.itemData, {
    Key? key,
  }) : super(key: key);

  final Animal? itemData;

  @override
  State<AnimalCardWidget> createState() => _AnimalCardWidgetState();
}

class _AnimalCardWidgetState extends State<AnimalCardWidget>
    with SingleTickerProviderStateMixin {
  final _formatter = DateFormat('dd.MM.yyyy');

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Slidable(
      endActionPane: _buildSlidablePane(),
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

  ActionPane _buildSlidablePane() {
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
          onPressed: (_) {},
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
                widget.itemData?.name ?? '',
                style: StyleRes.title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Text(
              widget.itemData?.id?.toString() ?? '',
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
            color: widget.itemData?.statusColor,
            borderRadius: BorderRadius.circular(8.0),
          ),
        ),
        const SizedBox(width: 8.0),
        Expanded(
          child: Text(
            widget.itemData?.statusString ?? '',
            style: StyleRes.content.copyWith(
              color: ColorRes.textPrimary,
            ),
          ),
        )
      ],
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
        child: widget.itemData?.avatar == null
            ? Assets.image.animalStub.image()
            : CircleAvatar(
                maxRadius: 80.0,
                backgroundImage: NetworkImage(widget.itemData!.avatar!),
                backgroundColor: ColorRes.background,
              ),
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
            text: widget.itemData?.dateJoined != null
                ? _formatter.format(widget.itemData!.dateJoined!)
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
            text: (widget.itemData?.spec?['parent_name'] ?? ''),
            style: StyleRes.content.copyWith(
              color: ColorRes.textPrimary,
            ),
          ),
          const TextSpan(text: (', '), style: StyleRes.mainContent),
          TextSpan(
            text: widget.itemData?.spec?['name'] ?? '',
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
    if (widget.itemData?.id == null) return;
    Navigator.of(context, rootNavigator: true).push(
      MaterialPageRoute(
        builder: (_) => AnimalDetailScreen(id: widget.itemData!.id!),
      ),
    );
  }
}
