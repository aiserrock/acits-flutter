import 'package:flutter/material.dart';
import 'package:storybook_flutter/storybook_flutter.dart';
import 'package:ui_kit/ui_kit.dart';

void main() => runApp(const UiKitStorybookApp());

/// Standalone storybook for the ACITS design system (ui_kit).
///
/// One `Story` (or a small group) per exported component. The built-in
/// theme-mode plugin toggles light/dark from the panel; [_wrapper] applies the
/// real [AppTheme] so every story renders with the production tokens.
class UiKitStorybookApp extends StatelessWidget {
  const UiKitStorybookApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Storybook(wrapperBuilder: _wrapper, stories: _stories);
  }
}

/// Wraps each story in a `MaterialApp` themed with the real design-system
/// [AppTheme]. The theme-mode plugin overrides the platform brightness via
/// `MediaQuery`, so the panel toggle drives light/dark.
Widget _wrapper(BuildContext context, Widget? child) => MaterialApp(
  debugShowCheckedModeBanner: false,
  theme: AppTheme.light,
  darkTheme: AppTheme.dark,
  home: Scaffold(body: Center(child: child)),
);

final _stories = <Story>[
  Story(
    name: 'Foundations/Colors',
    description: 'ColorScheme roles + AppColors extension (light/dark via panel toggle).',
    builder: (context) => const _ColorsStory(),
  ),
  Story(
    name: 'Foundations/Typography',
    description: 'TextTheme scale rendered with the ui_kit fonts.',
    builder: (context) => const _TypographyStory(),
  ),
  Story(
    name: 'Foundations/Icons',
    description: 'icomoon IconRes glyphs + package-scoped SVG Assets.',
    builder: (context) => const _IconsStory(),
  ),
  Story(
    name: 'Foundations/Lottie',
    description: 'Package-scoped lottie animations (loader / success).',
    builder: (context) => const _LottieStory(),
  ),
  Story(
    name: 'Components/PrimaryButton',
    description: 'Accent button (fill/inline, enabled/disabled).',
    builder: (context) => PrimaryButton(
      text: context.knobs.text(label: 'Text', initial: 'Primary action'),
      isFill: context.knobs.boolean(label: 'isFill', initial: true),
      onPressed: context.knobs.boolean(label: 'Enabled', initial: true) ? () {} : null,
    ),
  ),
  Story(
    name: 'Components/UiAppBar',
    description: 'Token-driven app bar with optional back + actions.',
    builder: (context) => Scaffold(
      appBar: UiAppBar(
        title: context.knobs.text(label: 'Title', initial: 'Screen title'),
        onBack: context.knobs.boolean(label: 'Show back', initial: true) ? () {} : null,
        actions: context.knobs.boolean(label: 'Show action', initial: true)
            ? [IconButton(icon: const Icon(Icons.more_vert), onPressed: () {})]
            : null,
      ),
      body: const Center(child: Text('Body')),
    ),
  ),
  Story(
    name: 'Components/UiTextField',
    description: 'Filled token-driven text field with label/hint/icons.',
    builder: (context) => Padding(
      padding: const EdgeInsets.all(24.0),
      child: UiTextField(
        label: context.knobs.text(label: 'Label', initial: 'Email'),
        hint: context.knobs.text(label: 'Hint', initial: 'you@acits.ru'),
        obscureText: context.knobs.boolean(label: 'Obscure', initial: false),
        prefixIcon: const Icon(Icons.mail_outline),
      ),
    ),
  ),
  Story(
    name: 'Components/UiChip',
    description: 'Filter chip (selected/unselected).',
    builder: (context) => UiChip(
      label: context.knobs.text(label: 'Label', initial: 'Filter'),
      selected: context.knobs.boolean(label: 'Selected', initial: true),
      onSelected: (_) {},
    ),
  ),
  Story(
    name: 'Components/BottomSheet',
    description: 'M3 modal bottom sheet via showUiBottomSheet.',
    builder: (context) => Center(
      child: PrimaryButton(
        text: 'Open bottom sheet',
        isFill: false,
        onPressed: () => showUiBottomSheet<void>(
          context: context,
          builder: (context) => const Padding(
            padding: EdgeInsets.all(24.0),
            child: Text('Bottom sheet content', textAlign: TextAlign.center),
          ),
        ),
      ),
    ),
  ),
  Story(
    name: 'Layout/AdaptiveScaffold',
    description: 'Responsive nav (bar / rail / two-pane) — resize the window to cross breakpoints.',
    builder: (context) => const _AdaptiveScaffoldStory(),
  ),
];

class _ColorsStory extends StatelessWidget {
  const _ColorsStory();

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final appColors = context.appColors;
    final swatches = <(String, Color)>[
      ('primary', scheme.primary),
      ('onPrimary', scheme.onPrimary),
      ('secondary', scheme.secondary),
      ('surface', scheme.surface),
      ('surfaceContainerLow', scheme.surfaceContainerLow),
      ('surfaceContainerHigh', scheme.surfaceContainerHigh),
      ('error', scheme.error),
      ('outline', scheme.outline),
      ('indicatorActive', appColors.indicatorActive),
    ];
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24.0),
      child: Wrap(
        spacing: 12.0,
        runSpacing: 12.0,
        children: [
          for (final (name, color) in swatches)
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 96.0,
                  height: 64.0,
                  decoration: BoxDecoration(
                    color: color,
                    borderRadius: BorderRadius.circular(8.0),
                    border: Border.all(color: scheme.outlineVariant),
                  ),
                ),
                const SizedBox(height: 6.0),
                SizedBox(width: 96.0, child: Text(name, style: Theme.of(context).textTheme.labelSmall)),
              ],
            ),
        ],
      ),
    );
  }
}

class _TypographyStory extends StatelessWidget {
  const _TypographyStory();

  @override
  Widget build(BuildContext context) {
    final t = Theme.of(context).textTheme;
    final rows = <(String, TextStyle?)>[
      ('displaySmall', t.displaySmall),
      ('headlineMedium', t.headlineMedium),
      ('titleLarge', t.titleLarge),
      ('titleMedium', t.titleMedium),
      ('bodyLarge', t.bodyLarge),
      ('bodyMedium', t.bodyMedium),
      ('labelLarge', t.labelLarge),
      ('labelSmall', t.labelSmall),
    ];
    return ListView(
      padding: const EdgeInsets.all(24.0),
      children: [
        for (final (name, style) in rows)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 6.0),
            child: Text(name, style: style),
          ),
      ],
    );
  }
}

class _IconsStory extends StatelessWidget {
  const _IconsStory();

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme.primary;
    final fontIcons = <(String, IconData)>[
      ('animalFace', IconRes.animalFace),
      ('applicant', IconRes.applicant),
      ('curator', IconRes.curator),
      ('prescription', IconRes.prescription),
      ('calendar', IconRes.calendar),
      ('close', IconRes.close),
      ('comment', IconRes.comment),
      ('drugs', IconRes.drugs),
      ('paw', IconRes.paw),
      ('today', IconRes.today),
      ('visible', IconRes.visible),
      ('visibleOff', IconRes.visibleOff),
    ];
    final svgIcons = <(String, Widget)>[
      ('icon.paw', Assets.icon.paw.svg(width: 32.0, height: 32.0)),
      ('icon.today', Assets.icon.today.svg(width: 32.0, height: 32.0)),
      ('icon.drugs', Assets.icon.drugs.svg(width: 32.0, height: 32.0)),
      ('common.emptyState', Assets.common.emptyState.svg(width: 48.0, height: 48.0)),
      ('image.logoSplash', Assets.image.logoSplash.svg(width: 48.0, height: 48.0)),
    ];
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('IconRes (icomoon font)', style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: 12.0),
          Wrap(
            spacing: 16.0,
            runSpacing: 16.0,
            children: [
              for (final (name, icon) in fontIcons)
                SizedBox(
                  width: 88.0,
                  child: Column(
                    children: [
                      Icon(icon, size: 32.0, color: color),
                      const SizedBox(height: 4.0),
                      Text(name, style: Theme.of(context).textTheme.labelSmall, textAlign: TextAlign.center),
                    ],
                  ),
                ),
            ],
          ),
          const SizedBox(height: 32.0),
          Text('Assets (package-scoped SVG)', style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: 12.0),
          Wrap(
            spacing: 24.0,
            runSpacing: 16.0,
            children: [
              for (final (name, widget) in svgIcons)
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    widget,
                    const SizedBox(height: 4.0),
                    Text(name, style: Theme.of(context).textTheme.labelSmall),
                  ],
                ),
            ],
          ),
        ],
      ),
    );
  }
}

class _LottieStory extends StatelessWidget {
  const _LottieStory();

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(24.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          SizedBox(width: 120.0, height: 120.0, child: LoaderHolderWidget()),
          SizedBox(
            width: 160.0,
            height: 220.0,
            child: SuccessHolderWidget(title: 'Success', message: 'Everything went fine'),
          ),
        ],
      ),
    );
  }
}

class _AdaptiveScaffoldStory extends StatefulWidget {
  const _AdaptiveScaffoldStory();

  @override
  State<_AdaptiveScaffoldStory> createState() => _AdaptiveScaffoldStoryState();
}

class _AdaptiveScaffoldStoryState extends State<_AdaptiveScaffoldStory> {
  int _index = 0;

  @override
  Widget build(BuildContext context) {
    final size = WindowSize.fromWidth(MediaQuery.sizeOf(context).width);
    return AdaptiveScaffold(
      selectedIndex: _index,
      onDestinationSelected: (i) => setState(() => _index = i),
      destinations: const [
        AdaptiveDestination(icon: Icon(IconRes.today), label: 'Today'),
        AdaptiveDestination(icon: Icon(IconRes.paw), label: 'Animals'),
        AdaptiveDestination(icon: Icon(IconRes.calendar), label: 'Calendar'),
      ],
      body: Center(child: Text('Window size: ${size.name}\nSelected tab: $_index', textAlign: TextAlign.center)),
      secondaryPane: const Center(child: Text('Secondary pane (large)')),
    );
  }
}
