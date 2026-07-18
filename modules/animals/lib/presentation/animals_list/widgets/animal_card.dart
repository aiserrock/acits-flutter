import 'package:base/base.dart';
import 'package:ui_kit/ui_kit.dart';
import 'package:l10n/l10n.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import 'package:animals/domain/domain.dart';
import 'package:animals/presentation/animals_list/animals_list.dart';

/// Карточка животного в списке.
class AnimalCardWidget extends StatelessWidget {
  const AnimalCardWidget(
    this.itemData, {
    required this.router,
    required this.permissions,
    required this.statusLabels,
    this.onDelete,
    this.avatarFallback,
    super.key,
  });

  final AnimalListItem itemData;
  final AnimalsRouterService router;
  final AnimalPermissions permissions;
  final AnimalStatusLabels statusLabels;
  final VoidCallback? onDelete;

  /// Заглушка аватара (ассет приложения передаёт корень; ui_kit ассетами не владеет).
  final Widget? avatarFallback;

  bool get _isEditable => permissions.canEdit;
  bool get _isDeletable => permissions.canDelete;
  bool get _hasActions => _isEditable || _isDeletable;

  @override
  Widget build(BuildContext context) {
    return Slidable(
      endActionPane: _hasActions ? _buildSlidablePane(context) : null,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8.0),
        child: Stack(
          children: [
            CupertinoButton(
              padding: const EdgeInsets.only(),
              onPressed: () => router.openDetail(itemData.id),
              child: Container(
                decoration: BoxDecoration(color: Theme.of(context).colorScheme.surfaceContainerLow),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [_buildAvatar(context), const SizedBox(width: 8.0), _buildContent(context)],
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
      child: Builder(
        builder: (context) {
          return Column(
            children: [
              if (_hasActions)
                CupertinoButton(
                  padding: const EdgeInsets.only(),
                  child: Icon(Icons.more_vert, color: Theme.of(context).colorScheme.primary),
                  onPressed: () {
                    final SlidableController? controller = Slidable.of(context);
                    controller?.openEndActionPane();
                  },
                ),
              CupertinoButton(
                padding: const EdgeInsets.only(),
                child: Icon(Icons.download, color: Theme.of(context).colorScheme.primary),
                onPressed: () => router.openAnimalPdf(itemData.id),
              ),
            ],
          );
        },
      ),
    );
  }

  ActionPane _buildSlidablePane(BuildContext context) {
    return ActionPane(
      motion: const BehindMotion(),
      children: [
        if (_isEditable)
          SlidableAction(
            onPressed: (_) => router.openEdit(itemData.id),
            backgroundColor: Theme.of(context).colorScheme.surface,
            icon: Icons.edit_outlined,
            foregroundColor: Theme.of(context).colorScheme.primary,
          ),
        if (_isDeletable) _buildDeleteAction(context),
      ],
    );
  }

  Widget _buildDeleteAction(BuildContext context) {
    return SlidableAction(
      onPressed: (ctx) {
        showDialog(
          context: ctx,
          builder: (dialogCtx) {
            final msg = '${LocaleKeys.animalDeleteAcceptMsg.tr()} ${itemData.name}?';
            return CupertinoAlertDialog(
              title: Text(LocaleKeys.commonWarning.tr()),
              content: Padding(padding: const EdgeInsets.only(top: 16.0), child: Text(msg)),
              actions: [
                CupertinoButton(
                  child: Text(
                    LocaleKeys.commonDelete.tr(),
                    style: TextStyle(color: Theme.of(context).colorScheme.error),
                  ),
                  onPressed: () {
                    Navigator.of(dialogCtx).pop();
                    onDelete?.call();
                  },
                ),
                CupertinoButton(
                  child: Text(LocaleKeys.commonCancel.tr()),
                  onPressed: () => Navigator.of(dialogCtx).pop(),
                ),
              ],
            );
          },
        );
      },
      backgroundColor: Theme.of(context).colorScheme.surface,
      icon: Icons.delete_forever,
      foregroundColor: Theme.of(context).colorScheme.error,
    );
  }

  Widget _buildContent(BuildContext context) {
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
                itemData.name,
                style: Theme.of(context).textTheme.titleLarge,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Text(
              itemData.id.toString(),
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: 16.0),
              maxLines: 1,
            ),
            const SizedBox(height: 4.0),
            Padding(padding: const EdgeInsets.only(right: 28.0), child: _buildSpec(context)),
            const SizedBox(height: 8.0),
            _buildStatus(context),
            const SizedBox(height: 4.0),
            _buildAdmit(context),
          ],
        ),
      ),
    );
  }

  Row _buildStatus(BuildContext context) {
    return Row(
      children: [
        Container(
          height: 16.0,
          width: 16.0,
          decoration: BoxDecoration(color: itemData.status.dotColor, borderRadius: BorderRadius.circular(8.0)),
        ),
        const SizedBox(width: 8.0),
        Expanded(
          child: Text(
            statusLabels.label(itemData.status) ?? '',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Theme.of(context).colorScheme.onSurface),
          ),
        ),
      ],
    );
  }

  Widget _buildAvatar(BuildContext context) {
    final thumb = UrlCorsProxy.add(itemData.thumbUrl);
    return Padding(
      padding: const EdgeInsets.only(left: 12.0, top: 16.0, bottom: 16.0),
      child: SizedBox(
        height: 80.0,
        width: 80.0,
        // radius 40 = половина стороны 80 → круг; shimmer-плейсхолдер на загрузке.
        child: ShimmerNetworkImage(url: thumb, width: 80.0, height: 80.0, radius: 40.0, fallback: avatarFallback),
      ),
    );
  }

  Widget _buildAdmit(BuildContext context) {
    return Text.rich(
      TextSpan(
        children: [
          TextSpan(text: LocaleKeys.animalAdmitted.tr(), style: Theme.of(context).textTheme.bodyMedium),
          TextSpan(text: ': ', style: Theme.of(context).textTheme.bodyMedium),
          TextSpan(
            text: itemData.dateJoined?.toDateShortOnly ?? '',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Theme.of(context).colorScheme.onSurface),
          ),
        ],
      ),
      maxLines: 3,
    );
  }

  Widget _buildSpec(BuildContext context) {
    return Text.rich(
      TextSpan(
        children: [
          TextSpan(
            text: itemData.speciesParentName ?? '',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Theme.of(context).colorScheme.onSurface),
          ),
          TextSpan(text: ', ', style: Theme.of(context).textTheme.bodyLarge),
          TextSpan(
            text: itemData.speciesName ?? '',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Theme.of(context).colorScheme.onSurface),
          ),
        ],
      ),
      maxLines: 3,
    );
  }
}
