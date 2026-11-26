import 'package:animals/animals.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:localization/localization.dart';
import 'package:material_ui/material_ui.dart';
import 'package:ui_kit/ui_kit.dart';

import 'package:shell/presentation/root_screen.dart' show RootDrawerProvider;

/// Dependencies of the animals list, supplied by the route builder.
class AnimalsListDeps {
  const AnimalsListDeps({
    required this.repository,
    required this.shelterProvider,
    required this.router,
    required this.permissions,
    required this.statusLabels,
  });

  final AnimalRepository repository;
  final CurrentShelterProvider shelterProvider;
  final AnimalsRouterService router;
  final AnimalPermissions permissions;
  final AnimalStatusLabels statusLabels;
}

/// The animals list wired to the app: dependencies from [deps], the app drawer
/// and the app assets the `animals` module does not own.
class AnimalsList extends StatelessWidget {
  const AnimalsList({required this.deps, super.key});

  final AnimalsListDeps deps;

  @override
  Widget build(BuildContext context) {
    return AnimalsPage(
      repository: deps.repository,
      shelterProvider: deps.shelterProvider,
      router: deps.router,
      permissions: deps.permissions,
      statusLabels: deps.statusLabels,
      onMenuPressed: RootDrawerProvider.of(context)?.openDrawer,
      emptyStateIllustration: Assets.common.emptyState.svg(),
      avatarFallback: Assets.image.animalStub.image(fit: BoxFit.cover, width: 80.0, height: 80.0),
    );
  }
}

/// Root page of the animals tab (`/animals`).
///
/// On a narrow window it is the list; the card is pushed over it. On a wide
/// window the list lives in the left pane of [AnimalsSection], so this page is
/// the empty right pane until an animal is picked.
class AnimalsRootPage extends StatelessWidget {
  const AnimalsRootPage({required this.deps, super.key});

  final AnimalsListDeps deps;

  @override
  Widget build(BuildContext context) {
    if (!ListDetailLayout.isSplit(context)) return AnimalsList(deps: deps);
    final color = Theme.of(context).colorScheme.onSurfaceVariant;
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Assets.icon.paw.svg(width: 48.0, height: 48.0, colorFilter: ColorFilter.mode(color, BlendMode.srcIn)),
            const SizedBox(height: 16.0),
            Text(LocaleKeys.prescriptionPickAnimalMsg.tr(), style: TextStyle(color: color, fontSize: 16.0)),
          ],
        ),
      ),
    );
  }
}

/// The animals tab: list and card side by side on wide windows.
///
/// [child] is the navigator of the tab (the root page and the card pushed on it).
class AnimalsSection extends StatelessWidget {
  const AnimalsSection({required this.deps, required this.child, super.key});

  final AnimalsListDeps deps;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return ListDetailLayout(
      list: AnimalsList(deps: deps),
      detail: child,
    );
  }
}
