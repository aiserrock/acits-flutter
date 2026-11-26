import 'package:flutter/material.dart';
import 'package:ui_kit/ui_kit.dart';

/// Растровые и иллюстративные ассеты: `image/` (PNG), `gallery/` (PNG-аватары),
/// `onboarding/` (SVG), `common/` (SVG). Все перебираются через `.values`.
///
/// Раскладка — ровный [GridView] карточек (по аналогии с Icons): у каждого
/// ассета своя [Card] с фоном `surfaceContainerLow`, рамкой `outlineVariant` и
/// подписью-именем файла. Секции разделены на группы через `SliverList`-подобный
/// `CustomScrollView` из sliver-сеток.
class ImagesPage extends StatelessWidget {
  const ImagesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Images')),
      body: CustomScrollView(
        slivers: [
          _header(context, 'Assets.image — PNG (${Assets.image.values.length})'),
          _grid([
            for (final img in Assets.image.values)
              _Cell(
                label: img.path.split('/').last,
                child: img.image(fit: BoxFit.contain),
              ),
          ]),
          _header(context, 'Assets.gallery — PNG (${Assets.gallery.values.length})'),
          _grid([
            for (final img in Assets.gallery.values)
              _Cell(
                label: img.path.split('/').last,
                clip: true,
                child: ClipOval(child: img.image(fit: BoxFit.cover)),
              ),
          ]),
          _header(context, 'Assets.onboarding — SVG (${Assets.onboarding.values.length})'),
          _grid([
            for (final svg in Assets.onboarding.values)
              _Cell(
                label: svg.path.split('/').last,
                child: svg.svg(fit: BoxFit.contain),
              ),
          ]),
          _header(context, 'Assets.common — SVG (${Assets.common.values.length})'),
          _grid([
            for (final svg in Assets.common.values)
              _Cell(
                label: svg.path.split('/').last,
                child: svg.svg(fit: BoxFit.contain),
              ),
          ]),
          const SliverToBoxAdapter(child: SizedBox(height: 24.0)),
        ],
      ),
    );
  }

  Widget _header(BuildContext context, String title) => SliverToBoxAdapter(
    child: Padding(
      padding: const EdgeInsets.fromLTRB(16.0, 24.0, 16.0, 12.0),
      child: Text(title, style: Theme.of(context).textTheme.titleMedium),
    ),
  );

  Widget _grid(List<Widget> cells) => SliverPadding(
    padding: const EdgeInsets.symmetric(horizontal: 16.0),
    sliver: SliverGrid(
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 160.0,
        mainAxisSpacing: 12.0,
        crossAxisSpacing: 12.0,
        childAspectRatio: 0.82,
      ),
      delegate: SliverChildListDelegate(cells),
    ),
  );
}

/// Ячейка сетки: карточка с превью ассета и подписью-именем файла.
class _Cell extends StatelessWidget {
  const _Cell({required this.label, required this.child, this.clip = false});

  final String label;
  final Widget child;

  /// `true` для круглых аватаров — превью само обрезано (ClipOval), карточке
  /// незачем добавлять внутренний отступ вокруг него.
  final bool clip;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Card(
      margin: EdgeInsets.zero,
      elevation: 0.0,
      color: scheme.surfaceContainerLow,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
        side: BorderSide(color: scheme.outlineVariant),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Expanded(
              child: Center(
                child: Padding(padding: EdgeInsets.all(clip ? 0.0 : 8.0), child: child),
              ),
            ),
            const SizedBox(height: 6.0),
            Text(
              label,
              style: Theme.of(context).textTheme.labelSmall,
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
