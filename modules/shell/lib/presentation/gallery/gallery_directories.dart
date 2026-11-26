import 'package:ui_kit/ui_kit_gallery.dart';
import 'package:widgetbook/widgetbook.dart';

/// Мост нейтрального каталога [galleryEntries] в дерево widgetbook.
///
/// Дублирует ту же логику, что standalone example-апп (`example/lib/directories.dart`):
/// каталог живёт в `ui_kit` без зависимости на widgetbook, а конкретный
/// инструмент строит каждый хост у себя. Так debug-экран показывает ровно ту же
/// галерею компонентов, что и отдельное приложение.
List<WidgetbookNode> buildGalleryDirectories() {
  final sections = <String, List<GalleryEntry>>{};
  for (final entry in galleryEntries) {
    sections.putIfAbsent(entry.section, () => <GalleryEntry>[]).add(entry);
  }
  return [
    for (final section in sections.entries)
      WidgetbookCategory(
        name: section.key,
        children: [
          for (final e in section.value)
            WidgetbookComponent(
              name: e.name,
              useCases: [WidgetbookUseCase(name: 'Default', builder: e.builder)],
            ),
        ],
      ),
  ];
}
