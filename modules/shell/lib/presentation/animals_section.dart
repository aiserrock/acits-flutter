import 'package:animals/animals.dart';
import 'package:di/di.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:localization/localization.dart';
import 'package:material_ui/material_ui.dart';
import 'package:ui_kit/ui_kit.dart';

import 'package:shell/presentation/root_screen.dart' show RootDrawerProvider;

/// The animals list wired to the app: dependencies from DI, the app drawer and
/// the app assets the `animals` module does not own.
class AnimalsList extends StatelessWidget {
  const AnimalsList({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimalsPage(
      repository: getIt<AnimalRepository>(),
      shelterProvider: getIt<CurrentShelterProvider>(),
      router: getIt<AnimalsRouterService>(),
      permissions: getIt<AnimalPermissions>(),
      statusLabels: getIt<AnimalStatusLabels>(),
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
  const AnimalsRootPage({super.key});

  @override
  Widget build(BuildContext context) {
    if (!ListDetailLayout.isSplit(context)) return const AnimalsList();
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
  const AnimalsSection({required this.child, super.key});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return ListDetailLayout(list: const AnimalsList(), detail: child);
  }
}
