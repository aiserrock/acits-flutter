import 'package:acits_flutter/di/di_container.dart';
import 'package:acits_flutter/navigation/app_router.dart';
import 'package:acits_flutter/service/animal/animal_service.dart';
import 'package:acits_flutter/service/auth/auth_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:go_router/go_router.dart';

import 'package:acits_flutter/export.dart';
import 'package:acits_flutter/ui/widget/shimmer_network_image.dart';

/// Карточка животного в списке
class AnimalCardWidget extends StatelessWidget {
  AnimalCardWidget(this.itemData, {this.onDelete, super.key})
    : isEditable = getIt<AuthService>().shelterRole?.isUserCanEdit ?? false,
      isDeletable = getIt<AuthService>().shelterRole?.isUserCanDelete ?? false,
      _animalService = getIt<AnimalService>();

  final AnimalRead? itemData;
  final VoidCallback? onDelete;
  final bool isEditable;
  final bool isDeletable;

  final AnimalService _animalService;

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
              onPressed: () => _navigateDetail(context),
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
                    SlidableController? controller = Slidable.of(context);
                    controller?.openEndActionPane();
                  },
                ),
              Builder(
                builder: (context) {
                  return CupertinoButton(
                    padding: const EdgeInsets.only(),
                    child: Icon(Icons.download, color: Theme.of(context).colorScheme.primary),
                    onPressed: () {
                      final animalId = itemData?.id;
                      if (animalId == null) return;
                      context.push(
                        AppRoutes.docViewer,
                        extra: <String, Object?>{
                          'fetcher': () => _animalService.fetchPdfAnimalCard(animalId),
                          'title': 'Animal $animalId',
                          'fileName': 'animal_$animalId.pdf',
                        },
                      );
                    },
                  );
                },
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
        //TODO: утвердить реализацию (нет в ТЗ)
        // SlidableAction(
        //   onPressed: (_) {},
        //   backgroundColor: Theme.of(context).colorScheme.surface,
        //   icon: IconRes.prescription,
        //   foregroundColor: Theme.of(context).colorScheme.primary,
        // ),
        // SlidableAction(
        //   onPressed: (_) {},
        //   backgroundColor: Theme.of(context).colorScheme.surface,
        //   icon: IconRes.comment,
        //   foregroundColor: Theme.of(context).colorScheme.primary,
        // ),
        if (isEditable)
          SlidableAction(
            onPressed: (_) => context.push(
              itemData?.id == null ? AppRoutes.animalEdit : '${AppRoutes.animalEdit}?id=${itemData!.id}',
            ),
            backgroundColor: Theme.of(context).colorScheme.surface,
            icon: Icons.edit_outlined,
            foregroundColor: Theme.of(context).colorScheme.primary,
          ),

        if (isDeletable) _buildDeleteAction(context),
      ],
    );
  }

  Widget _buildDeleteAction(BuildContext context) {
    return SlidableAction(
      onPressed: (ctx) {
        showDialog(
          context: ctx,
          builder: (dialogCtx) {
            final msg = '${LocaleKeys.animalDeleteAcceptMsg.tr()} ${itemData?.name ?? ""}?';
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
                  onPressed: () {
                    Navigator.of(dialogCtx).pop();
                  },
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
                itemData?.name ?? '',
                style: Theme.of(context).textTheme.titleLarge,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Text(
              itemData?.id?.toString() ?? '',
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
          decoration: BoxDecoration(color: itemData?.statusColor, borderRadius: BorderRadius.circular(8.0)),
        ),
        const SizedBox(width: 8.0),
        Expanded(
          child: Text(
            itemData?.statusString ?? '',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Theme.of(context).colorScheme.onSurface),
          ),
        ),
      ],
    );
  }

  Widget _buildAvatar(BuildContext context) {
    final thumb = UrlCorsProxy.add(itemData?.thumb);
    return Padding(
      padding: const EdgeInsets.only(left: 12.0, top: 16.0, bottom: 16.0),
      child: SizedBox(
        height: 80.0,
        width: 80.0,
        // radius 40 = половина стороны 80 → круг; shimmer-плейсхолдер на загрузке.
        child: ShimmerNetworkImage(url: thumb, width: 80.0, height: 80.0, radius: 40.0),
      ),
    );
  }

  Widget _buildAdmit(BuildContext context) {
    return Text.rich(
      TextSpan(
        children: [
          TextSpan(text: LocaleKeys.animalAdmitted.tr(), style: Theme.of(context).textTheme.bodyMedium),
          TextSpan(text: (': '), style: Theme.of(context).textTheme.bodyMedium),
          TextSpan(
            text: itemData?.dateJoined.toDateShortOnly ?? '',
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
            text: (itemData?.spec?.parentName ?? ''),
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Theme.of(context).colorScheme.onSurface),
          ),
          TextSpan(text: (', '), style: Theme.of(context).textTheme.bodyLarge),
          TextSpan(
            text: itemData?.spec?.name ?? '',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Theme.of(context).colorScheme.onSurface),
          ),
        ],
      ),
      maxLines: 3,
    );
  }

  void _navigateDetail(BuildContext context) {
    if (itemData?.id == null) return;
    context.push(AppRoutes.animalDetailPath(itemData!.id!));
  }

  bool get _hasActions => isEditable || isDeletable;
}
