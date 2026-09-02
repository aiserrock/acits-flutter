import 'package:ui_kit/ui_kit_gallery.dart';
import 'package:widgetbook/widgetbook.dart';

/// Мост: общий каталог [galleryEntries] (живёт в ui_kit, без зависимости на
/// widgetbook) → дерево [WidgetbookNode]. Секции становятся категориями, каждый
/// экспонат — компонентом с единственным use-case «Default».
///
/// Тот же мост повторяет debug-экран в основном приложении — так example и app
/// показывают идентичный каталог из одного источника правды.
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
